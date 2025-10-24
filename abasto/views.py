
import json
from django.http import JsonResponse
from rest_framework import viewsets
from .serializer import UsurioSerializer
from .models import usuarios
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .nameSP import nameSP
from django.db import connection
from datetime import date, datetime
from django.contrib.auth.hashers import make_password, check_password
    
@api_view(['GET','POST'])
def loginViewPost(request):
    if request.method == 'POST':
        try:
            # Recibe los datos de la solicitud
            data_request = request.data
            cedula = data_request.get('Cedula')
            clave_plana = data_request.get('Password')
            
            # LLama al SP para buscar el usuario
            json_data_id = json.dumps({"Cedula": cedula})
            cur = connection.cursor()
            
            cur.callproc(nameSP.loginUsuario, [json_data_id, 'login'])
            usuario_db = dictfecthall(cur)
            cur.close()
            
            if usuario_db:
                usuario = usuario_db[0]
                clave_hash_db = usuario.get('clave')
                ultimo_login_db = usuario.get('ultimoLogin')
                
                if check_password(clave_plana, clave_hash_db):
                    # Credenciales correctas
                    es_primer_login = ultimo_login_db is None
                    
                    # Actualizar el campo de ultimoLogin si es el primer login
                    with connection.cursor() as update_cursor:
                        update_cursor.execute(
                            "UPDATE abasto_usuarios SET ultimoLogin = NOW() WHERE id = %s", 
                            [usuario.get('id')]
                        )
                    data = {
                        "id": usuario.get('id'),
                        "cedula": usuario.get('cedula'),
                        "nombres": usuario.get('nombres'),
                        "apellidos": usuario.get('apellidos'),
                        "idrol": usuario.get('idrol'),
                        "primerLogin": es_primer_login
                    }
                    return Response(data, status=200)
                return Response({"mensaje": "Usuario o clave incorrecta"}, status=401)
            
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)        

