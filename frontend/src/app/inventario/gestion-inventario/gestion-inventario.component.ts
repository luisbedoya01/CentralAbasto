import { Component, OnInit } from '@angular/core';
import { ProductoService } from '../../servicios/producto.service';
import { CommonModule } from '@angular/common';
import { FormControl, FormGroup, FormsModule, Validators } from '@angular/forms';
import { MatSnackBar } from '@angular/material/snack-bar';
import { ReactiveFormsModule } from '@angular/forms';
import { CategoriaService } from '../../servicios/categoria.service';
import { EstadosService } from '../../servicios/estados.service';
import { MarcaService } from '../../servicios/marca.service';
import { UnidadService } from '../../servicios/unidad.service';
import { ProveedorService } from '../../servicios/proveedor.service'
import { MatIconModule } from '@angular/material/icon';
import { PrecioVentaService } from '../../servicios/precio-venta.service';
import { UnidadMedidaService } from '../../servicios/unidad-medida.service';
import { StockProductoService } from '../../servicios/stock-producto.service';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-gestion-inventario',
  standalone: true,
  imports: [CommonModule, FormsModule, ReactiveFormsModule, MatIconModule],
  templateUrl: './gestion-inventario.component.html',
  styleUrl: './gestion-inventario.component.css'
})
export class GestionInventarioComponent implements OnInit {

  // #region Arreglos para almacenar listas
  productos: any[] = [];
  productosFiltrados: any[] = [];
  productosPaginados: any[] = [];
  filtro: string = '';
  paginaActual: number = 1;
  itemsPorPagina: number = 5;
  opcionesPorPagina: number[] = [5, 10, 15, 20];
  paginasTotales: number = 0;
  categorias: any[] = [];
  estados: any[] = [];
  marcas: any[] = [];
  unidades: any[] = [];
  proveedores: any[] = [];
  preciosVentas: any[] = [];
  medidas: any[] = [];
  stockProductos: any[] = [];
  // #endregion


  // #region Variables para manejar modales
  isModalVisible: boolean = false;
  isModalVisibleEditar: boolean = false;
  isConfirmDeleteModalVisible: boolean = false;
  isModalCategoriaVisible: boolean = false;
  isModalUnidadMedidaVisible: boolean = false;
  isModalMarcaVisible: boolean = false;
  isModalProveedorVisible: boolean = false;
  isModalPrecioVentaVisible: boolean = false;
  isModalAgregarPrecioVentaVisible: boolean = false;
  isConfirmDeleteModalVisiblePrecioVenta: boolean = false;
  isModalVisibleStockProducto: boolean = false;
  // #endregion

  //#region Variables
  modoEdicion: boolean = false;
  modoEdicionPrecioVenta: boolean = false;
  productoSeleccionado: any = null;
  precioSeleccionado: any = null;
  idProductoGudrado: any = null;
  mensajeNoResultados: string = '';
  //#endregion

  // #region Propiedades
  //Producto
  idProducto: any;
  codigoProducto: any;
  nombre: any;
  precio: any;
  idCategoria: any;
  respuesta: any = null;
  idMarca: any;
  idUnidadMedida: any;
  stock: any;
  stockMinimo: any;
  stockMaximo: any;
  precioCompra: any;
  porcentajeGanancia: any;
  idProveedor: any;
  fechaVencimiento: any;
  impuestoProducto: any;
  ventaGranel: any;
  idUnidadConversionVenta: any;

  //Categoria
  nombreCategoria: any;
  descripcionCategoria: any;

  //Marca
  nombreMarca: any;

  //Unidad de medida
  nombreUnidad: any;

  //Proveedor
  nombreProveedor: any;
  rucProveedor: any;
  direccionProveedor: any;
  telefonoProveedor: any;

  //Precio de venta
  idPrecio: any;
  precioVenta: any;

  //Stock Producto
  cantidadStock: any;



  // #endregion


  constructor(private productoService: ProductoService,
    private categoriaService: CategoriaService,
    private estadoService: EstadosService,
    private marcaService: MarcaService,
    private unidadService: UnidadService,
    private proveedorService: ProveedorService,
    private precioVentaService: PrecioVentaService,
    private snackBar: MatSnackBar,
    private medidasConversion: UnidadMedidaService,
    private stockProductoService: StockProductoService) { }