@api_view(['GET','POST'])
def obtenerUsuarioViewGet(request, IdUsuario=None):
    if request.method == 'GET':
        cur = connection.cursor()
        #Obtener los parametros de la solicitud
        idUsuario = request.GET.get('IdUsuario', None)
        transaccion = request.GET.get('Transaccion', None)
        
        #Llamar al procedimiento almacenado
        cur.callproc(nameSP.loginUsuario, [IdUsuario,transaccion])
        results = cur.fetchall()
        listData =[]

        for row in results:
            data = {
                "id": row[0],
                "cedula": row[1],
                "nombres": row[2],
                "apellidos": row[3],
                "rol": row[5],
                "idrol": row[6],
                "idEstado": row[7],
                "estado": row[8],
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        #Si se pidio un usuario especifico, devolver solo ese usuario en lugar de la lista
        if IdUsuario and listData:
            return Response(listData[0])
        
        return Response(listData)
@api_view(['GET','POST'])
def obtenerUsuarioViewGet(request, IdUsuario=None):
    if request.method == 'GET':
        cur = connection.cursor()
        #Obtener los parametros de la solicitud
        idUsuario = request.GET.get('IdUsuario', None)
        transaccion = request.GET.get('Transaccion', None)
        
        #Llamar al procedimiento almacenado
        cur.callproc(nameSP.loginUsuario, [IdUsuario,transaccion])
        results = cur.fetchall()
        listData =[]

        for row in results:
            data = {
                "id": row[0],
                "cedula": row[1],
                "nombres": row[2],
                "apellidos": row[3],
                "rol": row[5],
                "idrol": row[6],
                "idEstado": row[7],
                "estado": row[8],
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        #Si se pidio un usuario especifico, devolver solo ese usuario en lugar de la lista
        if IdUsuario and listData:
            return Response(listData[0])
        
        return Response(listData)

@api_view(['GET','POST'])
def getRolViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion', None)

        cur.callproc(nameSP.obtenerRol, [transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "IdRol": row[0],
                "NombreRol": row[1],
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        return Response(listData)
    
@api_view(['GET','POST'])
def registrarViewPost(request, id=None):
    if request.method == 'POST':
        try:
            # Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            data_request = request.data
            # Verificar si la transaccion tiene manejo de clave
            if transaccion in ['registrar', 'editar_usuario', 'cambiar_clave']:
                clave_plana = data_request.get('Password')
                
                # Si se proporciono una clave, hashearla
                if clave_plana:
                    # Hasheo de clave
                    clave_hasheada = make_password(clave_plana)
                    
                    # Crear una copia de los datos para no modificar los datos recibidos
                    datos_modificados = data_request.copy()
                    # Reemplazar la clave plana con la clave hasheada
                    datos_modificados['Password'] = clave_hasheada
                    
                    # Preparar el JSON modificado
                    json_data = json.dumps(datos_modificados)
                else:
                    # Si no hay clave, usar los datos originales
                    if transaccion == 'cambiar_clave' and not clave_plana:
                        return Response({"mensaje":"La nueva contraseña es requerida"}, status=400)
                    json_data = json.dumps(data_request)
            else:
                json_data = json.dumps(data_request)
            if transaccion == 'registrar':
                cur = connection.cursor()
                # El SP recibe el JSON con la clave hasheada
                cur.callproc(nameSP.registrarUsuario, [json_data, transaccion])
                cur.close()
                return Response({"mensaje":"Usuario registrado correctamente"},status=201)
            
            elif transaccion == 'editar_usuario' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.registrarUsuario, [json_data, transaccion])
                cur.close()
                return Response({"mensaje":"Usuario actualizado correctamente"},status=200)
            
            elif transaccion == 'eliminar_usuario' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.registrarUsuario, [json_data, transaccion])
                cur.close()
                return Response({"mensaje":"Usuario eliminado correctamente"},status=200)
            elif transaccion == 'cambiar_clave':
                if not data_request.get('IdUsuario'):
                    return Response({"mensaje": "Se requiere el ID del usuario para cambiar la clave"}, status=400)
                
                cur = connection.cursor()
                cur.callproc(nameSP.registrarUsuario,[json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Clave actualizada correctamente"}, status=200)
            else:
                return Response({"mensaje":"Transacción no válida"},status=400)
        except Exception as e:
            return Response({"mensaje":str(e)},status=400)
        
@api_view(['POST'])
def agregarProductoViewPost(request, id=None):
    if request.method == 'POST':
        try:
            # Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            # Definir las acciones a realizar según la transacción
            if transaccion == 'agregar_producto':
                # Llamar al procedimiento almacenado para agregar el producto
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProducto, [json_data, transaccion])
                # Obtener el ID del producto agregado
                cur.execute("SELECT LAST_INSERT_ID()")
                Id_Producto = cur.fetchone()[0]
                cur.close()
                return Response({"mensaje": "Producto registrado correctamente", "IdProducto": Id_Producto}, status=201)

            elif transaccion == 'editar_producto' and id is not None:
                # Llamar al procedimiento almacenado para editar el producto
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProducto, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Producto actualizado correctamente"}, status=200)
            
            elif transaccion == 'editar_stock' and id is not None:
                # Llamar al procedimiento almacenado para editar el producto
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProducto, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Stock del producto restado correctamente"}, status=200)

            elif transaccion == 'editar_stock_pedido' and id is not None:
                # Llamar al procedimiento almacenado para editar el producto
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProducto, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Stock de pedido actualizado correctamente"}, status=200)

            elif transaccion == 'eliminar_producto' and id is not None:
                # Llamar al procedimiento almacenado para eliminar el producto
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProducto, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Producto eliminado correctamente"}, status=200)

            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)

        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)


@api_view(['GET','POST'])
def getProductoViewGet(request, IdProducto=None):
    if request.method == 'GET':
            cur = connection.cursor()
            #Obtener los parametros de la solicitud
            IdProducto = request.GET.get('IdProducto', None)
            transaccion = request.GET.get('Transaccion', None)

            datos_json = json.dumps({"IdProducto":IdProducto})
            
            #Llamar al procedimiento almacenado con el Id si está presente
            cur.callproc(nameSP.obtenerProducto, [datos_json, transaccion])
            results = cur.fetchall()
            listData = []
            for row in results:
                fecha_vencimiento = row[18]
                if isinstance(fecha_vencimiento, (datetime, date)):  # Si es un objeto `datetime` o `date`
                    fecha_vencimiento = fecha_vencimiento.strftime('%Y-%m-%d')  # Convertir a formato 'YYYY-MM-DD'
            
                data = {
                    "Id_Producto": row[0],
                    "Codigo_Producto": row[1],
                    "Nombre_Producto": row[2],
                    "Id_Marca": row[3],
                    "Nombre_Marca": row[4],
                    "Id_Proveedor": row[5],
                    "Stock": row[6],
                    "Stock_Maximo": row[7],
                    "Stock_Minimo": row[8],
                    "Porcentaje_Ganancia": float(row[9]),
                    "Nombre_Proveedor": row[10],
                    "Precio_Compra": float(row[11]),
                    "Id_Categoria": row[12],
                    "Categoria": row[13],
                    "IdEstado": row[14],
                    "Impuesto_Producto": row[15],
                    "Venta_Granel": row[16],
                    "Es_Perecible": row[17],
                    "Fecha_Vencimiento": fecha_vencimiento,
                    "Estado": row[19],
                    "IdUnidad_Conversion_Venta": row[20],
                    "StockPedido": float(row[21]),
                    "UnidadVenta": row[22]
                }
                json_data = json.dumps(data)
                jd = json.loads(json_data)
                listData.append(jd)
            cur.close()

            # Si se pidio un producto especifico, devolver solo ese producto en lugar de la lista
            if IdProducto and listData:
                return Response(listData[0]) #devolver el primer producto encontrado
            
            return Response(listData) #devolver la lista de productos completa si no hay un Id especifico

@api_view(['GET', 'POST'])
def getPrecioVentaViewGet(request):
    if request.method == 'GET':
        # Obtener los parámetros de la URL
        id_producto = request.GET.get('IdProducto', None)  # Ahora directamente un número
        transaccion = request.GET.get('Transaccion', None)

        print("Recibiendo parámetros:")
        print("IdProducto:", id_producto)
        print("Transaccion:", transaccion)

        if not id_producto or not transaccion:
            return Response({"error": "Faltan parámetros en la solicitud."}, status=400)

        # Verificación de que el valor de Transaccion sea válido
        if transaccion != 'consulta_precio_venta':
            return Response({"error": f"Transacción no válida: {transaccion}"}, status=400)

        # Verificación de que el valor de IdProducto sea un número entero
        try:
            id_producto = int(id_producto)
        except ValueError:
            return Response({"error": "El valor de 'IdProducto' debe ser un número entero."}, status=400)

        # Llamada al procedimiento almacenado
        try:
            cur = connection.cursor()
            print("Ejecutando el procedimiento almacenado con IdProducto:", id_producto, "y Transaccion:", transaccion)

            # Llamamos al procedimiento pasando el número directamente
            cur.callproc('GetPrecio', [id_producto, transaccion])

            # Recuperamos todos los resultados de la consulta
            results = cur.fetchall()

            listData = []
            for row in results:
                data = {
                    "IdPrecio": row[0],
                    "IdProducto": row[1],
                    "IdUnidadMedida": row[2],
                    "UnidadMedida": row[3],
                    "PrecioVenta": float(row[4]),
                }
                json_data = json.dumps(data)
                jd = json.loads(json_data)
                listData.append(jd)

            cur.close()

            if listData:
                return Response(listData)
            else:
                return Response({"message": "No se encontraron productos para el IdProducto proporcionado."}, status=200)

        except Exception as e:
            print("Error al ejecutar el procedimiento almacenado:", e)
            return Response({"error": "Error al ejecutar el procedimiento."}, status=500)



@api_view(['POST'])
def agregarPrecioVentaViewPost(request, id=None):
    if request.method == 'POST':
        try:
            # Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_precio_venta':
                # Llamar al procedimiento almacenado para agregar el precio de venta
                cur = connection.cursor()
                cur.callproc(nameSP.agregarPrecio, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Precio de venta registrado correctamente"}, status=200)
            
            elif transaccion == 'editar_precio_venta' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.agregarPrecio, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Precio de venta actualizado correctamente"}, status=200)
            
            elif transaccion == 'eliminar_precio_venta' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.agregarPrecio, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Precio de venta eliminado correctamente"}, status=200)

            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)

@api_view(['GET','POST'])
def agregarCategoriaViewPost(request):
    if request.method == 'POST':
        try:
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_categoria':
                cur = connection.cursor()
                cur.callproc(nameSP.agregarCategoria, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Categoria registrada correctamente"}, status=201)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)
        

@api_view(['GET','POST'])
def getCategoriaViewGet(request):
    if request.method == 'GET':
            cur = connection.cursor()
            transaccion = request.GET.get('Transaccion', None)

            cur.callproc(nameSP.obtenerCategoria, [transaccion])
            results = cur.fetchall()
            listData = []
            for row in results:
                data = {
                    "Id_Categoria": row[0],
                    "Nombre_Categoria": row[1]
                }
                json_data = json.dumps(data)
                jd = json.loads(json_data)
                listData.append(jd)
            cur.close()

            return Response(listData)

@api_view(['GET','POST'])
def agregarMarcaViewPost(request):
    if request.method == 'POST':
        try:
            #Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_marca':
                cur = connection.cursor()
                cur.callproc(nameSP.agregarMarca, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Marca registrada correctamente"}, status=200)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)
        
@api_view(['GET','POST'])
def agregarUnidadViewPost(request):
    if request.method == 'POST':
        try:
            #Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_unidad':
                cur = connection.cursor()
                cur.callproc(nameSP.agregarUnidad, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Unidad registrada correctamente"}, status=200)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)
        
@api_view(['GET','POST'])
def agregarProveedorViewPost(request):
    if request.method == 'POST':
        try:
            #Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_proveedor':
                cur = connection.cursor()
                cur.callproc(nameSP.agregarProveedor, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Proveedor registrado correctamente"}, status=200)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)

@api_view(['GET','POST'])
def getMarcaViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion', None)

        cur.callproc(nameSP.obtenerMarca, [transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "IdMarca": row[0],
                "NombreMarca": row[1],
                "EstadoMarca": row[2]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        return Response(listData)
    
@api_view(['GET','POST'])
def getUnidadViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion', None)

        cur.callproc(nameSP.obtenerUnidad, [transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "IdUnidad": row[0],
                "NombreUnidad": row[1],
                "EstadoUnidad": row[2]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        return Response(listData)

@api_view(['GET','POST'])
def getEstadosViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion', None)

        cur.callproc(nameSP.obtenerEstados, [transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "Id_Estado": row[0],
                "Nombre_Estado": row[1]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        return Response(listData)
    
@api_view(['GET','POST'])
def getProveedorViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion', None)

        cur.callproc(nameSP.obtenerProveedor, [transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "IdProveedor": row[0],
                "RucProveedor": row[1],
                "NombreProveedor": row[2],
                "TelefonoProveedor": row[3],
                "Estado_Proveedor": row[4]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        return Response(listData)

@api_view(['GET','POST'])
# def getMedidasConversionViewGet(request, IdMedida=None):
def getMedidasConversionViewGet(request):
    #Obtener los parametros de la URL
    if request.method == 'GET':
        cur = connection.cursor()
        IdMedida = request.GET.get('Id_Medida', None) 
        transaccion = request.GET.get('Transaccion',None)

        datos_json = json.dumps({"Id_Medida": IdMedida})

        #Llamar al procedimiento almacenado con el Id si está presente
        cur.callproc(nameSP.obtenerMedidasConversion, [datos_json,transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "Id_Medida": row[0],
                "Id_Unidad_Principal": row[1],
                "Nombre_Medida_Principal": row[2],
                "Id_Unidad_Convertir": row[3],
                "Nombre_Medida_Convertir": row[4],
                "Factor_Conversion": float(row[5]),
                "Estado_Medida": row[6]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        # Si se pidio una medida especifica, devolver solo esa medida en lugar de la lista
        if IdMedida and listData:
            return Response(listData[0])
        return Response(listData)

@api_view(['POST'])
def agregarMedidasConversionViewPost(request, id=None):
    if request.method == 'POST':
       try:
           #Obtener los datos de la solicitud
           transaccion = request.data.get('Transaccion', '')
           json_data = json.dumps(request.data)

           if transaccion == 'agregar_medida_conversion':
               cur = connection.cursor()
               cur.callproc(nameSP.agregarMedidaConversion, [json_data, transaccion])
               cur.close()
               return Response({"mensaje": "Medida de conversión registrada correctamente"}, status=200)
           
           elif transaccion == 'editar_medida_conversion' and id is not None:
                # Llamar al procedimiento almacenado para editar la medida de conversión
                cur = connection.cursor()
                cur.callproc(nameSP.agregarMedidaConversion, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Medida de conversión actualizada correctamente"}, status=200)
           
           elif transaccion == 'eliminar_medida_conversion' and id is not None:
                # Llamar al procedimiento almacenado para eliminar la medida de conversión
                cur = connection.cursor()
                cur.callproc(nameSP.agregarMedidaConversion, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Medida de conversión eliminada correctamente"}, status=200)
           
           else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
           
       except Exception as e:
            return Response({"mensaje": str(e)}, status=400)

@api_view(['GET','POST'])
def getStockProductoViewGet(request, Id_Producto):
    #Obtener los parametros de la URL
    if request.method == 'GET':
        cur = connection.cursor()
        # IdProducto = request.GET.get('IdProducto', None) 
        transaccion = request.GET.get('Transaccion',None)

        # datos_json = json.dumps({"IdProducto": IdProducto})
        datos_json = json.dumps({"Id_Producto": Id_Producto})
        #Llamar al procedimiento almacenado con el Id si está presente
        cur.callproc(nameSP.obtenerStockProducto, [datos_json,transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "Id_Stock": row[0],
                "Id_Producto": row[1],
                "Cantidad_Stock": float(row[2]),
                "Fecha_Ingreso": row[3]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()

        # Si se pidio un stock especifico, devolver solo ese stock en lugar de la lista
        # if Id_Producto and listData:
        #     return Response(listData[0])
        return Response(listData)

@api_view(['POST'])
def agregarStockProductoViewPost(request, id=None):
    if request.method == 'POST':
        try:
            # Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_stock_producto' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.agregarStockProducto, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Stock de producto agregado correctamente"}, status=200)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)
        
@api_view(['GET','POST'])
def getIvaViewGet(request,IdIva=None):
    if request.method == 'GET':
        cur = connection.cursor()
        #Obtener los parámetros de la solicitud
        transaccion = request.GET.get('Transaccion',None)

        #Llamar al procedimiento almacenado
        cur.callproc(nameSP.obtenerIva,[IdIva,transaccion])
        results = cur.fetchall()
        listData = []

        for row in results:
            data = {
                "IdIva": row[0],
                "DescripcionIva": row[1],
                "PorcentajeIva": float(row[2])
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        
        #Si se pidió un IVA específico, devolver solo ese IVA en lugar de la lista
        if IdIva and listData:
            return Response(listData[0])
        return Response(listData)
        

@api_view(['POST'])
def agregarIvaViewPost(request, id=None):
    if request.method == 'POST':
        try:
            #Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion', '')
            json_data = json.dumps(request.data)

            if transaccion == 'agregar_iva':
                cur = connection.cursor()
                cur.callproc(nameSP.agregarIva, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Iva registrado correctamente"}, status=200)
            elif transaccion == 'editar_iva' and id is not None:
                cur = connection.cursor()
                cur.callproc(nameSP.agregarIva, [json_data, transaccion])
                cur.close()
                return Response({"mensaje": "Iva actualizado correctamente"}, status=200)
            else:
                return Response({"mensaje": "Transacción no válida"}, status=400)
        except Exception as e:
            return Response({"mensaje": str(e)}, status=400)

@api_view(['POST'])
def agregarPedidoViewPost(request, id=None):
        try:
            #Obtener los datos de la solicitud
            transaccion = request.data.get('Transaccion','')
            json_data = json.dumps(request.data)
            
            cur = connection.cursor()
            
            if transaccion == 'agregar_pedido':
                # Llamar al SP para crear el pedido principal
                cur.callproc(nameSP.agregarPedido,[json_data,transaccion])
                
                # Obtener resultados si el SP devuelve algo
                results = cur.fetchall()
                cur.close()
                
                if results:
                    #El SP devuelve: (IdPedido,CodigoPedido)
                    return Response({
                        "mensaje": "Pedido creado correctamente",
                        "IdPedido": results[0][0],
                        "CodigoPedido": results[0][1]
                    },status=200)
                    
            elif transaccion == 'editar_pedido' and id is not None:
                # Llamar al SP para editar el pedido
                cur.callproc(nameSP.agregarPedido,[json_data,transaccion])
                cur.close()
                return Response({"mensaje": "Pedido actualizado correctamente"},status=200)
            elif transaccion == 'cancelar_pedido' and id is not None:
                # Llamar al SP para editar el pedido
                cur.callproc(nameSP.agregarPedido,[json_data,transaccion])
                cur.close()
                return Response({"mensaje": "Pedido actualizado correctamente"},status=200)
            elif transaccion == 'facturar_pedido' and id is not None:
                # Llamar al SP para editar el pedido
                cur.callproc(nameSP.agregarPedido,[json_data,transaccion])
                cur.close()
                return Response({"mensaje": "Pedido facturado correctamente"},status=200)
            else:
                return Response({"mensaje":"Transaccion no válida"},status=400)
        except Exception as e:
            return Response({"mensaje": str(e)},status=400)
        
@api_view(['POST'])
def agregarDetallePedidoViewPost(request):
    try:
        transaccion = request.data.get('Transaccion','')
        json_data = json.dumps(request.data)
        
        cur = connection.cursor()
        if transaccion in ['agregar_detalle_pedido', 'eliminar_producto_detalle']:
            cur.callproc(nameSP.agregarDetallePedido, [json_data, transaccion])
        else:
            cur.close()
            return Response({"mensaje":"Transaccion no válida"},status=400)
        
        cur.close()
        return Response({"mensaje": "Operación realizada correctamente"}, status=200)
        
    except Exception as e:
        return Response({"mensaje": str(e)},status=400)
        
@api_view(['GET','POST'])
def getPedidoViewGet(request):
    if request.method == 'GET':
        cur = connection.cursor()
        transaccion = request.GET.get('Transaccion',None)
        
        cur.callproc(nameSP.obtenerPedido,[transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            data = {
                "IdPedido": row[0],
                "CodigoPedido": row[1],
                "ClientePedido": row[2],
                "SubtotalPedido": float(row[3]),
                "IvaPedido": float(row[4]),
                "TotalPedido": float(row[5]),
                "IdEstado": row[6],
                "EstadoPedido": row[7],
                "FechaPedido": row[8]
            }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        return Response(listData)        

@api_view(['GET','POST'])
def getDetallePedidoViewGet(request):
    if request.method == 'GET':
        # Obtener los parámetros de la URL
        id_pedido = request.GET.get('IdPedido',None)
        transaccion = request.GET.get('Transaccion',None)
        
    if not id_pedido or not transaccion:
        return Response({"error": "Faltan parámetros en la solicitud"}, status = 400)
    
    #Permitir ambas transacciones
    if transaccion not in ['consulta_detalle_pedido','consulta_general','consulta_detalle_pedido_cancelado']:
        return Response({"error": f"Transacción no válida: {transaccion}"}, status=400)
    
    try:
        cur = connection.cursor()
        cur.callproc(nameSP.obtenerDetallePedido,[id_pedido,transaccion])
        results = cur.fetchall()
        listData = []
        for row in results:
            # if transaccion == 'consulta_detalle_pedido':
            if transaccion in ['consulta_detalle_pedido','consulta_detalle_pedido_cancelado']:
                data = {
                    "IdDetallePedido": row[0],
                    "IdProducto": row[1],
                    "CodigoProducto": row[2],
                    "NombreProducto": row[3],
                    "Marca": row[4],
                    "Cantidad": float(row[5] or 0),
                    "PrecioUnitario": float(row[6] or 0),
                    "ModoVenta": row[7],
                    "IdUnidadMedida": row[8],
                    "IdPrecioVenta": row[9],
                    "ImpuestoProducto": row[10],
                    "PorcentajeIva": float(row[11] or 0),
                    "SubTotalProducto": float(row[12] or 0),
                    "IvaProducto": float(row[13] or 0 ),
                    "Total": float(row[14] or 0),
                    "NecesitaConversion": row[15],
                    "FactorConversion": float(row[16] or 0),
                    "IdConversionVenta": row[17]
                }
            else:
                data = {
                    "IdDetallePedido": row[0],
                    "Producto": row[1],
                    "Cantidad": float(row[2]),
                    "ModoVenta": row[3],
                    "SubTotalProducto": float(row[4]),
                    "IvaProducto": float(row[5])
                }
            json_data = json.dumps(data)
            jd = json.loads(json_data)
            listData.append(jd)
        cur.close()
        
        if listData:
            return Response(listData)
        else:
            return Response({"message": "No se encontró detalle de pedido para el IdPedido proporcionado."}, status=200)
    except Exception as e:
        return Response({"error": "Error al ejecutar el procedimiento."},e, status=500)

    try:
        transaccion = request.data.get('Transaccion','')
        json_data = json.dumps(request.data)
        
        cur = connection.cursor()
        
        if transaccion == 'generar_factura':
            cur.callproc(nameSP.agregarFactura,[json_data,transaccion])
            
            all_results = []
            while True:
                try:
                    results = cur.fetchall()
                    all_results.append(results)
                    print(f"📋 Resultado del SP: {results}")
                except:
                    break
                
                if not cur.nextset():
                    break
            
            cur.close()
            
            # Buscar el resultado que tenga IdFactura y CodigoFactura
            id_factura = None
            codigo_factura = None
            
            for result_set in all_results:
                if result_set and len(result_set) > 0:
                    # Buscar un resultado con 2 columnas (IdFactura, CodigoFactura)
                    if len(result_set[0]) == 2:
                        id_factura = result_set[0][0]
                        codigo_factura = result_set[0][1]
                        break
            
            if id_factura and codigo_factura:
                return Response({
                    "mensaje": "Factura creada correctamente",
                    "IdFactura": id_factura,
                    "CodigoFactura": codigo_factura 
                }, status=200)
            else:
                # Si no encontramos el resultado esperado, mostrar todos los resultados para debug
                print(f"🔍 Todos los resultados: {all_results}")
                return Response({"mensaje": "Error al generar factura - no se obtuvieron los datos esperados"}, status=400)
        else:
            return Response({"mensaje":"Transaccion no válida"}, status=400)
    except Exception as e:
        print(f"❌ ERROR en agregarFacturaViewPost: {str(e)}")
        return Response({"mensaje": str(e)}, status=400)
@api_view(['POST'])
def agregarFacturaViewPost(request, id=None):
    try:
        transaccion = request.data.get('Transaccion','')
        json_data = json.dumps(request.data)
        
        cur = connection.cursor()
        
        if transaccion == 'generar_factura':
            # Llamar al SP SIN debug
            cur.callproc(nameSP.agregarFactura,[json_data,transaccion])
            
            # 🔧 SOLUCIÓN SIMPLE: Solo obtener el primer resultado
            results = cur.fetchall()
            cur.close()
            
            if results and len(results) > 0:
                # El SP devuelve: (IdFactura, CodigoFactura)
                return Response({
                    "IdFactura": results[0][0],
                    "CodigoFactura": results[0][1] 
                }, status=200)
            else:
                return Response({"mensaje": "No se pudo generar la factura"}, status=400)
        else:
            return Response({"mensaje":"Transaccion no válida"}, status=400)
    except Exception as e:
        print(f"❌ ERROR en agregarFacturaViewPost: {str(e)}")
        return Response({"mensaje": str(e)}, status=400)
    
@api_view(['POST'])
def agregarDetalleFactura(request):
    try:
        transaccion = request.data.get('Transaccion','')
        json_data = json.dumps(request.data)
        
        cur = connection.cursor()
        # if transaccion in ['agregar_detalle_factura', 'eliminar_producto_detalle']:
        if transaccion in ['agregar_detalle_factura']:
            cur.callproc(nameSP.agregarDetalleFactura, [json_data, transaccion])
        else:
            cur.close()
            return Response({"mensaje":"Transaccion no válida"},status=400)
        
        cur.close()
        return Response({"mensaje": "Operación realizada correctamente"}, status=200)
        
    except Exception as e:
        return Response({"mensaje": str(e)},status=400)
   
@api_view(['POST'])
def agregarClienteViewPost(request, codigo=None, tipo=None):
    try:
        # Obtener los datos de la solicitud
        transaccion = request.data.get('Transaccion', '')
        
        # PREPARAR JSON PARA EL SP
        datos_para_sp = request.data.copy()
        
        if transaccion == 'registrar_cliente':
            # Para registro: usar los datos que vienen en el request.data
            codigo_identificacion = request.data.get('CodigoIdentificacion')
            codigo_tipo_id = request.data.get('CodigoTipoId')
            
            # Validar que existan los datos necesarios para registro
            if not codigo_identificacion or not codigo_tipo_id:
                return Response({"mensaje": "Faltan datos de identificación para registrar cliente"}, status=400)
                
        elif transaccion == 'actualizar_cliente' and codigo is not None and tipo is not None:
            # Para actualización: agregar los parámetros de la URL al JSON
            datos_para_sp['CodigoIdentificacion'] = codigo
            datos_para_sp['CodigoTipoId'] = tipo
        
        json_data = json.dumps(datos_para_sp)
        
        cur = connection.cursor()
        
        if transaccion == 'registrar_cliente':
            cur.callproc('SetCliente', [json_data, transaccion])
            cur.close()
            return Response({"mensaje": "Cliente registrado correctamente"}, status=201)
            
        elif transaccion == 'actualizar_cliente' and codigo is not None and tipo is not None:
            cur.callproc('SetCliente', [json_data, transaccion])
            cur.close()
            return Response({"mensaje": "Cliente actualizado correctamente"}, status=200)
        else:
            return Response({"mensaje": "Transaccion no válida"}, status=400)
            
    except Exception as e:
        return Response({"mensaje": str(e)}, status=400)


@api_view(['GET','POST'])
def getClienteViewGet(request):
    if request.method == 'GET':
        # Obtener los parámetros de la URL
        cod_id = request.GET.get('CodigoIdentificacion',None)
        tipo_id = request.GET.get('CodTipoId',None)
        transaccion = request.GET.get('Transaccion',None)
        
    if not cod_id or not tipo_id or not transaccion:
        return Response({"error": "Faltan parámetros en la solicitud"}, status = 400)
    
    try:
        cur = connection.cursor()
        cur.callproc(nameSP.obtenerCliente,[cod_id,tipo_id,transaccion])
        results = cur.fetchall()
        
        listData = []
        for row in results:
            data = {
               "IdentificacionCliente": row[0],
               "CodTipoIdentificacion": row[1],
               "NombresCliente": row[2],
               "ApellidosCliente": row[3],
               "TelefonoCliente": row[4],
               "EmailCliente": row[5]
            }
            listData.append(data)
        
        cur.close()
        return Response(listData)
        
    except Exception as e:
        return Response({"error": f"Error al ejecutar el procedimiento: {str(e)}"}, status=500)
        
def dictfecthall(cursor):
    columns = [col[0] for col in cursor.description]
    return [dict(zip(columns, row)) for row in cursor.fetchall()]

@api_view(['GET'])
def getReporteViewGet(request):
    try:
        transaccion = request.GET.get('Transaccion', '')     
        
        fechaInicio = request.GET.get('FechaInicio', '')
        fechaFin = request.GET.get('FechaFin', '')
        
        datosFiltro = {
            "FechaInicio": fechaInicio,
            "FechaFin": fechaFin
        }
        json_data = json.dumps(datosFiltro)
        
        with connection.cursor() as cursor:
            cursor.callproc(nameSP.obtenerReportes, [json_data, transaccion])
            resultado = dictfecthall(cursor)
        return JsonResponse(resultado, safe=False)
    
    except Exception as e:
        return JsonResponse({"mensaje": str(e)}, status=400)