  ngOnInit(): void {
    this.obtenerProductos();
    this.obtenerCategorias();
    this.obtenerEstados();
    this.obtenerMarcas();
    this.obtenerUnidades();
    this.obtenerProveedores();
    this.obtenerMedidasConversion();
  }

  //#region Inicializar los formularios

  productoForm = new FormGroup({
    Id_Producto: new FormControl(),
    CodigoProducto: new FormControl('', Validators.required),
    Nombre: new FormControl('', Validators.required),
    IdMarca: new FormControl('', Validators.required),
    Stock: new FormControl('', Validators.required),
    StockMinimo: new FormControl('', Validators.required),
    StockMaximo: new FormControl('', Validators.required),
    PrecioCompra: new FormControl('', Validators.required),
    PorcentajeGanancia: new FormControl('', Validators.required),
    IdProveedor: new FormControl('', Validators.required),
    FechaVencimiento: new FormControl(),
    VentaGranel: new FormControl(),
    ImpuestoProducto: new FormControl(),
    Id_Estado: new FormControl(),
    esPerecible: new FormControl(false),
    Es_Perecible: new FormControl(),
    IdCategoria: new FormControl('', Validators.required),
    IdUnidadConversionVenta: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  marcaForm = new FormGroup({
    Nombre: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  categoriaForm = new FormGroup({
    Nombre: new FormControl('', Validators.required),
    Descripcion: new FormControl(),
    Transaccion: new FormControl(),
  });

  unidadForm = new FormGroup({
    Nombre: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  proveedorForm = new FormGroup({
    Ruc: new FormControl('', Validators.required),
    Nombre: new FormControl('', Validators.required),
    Direccion: new FormControl('', Validators.required),
    Telefono: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  precioVentaForm = new FormGroup({
    IdPrecio: new FormControl(),
    IdProducto: new FormControl(''),
    IdUnidadMedida: new FormControl('', Validators.required),
    PrecioVenta: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  stockProductoForm = new FormGroup({
    IdProducto: new FormControl(''),
    CantidadStock: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  //#endregion

  // #region Metodos para abrir modales
  agregarProducto() {
    this.modoEdicion = false;
    this.productoSeleccionado = null;
    this.isModalVisible = true;
  }

  abrirModalCategoria() {
    this.isModalCategoriaVisible = true;
  }

  abrirModalUnidadMedida() {
    this.isModalUnidadMedidaVisible = true;
  }

  abrirModalProveedor() {
    this.isModalProveedorVisible = true;
  }

  abrirModalMarca() {
    this.isModalMarcaVisible = true;
  }

  abrirModalPrecioVenta() {
    this.isModalPrecioVentaVisible = true;
    if (this.productoForm.value.Id_Producto) {
      this.obtenerPrecioVenta();
    }
    //this.obtenerPrecioVenta();
  }

  agregarPrecioVenta() {
    this.modoEdicionPrecioVenta = false;
    this.precioSeleccionado = null;
    this.isModalAgregarPrecioVentaVisible = true;
  }

  agregarStockProducto(producto: any) {
    this.productoSeleccionado = producto;
    this.isModalVisibleStockProducto = true;

    this.stockProductoForm.patchValue({
      IdProducto: producto.Id_Producto,
    });

    if (this.stockProductoForm.value.IdProducto) {
      this.obtenerStockProducto();
    }
  }

  //#endregion

  // #region Metodos para cerrar modales

  cerrarModal() {
    this.isModalVisible = false;
    this.productoForm.reset();
  }

  cerrarModalDelete() {
    this.isConfirmDeleteModalVisible = false;
  }

  cerrarModalUnidadMedida() {
    this.isModalUnidadMedidaVisible = false;
    this.unidadForm.reset();
  }

  cerrarModalCategoria() {
    this.isModalCategoriaVisible = false;
    this.categoriaForm.reset();
  }

  cerrarModalProveedor() {
    this.isModalProveedorVisible = false;
    this.proveedorForm.reset();
  }

  cerrarModalMarca() {
    this.isModalMarcaVisible = false;
    this.marcaForm.reset();
  }

  cerrarModalPrecioVenta() {
    this.isModalPrecioVentaVisible = false;
    //this.precioVentaForm.reset();
  }

  cerrarModalAgregarPrecioVenta() {
    this.isModalAgregarPrecioVentaVisible = false;
    this.precioVentaForm.reset();
  }

  cerrarModalDeletePrecioVenta() {
    this.isConfirmDeleteModalVisiblePrecioVenta = false;
  }

  cerrarModalStockProducto() {
    this.isModalVisibleStockProducto = false;
    this.stockProductoForm.reset();
  }

  // #endregion

  // #region Metodos GET

  filtrarProductos() {
    const texto = this.filtro.trim().toLowerCase();
    this.productosFiltrados = this.productos.filter(p =>
      p.Nombre_Producto.toLowerCase().includes(texto) ||
      p.Codigo_Producto.toLowerCase().includes(texto) ||
      p.Nombre_Proveedor.toLowerCase().includes(texto)
    );

    if (this.productosFiltrados.length === 0) {
      this.mensajeNoResultados = 'No se encontraron productos que coincidan con ' + `"${this.filtro}"`;
    } else {
      this.mensajeNoResultados = '';
    }

    this.paginaActual = 1;
    this.actualizarPaginacion();
  }

  actualizarPaginacion() {
    const inicio = (this.paginaActual - 1) * this.itemsPorPagina;
    const fin = inicio + this.itemsPorPagina;
    this.paginasTotales = Math.ceil(this.productosFiltrados.length / this.itemsPorPagina);
    this.productosPaginados = this.productosFiltrados.slice(inicio, fin);
  }

  cambiarItemsPorPagina() {
    this.paginaActual = 1; // Reiniciar a la primera página al cambiar el número de items por página
    this.actualizarPaginacion();
  }

  cambiarPagina(nuevaPagina: number) {
    if (nuevaPagina >= 1 && nuevaPagina <= this.paginasTotales) {
      this.paginaActual = nuevaPagina;
      this.actualizarPaginacion();
    }
  }

  obtenerProductos() {
    this.productoService.getProducto('obtener_productos').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.productos = data;
          this.productosFiltrados = data;
          this.filtrarProductos();
        } else {
          console.log('Error: la respuesta del servidor no es un arry', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }

  obtenerCategorias() {
    this.categoriaService.getCategoria('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.categorias = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );

  }

  obtenerEstados() {
    this.estadoService.getEstado('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.estados = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }


  obtenerMarcas() {
    this.marcaService.getMarca('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.marcas = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }

  obtenerUnidades() {
    this.unidadService.getUnidad('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.unidades = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }

  obtenerProveedores() {
    this.proveedorService.getProveedor('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.proveedores = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }

  obtenerPrecioVenta() {
    // Limpiar precios de venta antes de hacer la consulta
    this.preciosVentas = [];

    this.precioVentaService.getPrecioVenta(this.productoForm.value.Id_Producto, 'consulta_precio_venta').subscribe(
      (data: any) => {
        // Verificar si la respuesta tiene el mensaje indicando que no se encontraron precios
        if (data.mensaje) {
          // No hay precios, la lista ya está vacía por defecto
        } else if (Array.isArray(data)) {
          this.preciosVentas = data;
          console.log('Precios de venta:', this.preciosVentas);
        } else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
        // Si hay un error, también limpiamos preciosVentas
        this.preciosVentas = [];
      }
    );
  }

  obtenerStockProducto() {
    this.stockProductos = [];
    this.stockProductoService.getStockProducto(
      Number(this.stockProductoForm.value.IdProducto),
      'consulta_stock_producto'
    ).subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.stockProductos = data;
        } else if (data) {
          // Si data existe pero no es array, intenta convertirlo o manejar el caso
          this.stockProductos = [data]; // Convierte a array si es un objeto único
          console.log('Datos convertidos a array:', this.stockProductos);
        } else {
          this.stockProductos = [];
          console.log('No hay datos de stock disponibles');
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + JSON.stringify(error, null, 2));
        this.stockProductos = [];
      }
    );
  }

  obtenerMedidasConversion() {
    this.medidasConversion.getUnidadMedida('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.medidas = data;
        } else {
          console.log('Error: La respuesta no es un arreglo', data);
        }
      },
      (error) => {
        console.log('Error al obtener las medidas de conversión:', error);
      }
    );
  }


  // #endregion

  //#region Metodos POST

  guardarProducto() {
    this.idProducto = this.productoForm.value.Id_Producto;
    this.codigoProducto = this.productoForm.value.CodigoProducto;
    this.nombre = this.productoForm.value.Nombre;
    this.precio = this.productoForm.value.PrecioCompra;
    this.idCategoria = this.productoForm.value.IdCategoria;
    this.idMarca = this.productoForm.value.IdMarca;
    this.stock = this.productoForm.value.Stock;
    this.stockMaximo = this.productoForm.value.StockMaximo;
    this.stockMinimo = this.productoForm.value.StockMinimo;
    this.fechaVencimiento = this.productoForm.value.FechaVencimiento;
    this.porcentajeGanancia = this.productoForm.value.PorcentajeGanancia;
    this.idProveedor = this.productoForm.value.IdProveedor;
    const impuestoProductoVal = this.productoForm.get('ImpuestoProducto')?.value ? 'S' : 'N';
    const ventaGranelVal = this.productoForm.get('VentaGranel')?.value ? 'S' : 'N';
    this.productoForm.value.VentaGranel = ventaGranelVal;
    this.productoForm.value.ImpuestoProducto = impuestoProductoVal;
    const esPerecible = this.productoForm.get('esPerecible')?.value;
    const esPerecibleVal = esPerecible ? 'S' : 'N';
    this.idUnidadConversionVenta = this.productoForm.value.IdUnidadConversionVenta;
    this.productoForm.value.Es_Perecible = esPerecibleVal;

    if (!esPerecible) {
      this.productoForm.value.FechaVencimiento = '1999-12-31'; // Valor por defecto para productos no perecibles
    }

    //this.
    //this.productoForm.value.Id_Estado = 1;
    this.productoForm.value.Transaccion = this.modoEdicion ? "editar_producto" : "agregar_producto";

    //console.log('Producto a guardar: ', this.productoForm.value);

    if (this.productoForm.valid) {
      if (this.modoEdicion) {
        // Si está en modo edición, llamamos al servicio de editar
        this.productoService.editarProducto(this.productoSeleccionado.Id_Producto, this.productoForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              this.snackBar.open('Error al editar producto', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
            } else {
              this.snackBar.open('Producto editado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerProductos();
              this.cerrarModal();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            console.log(this.productoSeleccionado);
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      } else {
        // Si no está en modo edición, llamamos al servicio de agregar
        this.productoService.agregarProducto(this.productoForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            this.idProductoGudrado = data.IdProducto;
            if (data.length === 0) {
              this.snackBar.open('Error al agregar producto', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
            } else {
              this.snackBar.open('Producto agregado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              //this.guardarPreciosVenta(); // Guardar precios de venta después de agregar el producto
              this.obtenerProductos();
              this.cerrarModal();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      }
    } else {
      this.snackBar.open('Todos los campos son requeridos', 'Cerrar', {
        duration: 3000,
        horizontalPosition: 'center',
        verticalPosition: 'bottom',
        panelClass: ['error-snackbar']
      });
    }
  }

  guardarCategoria() {
    this.nombreCategoria = this.categoriaForm.value.Nombre;
    this.descripcionCategoria = this.categoriaForm.value.Descripcion;
    this.categoriaForm.value.Transaccion = "agregar_categoria";

    if (this.categoriaForm.valid) {
      console.log("Datos a enviar: ", this.categoriaForm.value);
      this.categoriaService.agregarCategoria(this.categoriaForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          console.log(data);
          if (data.length == 0) {
            this.snackBar.open('Error al agregar categoria', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Categoria agregada correctamente', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
            this.obtenerCategorias();
            this.cerrarModalCategoria();
          }
          console.log('Respuesta de la API:', data);
        },
        (error) => {
          this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
            duration: 4000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
        }
      );
    }
  }

  guardarMarca() {
    this.nombreMarca = this.marcaForm.value.Nombre;
    this.marcaForm.value.Transaccion = "agregar_marca";

    if (this.marcaForm.valid) {
      console.log("Datos a enviar: ", this.marcaForm.value);
      this.marcaService.agregarMarca(this.marcaForm.value).subscribe(
        (data: any) => {
          console.log(data);
          if (data.length === 0) {
            this.snackBar.open('Error al agregar marca', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Marca agregada correctamente', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
            this.obtenerMarcas();
            this.cerrarModalMarca();
          }
        }
      );
    }
  }

  guardarUnidadMedida() {
    this.nombreUnidad = this.unidadForm.value.Nombre;
    this.unidadForm.value.Transaccion = "agregar_unidad";

    if (this.unidadForm.valid) {
      this.unidadService.agregarUnidad(this.unidadForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          console.log(data);
          if (data.length === 0) {
            this.snackBar.open('Error al agregar unidad de medida', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Unidad de medida agregada correctamente', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
            this.obtenerUnidades();
            this.cerrarModalUnidadMedida();
          }
          console.log('Respuesta de la API:', data);
        },
        (error) => {
          this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
            duration: 4000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
        }
      );
    }
  }

  guardarProveedor() {
    this.nombreProveedor = this.proveedorForm.value.Nombre;
    this.rucProveedor = this.proveedorForm.value.Ruc;
    this.direccionProveedor = this.proveedorForm.value.Direccion;
    this.telefonoProveedor = this.proveedorForm.value.Telefono;
    this.proveedorForm.value.Transaccion = "agregar_proveedor";

    //console.log("Datos a enviar: ",this.proveedorForm.value);
    if (this.proveedorForm.valid) {
      this.proveedorService.agregarProveedor(this.proveedorForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          if (data.length === 0) {
            this.snackBar.open('Error al agregar proveedor', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Proveedor agregado correctamente', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
            this.obtenerProveedores();
            this.cerrarModalProveedor();
          }
          console.log('Respuesta de la API:', data);
        },
        (error) => {
          this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
            duration: 4000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
        }
      );
    }
  }

  guardarStockProducto() {
    this.idProducto = this.stockProductoForm.value.IdProducto;
    this.cantidadStock = this.stockProductoForm.value.CantidadStock;
    this.stockProductoForm.value.Transaccion = "agregar_stock_producto";
    //console.log('Datos a enviar:', this.stockProductoForm.value);

    if (this.stockProductoForm.valid) {
      this.stockProductoService.agregarStockProducto(this.stockProductoForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          if (data.length === 0) {
            this.snackBar.open('Error al agregar stock al producto', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Stock agregado al producto', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          }
          console.log('Respuesta de la API:', data);
          this.obtenerProductos();
          this.cerrarModalStockProducto();
        },
        (error) => {
          const errorMessage = JSON.stringify(error, null, 2);
          this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + errorMessage, 'Cerrar', {
            duration: 4000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
          console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + errorMessage);
        }
      );
    }
  }

  guardarPrecioVenta() {
    this.idProducto = this.precioVentaForm.value.IdProducto;
    this.precioVenta = this.precioVentaForm.value.PrecioVenta;
    this.idUnidadMedida = this.precioVentaForm.value.IdUnidadMedida;
    this.precioVentaForm.value.IdProducto = this.productoForm.value.Id_Producto;
    //this.precioVentaForm.value.Transaccion = "agregar_precio_venta";
    this.precioVentaForm.value.Transaccion = this.modoEdicionPrecioVenta ? "editar_precio_venta" : "agregar_precio_venta";

    console.log('Datos a enviar:', this.precioVentaForm.value);
    console.log('Modo de edición:', this.modoEdicionPrecioVenta);

    if (this.precioVentaForm.valid) {
      if (this.modoEdicionPrecioVenta) {
        this.precioVentaService.editarPrecioVenta(this.precioSeleccionado.IdPrecio, this.precioVentaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            if (data.length === 0) {
              this.snackBar.open('Error al editar precio de venta', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
            } else {
              this.snackBar.open('Precio de venta editado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerPrecioVenta();
              this.cerrarModalAgregarPrecioVenta();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      } else {
        this.precioVentaService.agregarPrecioVenta(this.precioVentaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              this.snackBar.open('Error al agregar precio de venta', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
            } else {
              this.snackBar.open('Precio de venta agregado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerPrecioVenta();
              this.cerrarModalAgregarPrecioVenta();
              //this.cerrarModalPrecioVenta();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      }
    }
  }

  editarPrecioVenta(precio: any) {
    this.modoEdicionPrecioVenta = true;
    this.precioSeleccionado = precio;
    this.isModalAgregarPrecioVentaVisible = true;

    console.log(precio);

    this.precioVentaForm.patchValue({
      IdPrecio: precio.IdPrecio,
      IdUnidadMedida: precio.IdUnidadMedida,
      PrecioVenta: precio.PrecioVenta
    });
  }

  editarProducto(producto: any) {
    this.modoEdicion = true;
    this.productoSeleccionado = producto;
    console.log(producto);
    this.isModalVisible = true;

    this.productoForm.patchValue({
      Id_Producto: producto.Id_Producto,
      CodigoProducto: producto.Codigo_Producto,
      IdMarca: producto.Id_Marca,
      Stock: producto.Stock,
      StockMinimo: producto.Stock_Minimo,
      StockMaximo: producto.Stock_Maximo,
      PorcentajeGanancia: producto.Porcentaje_Ganancia,
      IdProveedor: producto.Id_Proveedor,
      Nombre: producto.Nombre_Producto,
      PrecioCompra: producto.Precio_Compra,
      ImpuestoProducto: producto.Impuesto_Producto === 'S',
      VentaGranel: producto.Venta_Granel === 'S',
      esPerecible: producto.Es_Perecible === 'S',
      FechaVencimiento: producto.Fecha_Vencimiento === '1999-12-31' ? null : producto.Fecha_Vencimiento,
      IdCategoria: producto.Id_Categoria,
      Id_Estado: producto.IdEstado,
      IdUnidadConversionVenta: producto.IdUnidad_Conversion_Venta
    });

    if (this.productoForm.value.Id_Producto) {
      //console.log('Hola');
      this.obtenerPrecioVenta();
    }

  }

  eliminarProducto(producto: any) {
    this.productoSeleccionado = producto;
    //this.isConfirmDeleteModalVisible = true;
    Swal.fire({
      title: 'Confirmar eliminación',
      html: `
            <div class="text-start">
                <p>¿Está seguro de cancelar este producto?</p>
                <p class="text-muted small"><strong>Producto:</strong> ${producto.Nombre_Producto}</p>
            </div>
        `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sí, eliminar',
      confirmButtonColor: '#d33',
      cancelButtonColor: '#6c757d',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        this.eliminarProductoConfirmado();
      }
    });
  }

  eliminarProductoConfirmado() {
    this.productoSeleccionado.Transaccion = "eliminar_producto";
    this.productoService.eliminarProducto(this.productoSeleccionado.Id_Producto, this.productoSeleccionado).subscribe(
      (data: any) => {
        this.respuesta = data;
        //console.log(data);
        if (data.length === 0) {
          this.snackBar.open('Error al eliminar producto', 'Cerrar', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['succes-snackbar']
          });
        } else {
          this.cerrarModalDelete();
          this.obtenerProductos();
          Swal.fire({
            title: 'Producto eliminado',
            text: 'El producto ha sido eliminado correctamente.',
            icon: 'success',
            confirmButtonText: 'Aceptar',
            confirmButtonColor: 'rgba(38,218, 77,1)',
            allowOutsideClick: false,
            showClass: { popup: "animate_animated animatefadeIn animate_faster" },
          });
        }
        //console.log('Respuesta de la API:', data);
      }
    );
    console.log('Producto a eliminar: ', this.productoSeleccionado);
  }

  eliminarPrecioVenta(precio: any) {
    this.precioSeleccionado = precio;
    this.isConfirmDeleteModalVisiblePrecioVenta = true;
  }

  eliminarPrecioVentaConfirmado() {
    this.precioSeleccionado.Transaccion = "eliminar_precio_venta";
    this.precioVentaService.eliminarPrecioVenta(this.precioSeleccionado.IdPrecio, this.precioSeleccionado).subscribe(
      (data: any) => {
        this.respuesta = data;
        //console.log(data);
        if (data.length === 0) {
          this.snackBar.open('Error al eliminar precio de venta', 'Cerrar', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['succes-snackbar']
          });
        } else {
          this.snackBar.open('Precio de venta eliminado correctamente', 'Cerrar', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['succes-snackbar']
          });
          this.obtenerPrecioVenta();
          this.cerrarModalDeletePrecioVenta();
        }
        console.log('Respuesta de la API:', data);
      }
    );
  }


  //#endregion
}
