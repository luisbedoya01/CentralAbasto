import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { ProductoService } from '../servicios/producto.service';
import { PrecioVentaService } from '../servicios/precio-venta.service';
import { UnidadMedidaService } from '../servicios/unidad-medida.service';
import { forkJoin, Observable } from 'rxjs';
import { firstValueFrom } from 'rxjs';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { PedidoService } from '../servicios/pedido.service';
import { IvaService } from '../servicios/iva.service';
import Swal from 'sweetalert2';

// Interfaces para tipado fuerte
export interface DetalleConversion {
  Id_Conversion?: number;
  Unidad_Origen?: string;
  Unidad_Destino?: string;
  Factor_Conversion?: number;
  [key: string]: any;
}

export interface RespuestaPedido {
  IdPedido: number,
  CodigoPedido: string;
}

export interface ItemPedido {
  idItem: string;
  idProducto: number;
  codigoProducto: string;
  nombreProducto: string;
  marca: string;

  cantidad: number;
  precioUnitario: number;
  unidadMedida: string;
  idPrecioVenta: number;
  idUnidadMedida: number;

  // Información de conversión
  idConversionVenta?: number;
  detalleConversion?: DetalleConversion;
  necesitaConversion: boolean;
  factorConversion: number;
  idUnidadOrigenConversion?: number;
  idUnidadDestinoConversion?: number;
  nombreUnidadOrigen?: string;
  nombreUnidadDestino?: string;

  // Información convertida
  cantidadConvertida?: number;
  unidadConvertida?: string;

  impuestoProducto: string;
  porcentajeIva?: number;

  // Datos calculados
  subtotal: number;
  iva: number;
  total: number;
  fechaAgregado: Date;

  // Nuevos campos para edición
  cantidadOriginal?: number; // Para tracking de cambios
  esNuevo?: boolean; // Para identificar productos nuevos
}

export interface PrecioVenta {
  IdPrecio: number;
  Id_Producto: number;
  IdUnidadMedida: number;
  PrecioVenta: number;
  UnidadMedida: string;
  Estado?: string;
}

export interface IVA {
  IdIva: number;
  Descripcion: string;
  Porcentaje: number;
}

export interface Producto {
  Id_Producto: number;
  Codigo_Producto: string;
  Nombre_Producto: string;
  Nombre_Marca: string;
  Stock: number;
  StockPedido: number;
  UnidadVenta: string,
  Impuesto_Producto: string,
  IdUnidad_Conversion_Venta?: number;
  cantidadSeleccionada?: number;
  precioVentaSeleccionado?: PrecioVenta;
}

export interface ProductoSeleccionado {
  producto: Producto;
  cantidad: number;
  precioVenta: PrecioVenta;
  detalleConversion?: any;
  subtotal: number;
}

export interface Pedido {
  IdPedido: number;
  CodigoPedido: string;
  IdCliente: string;
  NombreCliente: string;
  FechaPedido: string;
  SubTotal: number;
  IVA: number;
  Total: number;
  Detalles?: ItemPedido[];
}

@Component({
  selector: 'app-pedidos',
  standalone: true,
  imports: [CommonModule, MatIconModule, FormsModule, MatSnackBarModule],
  templateUrl: './pedidos.component.html',
  styleUrl: './pedidos.component.css'
})
export class PedidosComponent implements OnInit {

  //#region Arreglos con tipado
  productos: Producto[] = [];
  precioVenta: { [key: number]: PrecioVenta[] } = {};
  productosFiltrados: Producto[] = [];
  productosSeleccionados: ItemPedido[] = [];
  iva: IVA[] = [];
  pedidos: any[] = [];
  detallePedido: any[] = [];

  //#endregion

  //#region Variables
  isModalVisible: boolean = false;
  filtroProducto: string = '';
  cargando: boolean = false;
  nombreCliente: string = '';
  pedidoSeleccionado: any;
  isModalEdicionVisible: boolean = false;
  isModalDetalleVisible: boolean = false;
  isModalConfirmarCancelarVisible: boolean = false;
  cargandoDetalle: boolean = false;
  pedidoEditando: any = null;
  productosEditados: ItemPedido[] = [];
  filtro: string = '';
  paginaActual: number = 1;
  itemsPorPagina: number = 5;
  opcionesPorPagina: number[] = [5, 10, 20];
  paginasTotales: number = 0;
  pedidosFiltrados: any[] = [];
  pedidosPaginados: any[] = [];
  mensajeNoResultados: string = '';

  // Nuevas variables para edición
  filtroProductoEdicion: string = '';
  productosFiltradosEdicion: Producto[] = [];
  mostrandoFormularioAgregar: boolean = false;
  productosOriginales: Map<string, ItemPedido> = new Map(); // Para tracking de cambios
  //#endregion

  constructor(
    private productoService: ProductoService,
    private precioVentaService: PrecioVentaService,
    private unidadMedidaService: UnidadMedidaService,
    private pedidoService: PedidoService,
    private ivaService: IvaService,
    private snackBar: MatSnackBar
  ) { }

  //#region Métodos para el modal
  abrirModalAgregarPedido() {
    this.isModalVisible = true;
  }

  async cerrarModalAgregarPedido() {
    //Revertir el stock de los productos seleccionados
    await this.revertirStockPedido();
    //Limpiar selecciones
    this.limpiarSelecciones();
    this.isModalVisible = false;
    this.nombreCliente = '';
  }

  async cerrarModalEdicion() {
    //Revertir el stock de los productos nuevos agregados al pedido
    await this.revertirStockEdicion();
    this.isModalEdicionVisible = false;
    this.pedidoEditando = null;
    this.productosEditados = [];
    this.productosOriginales.clear();
    this.filtroProductoEdicion = '';
    this.productosFiltradosEdicion = [];
    this.mostrandoFormularioAgregar = false;
  }

  private verificarCoincidenciaUnidades(idUnidadPrecio: number, idUnidadConversion: number): boolean {
    if (!idUnidadPrecio || !idUnidadConversion) {
      return false;
    }

    const coinciden = idUnidadPrecio === idUnidadConversion;
    return coinciden;
  }

  //Método para aplicar conversión
  private aplicarConversion(cantidad: number, factor: number): number {
    return cantidad * factor;
  }

  private async limpiarSelecciones() {
    this.productosSeleccionados = [];
    this.productosFiltrados = [];
    this.filtroProducto = '';
    this.productos.forEach(producto => {
      producto.cantidadSeleccionada = undefined;
      producto.precioVentaSeleccionado = undefined;
    });
  }
  //#endregion

  //#region OnInit
  ngOnInit(): void {
    this.obtenerProductos();
    this.obtenerIva();
    this.obtenerPedidos();
  }
  //#endregion

  //#region Métodos para obtener datos
  obtenerProductos() {
    this.cargando = true;
    this.productoService.getProducto('obtener_productos').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.productos = data;
          this.obtenerPreciosVenta();
        } else {
          console.error('Error: La respuesta del servidor no es un array', data);
        }
        this.cargando = false;
      },
      (error) => {
        console.error('Error al obtener productos:', error);
        this.cargando = false;
      }
    );
  }

  obtenerPreciosVenta() {
    const solicitudes = this.productos.map(producto =>
      this.precioVentaService.getPrecioVenta(
        producto.Id_Producto,
        'consulta_precio_venta'
      )
    );

    forkJoin(solicitudes).subscribe(
      (resultados: any[]) => {
        resultados.forEach((data, index) => {
          const producto = this.productos[index];

          if (data.mensaje || !Array.isArray(data)) {
            this.precioVenta[producto.Id_Producto] = [];
          } else {
            this.precioVenta[producto.Id_Producto] = data.map((precio: any) => ({
              IdPrecio: precio.IdPrecio,
              Id_Producto: precio.Id_Producto,
              IdUnidadMedida: precio.IdUnidadMedida,
              PrecioVenta: Number(precio.PrecioVenta),
              UnidadMedida: precio.UnidadMedida || 'Sin unidad',
              Estado: precio.Estado
            }));
          }
        });
      },
      (error) => {
        console.error('Error al obtener precios:', error);
      }
    );
  }

  filtrarPedidos() {
    const texto = this.filtro.trim().toLowerCase();
    this.pedidosFiltrados = this.pedidos.filter(p =>
      p.CodigoPedido.toLowerCase().includes(texto) ||
      p.ClientePedido.toLowerCase().includes(texto) ||
      p.EstadoPedido.toLowerCase().includes(texto) ||
      p.FechaPedido.toLowerCase().includes(texto)
    );

    if (this.pedidosFiltrados.length === 0) {
      this.mensajeNoResultados = 'No se encontraron pedidos que coincidan con ' + `"${this.filtro}"`;
    } else {
      this.mensajeNoResultados = '';
    }

    this.paginaActual = 1;
    this.actualizarPaginacion();
  }

  actualizarPaginacion() {
    const inicio = (this.paginaActual - 1) * this.itemsPorPagina;
    const fin = inicio + this.itemsPorPagina;
    this.paginasTotales = Math.ceil(this.pedidosFiltrados.length / this.itemsPorPagina);
    this.pedidosPaginados = this.pedidosFiltrados.slice(inicio, fin);
  }

  cambiarItemsPorPagina() {
    this.paginaActual = 1;
    this.actualizarPaginacion();
  }

  cambiarPagina(nuevaPagina: number) {
    if (nuevaPagina >= 1 && nuevaPagina <= this.paginasTotales) {
      this.paginaActual = nuevaPagina;
      this.actualizarPaginacion();
    }
  }

  obtenerPedidos() {
    this.pedidoService.getPedido('consultar_pedidos_pendientes').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.pedidos = data;
          this.pedidosFiltrados = data;
          this.filtrarPedidos();
          console.log('Pedidos obtenidos: ', this.pedidos);
        } else {
          console.log('Error en la respuesta del API no es un array', data);
        }
      },
      (error: any) => {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error al obtener los pedidos', errorMessage);
      }
    );
  }

  obtenerDetallePedido() {
    this.detallePedido = [];
    this.cargandoDetalle = true;

    if (!this.pedidoSeleccionado || !this.pedidoSeleccionado.IdPedido) {
      console.error('ID del pedido no disponible:', this.pedidoSeleccionado);
      this.cargandoDetalle = false;
      this.snackBar.open('Error: ID del pedido no disponible', 'Cerrar', { duration: 3000 });
      return;
    }

    this.pedidoService.getDetallePedido(this.pedidoSeleccionado.IdPedido, 'consulta_detalle_pedido').subscribe(
      (data: any) => {
        this.cargandoDetalle = false;

        if (data.mensaje) {
          console.log(data.mensaje);
          this.detallePedido = [];
          this.snackBar.open(data.mensaje, 'Cerrar', { duration: 3000 });
        } else if (Array.isArray(data)) {
          this.detallePedido = data;
          console.log('Detalle pedido:', this.detallePedido);
        } else {
          console.log('Error: la respuesta del servidor no es un array', data);
          this.detallePedido = [];
          this.snackBar.open('Error en el formato de respuesta', 'Cerrar', { duration: 3000 });
        }
      },
      (error) => {
        this.cargandoDetalle = false;
        console.error('Error completo:', error);

        if (error.error instanceof ErrorEvent) {
          // Error del lado del cliente
          console.error('Error del cliente:', error.error.message);
          this.snackBar.open('Error de conexión: ' + error.error.message, 'Cerrar', { duration: 5000 });
        } else {
          // Error del lado del servidor
          console.error(`Código de error: ${error.status}, cuerpo: ${error.error}`);
          this.snackBar.open(`Error del servidor: ${error.status} ${error.statusText}`, 'Cerrar', { duration: 5000 });
        }

        this.detallePedido = [];
      }
    );
  }

  obtenerDetallePedidoCancelado() {
    this.detallePedido = [];
    this.cargandoDetalle = true;

    if (!this.pedidoSeleccionado || !this.pedidoSeleccionado.IdPedido) {
      console.error('ID del pedido no disponible:', this.pedidoSeleccionado);
      this.cargandoDetalle = false;
      this.snackBar.open('Error: ID del pedido no disponible', 'Cerrar', { duration: 3000 });
      return;
    }

    this.pedidoService.getDetallePedido(this.pedidoSeleccionado.IdPedido, 'consulta_detalle_pedido_cancelado').subscribe(
      (data: any) => {
        this.cargandoDetalle = false;

        if (data.mensaje) {
          console.log(data.mensaje);
          this.detallePedido = [];
          this.snackBar.open(data.mensaje, 'Cerrar', { duration: 3000 });
        } else if (Array.isArray(data)) {
          this.detallePedido = data;
          console.log('Detalle pedido:', this.detallePedido);
        } else {
          console.log('Error: la respuesta del servidor no es un array', data);
          this.detallePedido = [];
          this.snackBar.open('Error en el formato de respuesta', 'Cerrar', { duration: 3000 });
        }
      },
      (error) => {
        this.cargandoDetalle = false;
        console.error('Error completo:', error);

        if (error.error instanceof ErrorEvent) {
          // Error del lado del cliente
          console.error('Error del cliente:', error.error.message);
          this.snackBar.open('Error de conexión: ' + error.error.message, 'Cerrar', { duration: 5000 });
        } else {
          // Error del lado del servidor
          //console.error(`Código de error: ${error.status}, cuerpo: ${error.error}`);
          console.error(`Error ${error.status}:`, JSON.stringify(error.error, null, 2));
          this.snackBar.open(`Error del servidor: ${error.status} ${error.statusText}`, 'Cerrar', { duration: 5000 });
        }

        this.detallePedido = [];
      }
    );
  }

  obtenerIva() {
    this.ivaService.getIva('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data) && data.length > 0) {
          // Tomar el primer registro
          const ivaData = data[0];
          this.iva = [{
            IdIva: ivaData.IdIva,
            Descripcion: ivaData.DescripcionIva,
            Porcentaje: Number(ivaData.PorcentajeIva) || 0
          }];
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
          // Establecer un valor por defecto
          this.iva = [{
            IdIva: 0,
            Descripcion: 'IVA por defecto',
            Porcentaje: 12
          }]
        }
      },
      (error) => {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error en la solicitud al servidor. Console con el administrador:' + errorMessage);
        this.iva = [{
          IdIva: 0,
          Descripcion: 'IVA por defecto',
          Porcentaje: 12
        }]
      }
    );
  }

  //#endregion

  //#region Métodos de filtrado y visualización
  verDetallePedido(pedido: any) {
    this.pedidoSeleccionado = pedido;
    this.isModalDetalleVisible = true;

    if (this.pedidoSeleccionado.IdPedido) {
      if (this.pedidoSeleccionado.IdEstado === 6) {
        this.obtenerDetallePedidoCancelado();
      } else {
        this.obtenerDetallePedido();
      }
    }
  }

  cerrarModalDetallePedido() {
    this.isModalDetalleVisible = false;
    this.pedidoSeleccionado = null;
  }

  async cancelarPedido(pedido: any) {
    this.pedidoSeleccionado = pedido;
    //this.isModalConfirmarCancelarVisible = true;
    if (this.pedidoSeleccionado.IdPedido) {
      this.obtenerDetallePedido();
    }

    const result = await Swal.fire({
      title: 'Confirmar Cancelación',
      html: `
            <div class="text-start">
                <p>¿Está seguro de cancelar este pedido?</p>
                <p class="text-muted small"><strong>Pedido:</strong> ${pedido.CodigoPedido}</p>
            </div>
        `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#6c757d',
      confirmButtonText: 'Si, Cancelar Pedido',
      cancelButtonText: 'Cerrar',
      //reverseButtons: true,
      allowOutsideClick: false,
      showLoaderOnConfirm: true,
      preConfirm: () => {
        return this.confirmarCancelarPedido();
      }
    });

    if (result.isConfirmed) {
      Swal.fire({
        title: '¡Pedido Cancelado!',
        text: 'El pedido ha sido cancelado correctamente',
        icon: 'success',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: 'rgba(38, 218, 77, 1)',
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });

      this.obtenerPedidos();
    }
  }

  async confirmarCancelarPedido(): Promise<void> {
    try {
      for (const producto of this.detallePedido) {
        const necesitaConversion = producto.NecesitaConversion === 'S';
        const cantidadARevertir = necesitaConversion ?
          producto.Cantidad * producto.FactorConversion :
          producto.Cantidad;

        const productoActualizado = {
          Transaccion: 'editar_stock',
          Id_Producto: producto.IdProducto,
          Stock: cantidadARevertir
        };

        await firstValueFrom(this.productoService.editarProducto(
          producto.IdProducto,
          productoActualizado
        ));

        const detalleEliminar = {
          Transaccion: 'eliminar_producto_detalle',
          IdItem: producto.IdDetallePedido,
          IdProducto: producto.IdProducto,
          IdPedido: this.pedidoSeleccionado.IdPedido
        };

        await firstValueFrom(this.pedidoService.agregarDetallePedido(detalleEliminar));

      }
      const pedidoCancelar = {
        Transaccion: 'cancelar_pedido',
        IdPedido: this.pedidoSeleccionado.IdPedido
      };
      await firstValueFrom(this.pedidoService.editarPedido(this.pedidoSeleccionado.IdPedido, pedidoCancelar));
      console.log('✅ Pedido cancelado correctamente');
      this.cerrarModalCancelarPedido();
      this.obtenerPedidos();
    } catch (error) {
      console.error('❌ Error al actualizar stock pedido:', error);
    }
  }

  cerrarModalCancelarPedido() {
    this.isModalConfirmarCancelarVisible = false;
  }

  filtrarProductos() {
    if (this.filtroProducto.trim() === '') {
      this.productosFiltrados = [];
    } else {
      this.productosFiltrados = this.productos.filter(producto =>
        producto.Nombre_Producto.toLowerCase().includes(this.filtroProducto.toLowerCase()) ||
        producto.Codigo_Producto.toString().includes(this.filtroProducto)
      );
    }
  }

  // Nuevo método para filtrar productos en edición
  filtrarProductosEdicion() {
    if (this.filtroProductoEdicion.trim() === '') {
      this.productosFiltradosEdicion = [];
    } else {
      // Filtrar productos que no estén ya en el pedido
      const idsProductosEnPedido = this.productosEditados.map(item => item.idProducto);

      this.productosFiltradosEdicion = this.productos.filter(producto =>
        !idsProductosEnPedido.includes(producto.Id_Producto) &&
        (producto.Nombre_Producto.toLowerCase().includes(this.filtroProductoEdicion.toLowerCase()) ||
          producto.Codigo_Producto.toString().includes(this.filtroProductoEdicion))
      );
    }
  }

  mostrarTabla(): boolean {
    return this.filtroProducto.trim() !== '' && this.productosFiltrados.length > 0;
  }

  mostrarTablaEdicion(): boolean {
    return this.filtroProductoEdicion.trim() !== '' && this.productosFiltradosEdicion.length > 0;
  }
  //#endregion

  //#region Métodos para agregar productos (modal principal)
  async agregarAlPedido(producto: any) {
    if (!this.validarProductoParaAgregar(producto)) {
      return;
    }

    let cantidadReservar = 0;
    const porcentajeIVA = this.obtenerPorcentajeIVA();

    try {
      let detalleConversion = null;
      let necesitaConversion = false;
      let factorConversion = 1;
      let idUnidadOrigenConversion: number = 0;
      let idUnidadDestinoConversion: number = 0;
      let nombreUnidadOrigen: string = '';
      let nombreUnidadDestino: string = '';

      if (producto.IdUnidad_Conversion_Venta && producto.IdUnidad_Conversion_Venta > 0) {
        try {
          const respuesta = await firstValueFrom(
            this.unidadMedidaService.getUnidadMedida(
              'obtener_medida_especifica',
              producto.IdUnidad_Conversion_Venta
            )
          );

          if (respuesta && typeof respuesta === 'object') {
            detalleConversion = respuesta;

            idUnidadOrigenConversion = detalleConversion.Id_Unidad_Principal || 0;
            idUnidadDestinoConversion = detalleConversion.Id_Unidad_Convertir || 0;
            nombreUnidadOrigen = detalleConversion.Nombre_Medida_Principal || '';
            nombreUnidadDestino = detalleConversion.Nombre_Medida_Convertir || '';
            factorConversion = detalleConversion.Factor_Conversion || 1;

            const idUnidadPrecio = producto.precioVentaSeleccionado.IdUnidadMedida;

            necesitaConversion = !this.verificarCoincidenciaUnidades(
              idUnidadPrecio,
              idUnidadDestinoConversion
            );
          }

        } catch (error) {
          console.warn('Error obteniendo conversión:', error);
        }
      }

      if (producto.Stock !== undefined && producto.Stock !== null) {
        let cantidadRequerida = producto.cantidadSeleccionada;

        if (necesitaConversion) {
          cantidadRequerida = producto.cantidadSeleccionada * factorConversion;
        }

        const stockTotal = Number(producto.Stock) || 0;
        const stockReservado = Number(producto.StockPedido) || 0;
        const stockRealmenteDisponible = Math.max(0, stockTotal - stockReservado);

        if (stockRealmenteDisponible < cantidadRequerida) {
          const unidadStock = necesitaConversion ? nombreUnidadDestino : producto.precioVentaSeleccionado.UnidadMedida;
          await Swal.fire({
            icon: 'error',
            title: 'Stock insuficiente',
            text: `Disponible: ${stockRealmenteDisponible} ${unidadStock}`,
            confirmButtonText: 'Aceptar',
            confirmButtonColor: '#d33'
          });
          return;
        }
      }

      let cantidadFinal = producto.cantidadSeleccionada;
      let cantidadOriginal = producto.cantidadSeleccionada;

      if (necesitaConversion && factorConversion !== 1) {
        cantidadFinal = this.aplicarConversion(producto.cantidadSeleccionada, factorConversion);
      }

      cantidadReservar = necesitaConversion ?
        producto.cantidadSeleccionada * factorConversion :
        producto.cantidadSeleccionada;

      const itemPedido: ItemPedido = {
        idItem: this.generarIdUnico(),
        idProducto: producto.Id_Producto,
        codigoProducto: producto.Codigo_Producto,
        nombreProducto: producto.Nombre_Producto,
        marca: producto.Nombre_Marca,
        cantidad: producto.cantidadSeleccionada,
        precioUnitario: producto.precioVentaSeleccionado.PrecioVenta,
        unidadMedida: producto.precioVentaSeleccionado.UnidadMedida,
        idPrecioVenta: producto.precioVentaSeleccionado.IdPrecio,
        idUnidadMedida: producto.precioVentaSeleccionado.IdUnidadMedida,
        idConversionVenta: producto.IdUnidad_Conversion_Venta,
        detalleConversion: detalleConversion,
        necesitaConversion: necesitaConversion,
        factorConversion: factorConversion,
        idUnidadOrigenConversion: idUnidadOrigenConversion,
        idUnidadDestinoConversion: idUnidadDestinoConversion,
        nombreUnidadOrigen: nombreUnidadOrigen,
        nombreUnidadDestino: nombreUnidadDestino,
        impuestoProducto: producto.Impuesto_Producto,
        cantidadConvertida: necesitaConversion ? cantidadFinal : undefined,
        unidadConvertida: necesitaConversion ? nombreUnidadDestino : undefined,
        subtotal: producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta,
        iva: (producto.Impuesto_Producto === 'S') ?
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta * porcentajeIVA : 0,
        total: (producto.Impuesto_Producto === 'S') ?
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta * (1 + porcentajeIVA) :
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta,
        fechaAgregado: new Date()
      };

      this.productosSeleccionados.push(itemPedido);
      console.log('✅ Producto agregado al pedido');


      try {
        const productoActualizado = {
          Transaccion: 'editar_stock_pedido',
          Id_Producto: producto.Id_Producto,
          StockPedido: cantidadReservar
        };

        await firstValueFrom(this.productoService.editarProducto(
          producto.Id_Producto,
          productoActualizado
        ));

      } catch (error) {
        console.error('❌ Error al actualizar stock pedido:', error);
        this.productosSeleccionados.pop();
        await Swal.fire({
          icon: 'error',
          title: 'Error',
          text: 'Error al actualizar el stock del producto',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: '#d33'
        });
        return;
      }

      const productoEnLista = this.productos.find(p => p.Id_Producto === producto.Id_Producto);
      if (productoEnLista) {
        const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
        productoEnLista.StockPedido = Number((stockPedidoActual + cantidadReservar).toFixed(2));
        this.productos = [...this.productos];
      }

      // Resetear valores
      producto.cantidadSeleccionada = undefined;
      producto.precioVentaSeleccionado = undefined;

    } catch (error) {
      console.error('Error al agregar producto:', error);
      await Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Error al procesar el producto',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#d33'
      });
    }
  }
  //#endregion

  //#region Métodos para agregar productos en edición
  async agregarProductoEdicion(producto: any) {

    // 1. Validación inicial del producto
    if (!producto) {
      console.error('❌ Producto es null o undefined');
      this.snackBar.open('Error: Producto no válido', 'Cerrar', { duration: 3000 });
      return;
    }

    if (!this.validarProductoParaAgregarEdicion(producto)) {
      return;
    }

    let cantidadReservar = 0;
    const porcentajeIVA = this.obtenerPorcentajeIVA();

    try {
      let detalleConversion = null;
      let necesitaConversion = false;
      let factorConversion = 1;
      let idUnidadOrigenConversion: number = 0;
      let idUnidadDestinoConversion: number = 0;
      let nombreUnidadOrigen: string = '';
      let nombreUnidadDestino: string = '';

      // 2. Manejo de conversiones de unidades

      if (producto.IdUnidad_Conversion_Venta && producto.IdUnidad_Conversion_Venta > 0) {
        try {
          //console.log('🔄 Consultando conversión de unidades...');
          const respuesta = await firstValueFrom(
            this.unidadMedidaService.getUnidadMedida(
              'obtener_medida_especifica',
              producto.IdUnidad_Conversion_Venta
            )
          );

          if (respuesta && typeof respuesta === 'object') {
            detalleConversion = respuesta;
            idUnidadOrigenConversion = detalleConversion.Id_Unidad_Principal || 0;
            idUnidadDestinoConversion = detalleConversion.Id_Unidad_Convertir || 0;
            nombreUnidadOrigen = detalleConversion.Nombre_Medida_Principal || '';
            nombreUnidadDestino = detalleConversion.Nombre_Medida_Convertir || '';
            factorConversion = detalleConversion.Factor_Conversion || 1;

            const idUnidadPrecio = producto.precioVentaSeleccionado?.IdUnidadMedida;
            necesitaConversion = !this.verificarCoincidenciaUnidades(
              idUnidadPrecio,
              idUnidadDestinoConversion
            );

          }
        } catch (error) {
          console.warn('Error obteniendo conversión:', error);
        }
      }

      // 3. Validación de stock

      if (producto.Stock !== undefined && producto.Stock !== null) {
        let cantidadRequerida = producto.cantidadSeleccionada;
        if (necesitaConversion) {
          cantidadRequerida = producto.cantidadSeleccionada * factorConversion;
        }

        const stockTotal = Number(producto.Stock) || 0;
        const stockReservado = Number(producto.StockPedido) || 0;
        const stockRealmenteDisponible = Math.max(0, stockTotal - stockReservado);

        if (stockRealmenteDisponible < cantidadRequerida) {
          const unidadStock = necesitaConversion ? nombreUnidadDestino : producto.precioVentaSeleccionado.UnidadMedida;
          await Swal.fire({
            icon: 'error',
            title: 'Stock insufuciente',
            text: `Disponible: ${stockRealmenteDisponible} ${unidadStock}`,
            confirmButtonText: 'Aceptar',
            confirmButtonColor: '#d33'
          });
          return;
        }
      }

      // 4. Cálculo de cantidades finales
      let cantidadFinal = producto.cantidadSeleccionada;
      let cantidadOriginal = producto.cantidadSeleccionada;

      if (necesitaConversion && factorConversion !== 1) {
        cantidadFinal = this.aplicarConversion(producto.cantidadSeleccionada, factorConversion);
      }

      cantidadReservar = necesitaConversion ?
        producto.cantidadSeleccionada * factorConversion :
        producto.cantidadSeleccionada;

      // 5. Construcción del item del pedido
      const nuevoItem: ItemPedido = {
        idItem: this.generarIdUnico(),
        idProducto: producto.Id_Producto,
        codigoProducto: producto.Codigo_Producto,
        nombreProducto: producto.Nombre_Producto,
        marca: producto.Nombre_Marca,
        cantidad: producto.cantidadSeleccionada,
        precioUnitario: producto.precioVentaSeleccionado.PrecioVenta,
        unidadMedida: producto.precioVentaSeleccionado.UnidadMedida,
        idPrecioVenta: producto.precioVentaSeleccionado.IdPrecio,
        idUnidadMedida: producto.precioVentaSeleccionado.IdUnidadMedida,
        idConversionVenta: producto.IdUnidad_Conversion_Venta,
        detalleConversion: detalleConversion,
        necesitaConversion: necesitaConversion,
        factorConversion: factorConversion,
        idUnidadOrigenConversion: idUnidadOrigenConversion,
        idUnidadDestinoConversion: idUnidadDestinoConversion,
        nombreUnidadOrigen: nombreUnidadOrigen,
        nombreUnidadDestino: nombreUnidadDestino,
        impuestoProducto: producto.Impuesto_Producto,
        cantidadConvertida: necesitaConversion ? producto.cantidadSeleccionada * factorConversion : undefined,
        unidadConvertida: necesitaConversion ? nombreUnidadDestino : undefined,
        subtotal: producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta,
        iva: (producto.Impuesto_Producto === 'S') ?
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta * porcentajeIVA : 0,
        total: (producto.Impuesto_Producto === 'S') ?
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta * (1 + porcentajeIVA) :
          producto.cantidadSeleccionada * producto.precioVentaSeleccionado.PrecioVenta,
        fechaAgregado: new Date(),
        esNuevo: true,
        porcentajeIva: this.iva[0]?.Porcentaje || 12
      };

      // 6. Agregar a la lista local (antes de la reserva)
      this.productosEditados.push(nuevoItem);
      // 7. VERIFICACIÓN ANTES DE RESERVA

      if (!producto.Id_Producto) {
        console.error('❌ CRÍTICO: ID de producto no definido');
        this.productosEditados.pop();
        this.snackBar.open('Error: ID de producto no válido', 'Cerrar', { duration: 3000 });
        return;
      }

      if (!cantidadReservar || cantidadReservar <= 0) {
        console.error('❌ CRÍTICO: Cantidad a reservar inválida:', cantidadReservar);
        this.productosEditados.pop();
        this.snackBar.open('Error: Cantidad a reservar no válida', 'Cerrar', { duration: 3000 });
        return;
      }

      if (!this.productoService || !this.productoService.editarProducto) {
        console.error('❌ CRÍTICO: Servicio de producto no disponible');
        this.productosEditados.pop();
        this.snackBar.open('Error: Servicio no disponible', 'Cerrar', { duration: 3000 });
        return;
      }

      // 8. RESERVA DE STOCK EN BASE DE DATOS
      try {
        const productoActualizado = {
          Transaccion: 'editar_stock_pedido',
          Id_Producto: producto.Id_Producto,
          StockPedido: cantidadReservar
        };

        // const resultado = await firstValueFrom(
        //   this.productoService.editarProducto(producto.Id_Producto, productoActualizado)
        // );
        await firstValueFrom(
          this.productoService.editarProducto(producto.Id_Producto, productoActualizado)
        );

        //console.log('✅ RESERVA EXITOSA en BD:', resultado);

        // 9. Actualizar stock en la lista local
        const productoEnLista = this.productos.find(p => p.Id_Producto === producto.Id_Producto);
        if (productoEnLista) {
          const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
          productoEnLista.StockPedido = Number((stockPedidoActual + cantidadReservar).toFixed(2));
          this.productos = [...this.productos];
        }

      } catch (error) {
        // Revertir la operación
        this.productosEditados.pop();

        await Swal.fire({
          icon: 'error',
          title: 'Error de Reserva',
          text: 'Error al actualizar el stock del producto. El producto no fue agregado.',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: '#d33'
        });
        return;
      }

      // 10. Actualizar totales y limpiar formulario
      this.actualizarTotalesEdicion();

      //console.log('🧹 Limpiando formulario...');
      producto.cantidadSeleccionada = undefined;
      producto.precioVentaSeleccionado = undefined;
      this.filtroProductoEdicion = '';
      this.productosFiltradosEdicion = [];
      this.mostrandoFormularioAgregar = false;

      this.snackBar.open(`✅ ${producto.Nombre_Producto} agregado al pedido`, 'Cerrar', {
        duration: 2000,
        panelClass: ['success-snackbar']
      });

    } catch (error) {
      this.snackBar.open('Error crítico al agregar el producto', 'Cerrar', {
        duration: 3000,
        panelClass: ['error-snackbar']
      });
    }
  }


  private validarProductoParaAgregarEdicion(producto: any): boolean {
    if (!producto.cantidadSeleccionada || producto.cantidadSeleccionada <= 0) {
      this.snackBar.open('Ingrese una cantidad válida > 0', 'Cerrar', {
        duration: 3000,
        panelClass: ['warning-snackbar']
      });
      return false;
    }

    if (!producto.precioVentaSeleccionado) {
      this.snackBar.open('Seleccione un precio de venta', 'Cerrar', {
        duration: 3000,
        panelClass: ['warning-snackbar']
      });
      return false;
    }

    // Verificar si el producto ya fue agregado al pedido
    const yaExiste = this.productosEditados.some(item =>
      item.idProducto === producto.Id_Producto &&
      item.idPrecioVenta === producto.precioVentaSeleccionado.IdPrecio
    );

    if (yaExiste) {
      this.snackBar.open('Este producto ya está en el pedido con la misma unidad y precio', 'Cerrar', {
        duration: 3000,
        panelClass: ['warning-snackbar']
      });
      return false;
    }

    return true;
  }

  toggleFormularioAgregar() {
    this.mostrandoFormularioAgregar = !this.mostrandoFormularioAgregar;
    if (!this.mostrandoFormularioAgregar) {
      this.filtroProductoEdicion = '';
      this.productosFiltradosEdicion = [];
    }
  }
  //#endregion

  gestionarPedido(pedido: any) {
    this.pedidoSeleccionado = pedido;
  }

  calcularStockDisponible(producto: any): number {
    const stock = Number(producto.Stock) || 0;
    const stockPedido = Number(producto.StockPedido) || 0;
    return Math.max(0, stock - stockPedido);
  }

  private generarIdUnico(): string {
    return Date.now().toString(36) + Math.random().toString(36).substr(2);
  }

  private validarProductoParaAgregar(producto: any): boolean {
    // Validación de cantidad
    if (!producto.cantidadSeleccionada || producto.cantidadSeleccionada <= 0) {
      alert('Ingrese una cantidad válida > 0');
      return false;
    }

    // Validación de precio de venta
    if (!producto.precioVentaSeleccionado) {
      alert('Seleccione un precio de venta');
      return false;
    }

    // Verificar si el producto ya fue agregado al pedido (por ID y precio)
    const yaExiste = this.productosSeleccionados.some(item =>
      item.idProducto === producto.Id_Producto &&
      item.idPrecioVenta === producto.precioVentaSeleccionado.IdPrecio
    );

    if (yaExiste) {
      alert('Ya tiene este producto con la misma unidad y precio en el pedido. Elimine el existente para agregar una nueva cantidad.');
      return false;
    }

    return true;
  }

  async eliminarDelPedido(index: number) {
    const item = this.productosSeleccionados[index];

    try {
      const cantidadRevertir = item.necesitaConversion ?
        item.cantidad * item.factorConversion :
        item.cantidad;

      const productoActualizado = {
        Transaccion: 'editar_stock_pedido',
        Id_Producto: item.idProducto,
        StockPedido: -Math.abs(cantidadRevertir) // Siempre negativo
      };

      await firstValueFrom(this.productoService.editarProducto(
        item.idProducto,
        productoActualizado
      ));

    } catch (error) {
      console.error('❌ Error al revertir stock pedido:', error);
      alert('Error al revertir el stock del producto');
      return;
    }

    // Actualizar localmente
    const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
    if (productoEnLista) {
      const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
      const cantidadRevertir = item.necesitaConversion ?
        item.cantidad * item.factorConversion :
        item.cantidad;

      productoEnLista.StockPedido = Math.max(0, stockPedidoActual - cantidadRevertir);
      productoEnLista.StockPedido = productoEnLista.StockPedido || 0;
      this.productos = [...this.productos];
    }

    this.productosSeleccionados.splice(index, 1);
  }

  private async revertirStockPedido(): Promise<void> {
    if (this.productosSeleccionados.length === 0) {
      return;
    }

    try {
      for (const item of this.productosSeleccionados) {
        const cantidadRevertir = item.necesitaConversion ?
          item.cantidad * item.factorConversion :
          item.cantidad;

        // Enviar cantidad NEGATIVA para que el backend la reste
        const productoActualizado = {
          Transaccion: 'editar_stock_pedido',
          Id_Producto: item.idProducto,
          StockPedido: -Math.abs(cantidadRevertir) // Siempre negativo
        };

        await firstValueFrom(this.productoService.editarProducto(
          item.idProducto,
          productoActualizado
        ));

        // Actualizar localmente - asegurar que nunca sea null
        const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
        if (productoEnLista) {
          const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
          productoEnLista.StockPedido = Math.max(0, stockPedidoActual - cantidadRevertir);
          productoEnLista.StockPedido = productoEnLista.StockPedido || 0;
        }
      }
    } catch (error) {
      console.error('❌ Error al revertir stock del pedido:', error);
    }
  }

  private obtenerPorcentajeIVA(): number {
    if (this.iva.length > 0 && this.iva[0].Porcentaje !== undefined) {
      return this.iva[0].Porcentaje / 100;
    }
    return 0.12; // 12% por defecto
  }

  calcularSubTotal(): number {
    return this.productosSeleccionados.reduce((total, item) => total + item.subtotal, 0);
  }

  calcularIVA(): number {
    return this.productosSeleccionados.reduce((total, item) => total + item.iva, 0);
  }

  calcularTotal(): number {
    return this.productosSeleccionados.reduce((total, item) => total + item.total, 0);
  }

  async confirmarPedido() {
    Swal.fire({
      title: 'Confirmar Pedido',
      html: `
            <div class="text-start">
                <p>¿Está seguro de confirmar la creación de este pedido?</p>
            </div>
        `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: 'rgba(38, 218, 77, 1)',
      confirmButtonText: 'Si, crear pedido',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false,
      showClass: { popup: 'animate_animated animatefadeIn animate_faster' }
    }).then((result) => {
      if (result.isConfirmed) {
        this.crearPedido();
      }
    });
  }

  private async crearPedido() {
    try {
      const pedido = {
        Transaccion: 'agregar_pedido',
        IdCliente: this.nombreCliente.trim(),
        SubTotal: this.calcularSubTotal(),
        IVA: this.calcularIVA(),
        Total: this.calcularTotal()
      };

      const respuesta = await firstValueFrom(
        this.pedidoService.agregarPedido(pedido) as Observable<RespuestaPedido>);

      if (respuesta && respuesta.IdPedido && respuesta.CodigoPedido) {
        const idPedido = respuesta.IdPedido;
        const codigoPedido = respuesta.CodigoPedido;

        await this.guardarDetallesPedido(idPedido, codigoPedido);
        await this.actualizarStockProductos();

        this.cerrarModalAgregarPedido();
        this.obtenerPedidos();

        Swal.fire({
          title: '¡Pedido Creado!',
          text: 'El pedido ha sido creado correctamente',
          icon: 'success',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: 'rgba(38, 218, 77, 1)',
          showClass: { popup: "animate_animated animatefadeIn animate_faster" },
        });
      }
    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.error('Error al agregar el pedido', errorMessage);

      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Error al crear el pedido',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#d33',
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });
    }
  }

  calcularSubTotalPedido(): number {
    if (!this.detallePedido || this.detallePedido.length === 0) {
      return 0;
    }
    return this.detallePedido.reduce((total, detalle) => total + detalle.SubTotalProducto, 0);
  }

  calcularTotalIvaPedido(): number {
    if (!this.detallePedido || this.detallePedido.length === 0) {
      return 0;
    }
    return this.detallePedido.reduce((total, detalle) => total + detalle.IvaProducto, 0);
  }

  calcularTotalPedido(): number {
    return this.calcularSubTotalPedido() + this.calcularTotalIvaPedido();
  }

  private async actualizarStockProductos(): Promise<void> {
    try {
      for (const item of this.productosSeleccionados) {
        // Calcular la cantidad a descontar (considerando si es necesaria la conversión)
        const cantidadADescontar = item.necesitaConversion ?
          item.cantidad * item.factorConversion :
          item.cantidad;

        // Datos para actualizar el stock
        const datosActualizacion = {
          Transaccion: 'editar_stock',
          Id_Producto: item.idProducto,
          Stock: -Math.abs(cantidadADescontar)
        };

        await firstValueFrom(this.productoService.editarProducto(item.idProducto, datosActualizacion));

        const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
        if (productoEnLista) {
          const stockActual = Number(productoEnLista.Stock) || 0;
          productoEnLista.Stock = Math.max(0, stockActual - cantidadADescontar);
        }
      }
    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.error('❌ Error al actualizar stock de productos:', errorMessage);
      throw new Error('No se pudo actualizar el stock de los productos');
    }
  }

  private async guardarDetallesPedido(idPedido: number, codigoPedido: string) {
    try {
      const detallePromesas = this.productosSeleccionados.map(async (item) => {
        const detalle = {
          Transaccion: 'agregar_detalle_pedido',
          CodigoPedido: codigoPedido,
          IdPedido: idPedido,
          IdProducto: item.idProducto,
          CodigoProducto: item.codigoProducto,
          NombreProducto: item.nombreProducto,
          Marca: item.marca,
          PrecioUnitario: item.precioUnitario,
          IdUnidad: item.idUnidadMedida,
          UnidadMedida: item.unidadMedida,
          IdPrecioVenta: item.idPrecioVenta,
          ImpuestoProducto: item.impuestoProducto,
          PorcentajeIva: this.iva[0]?.Porcentaje || 12,
          CantidadSeleccionada: item.cantidad,
          SubTotal: item.subtotal,
          IVA: item.iva,
          Total: item.total,
          NecesitaConversion: item.necesitaConversion ? 'S' : 'N',
          FactorConversion: item.factorConversion,
          IdConversionVenta: item.idConversionVenta
        };
        return firstValueFrom(this.pedidoService.agregarDetallePedido(detalle));
      });

      await Promise.all(detallePromesas);

    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.error('Error al guardar el detalle del pedido ', errorMessage);
      throw new Error('No se pudieron guardar los detalles del pedido');
    }
  }

  private async cargarDetallesPedidoCompleto(IdPedido: number): Promise<void> {
    return new Promise((resolve, reject) => {
      this.pedidoService.getDetallePedido(IdPedido, 'consulta_detalle_pedido').subscribe(
        (data: any) => {
          // console.log('Respuesta completa del servidor:', data);
          // console.log('Primer elemento del detalle:', data[0]);

          if (Array.isArray(data)) {
            this.detallePedido = data;
            resolve();
          } else {
            reject(new Error('Formato de datos inválido'));
          }
        },
        (error) => reject(error)
      );
    });
  }

  //#region Métodos de edición de pedidos
  async abrirModalEdicion(pedido: any) {
    this.pedidoEditando = pedido;
    this.isModalEdicionVisible = true;
    this.productosEditados = [];
    this.productosOriginales.clear();
    this.filtroProductoEdicion = '';
    this.productosFiltradosEdicion = [];
    this.mostrandoFormularioAgregar = false;

    try {
      // Cargar detalles del pedido desde el backend
      await this.cargarDetallesPedidoCompleto(pedido.IdPedido);

      // Mapear los datos recibidos a ItemPedido
      this.productosEditados = this.detallePedido.map((detalle: any) => {
        const precioUnitario = detalle.PrecioUnitario ||
          (detalle.Cantidad > 0 ? detalle.SubTotalProducto / detalle.Cantidad : 0);

        const item: ItemPedido = {
          idItem: detalle.IdDetallePedido?.toString() || this.generarIdUnico(),
          idProducto: detalle.IdProducto,
          codigoProducto: detalle.CodigoProducto,
          nombreProducto: detalle.NombreProducto,
          marca: detalle.Marca || '',
          cantidad: Number(detalle.Cantidad || 0),
          cantidadOriginal: Number(detalle.Cantidad || 0), // Guardar cantidad original
          precioUnitario: Number(precioUnitario),
          unidadMedida: detalle.ModoVenta,
          idPrecioVenta: detalle.IdPrecioVenta || 0,
          idUnidadMedida: detalle.IdUnidadMedida,
          //necesitaConversion: Boolean(detalle.NecesitaConversion),
          necesitaConversion: detalle.NecesitaConversion === 'S',
          //necesitaConversion: ['S', 's', 'true', 'TRUE', '1'].includes(String(detalle.NecesitaConversion)),
          factorConversion: Number(detalle.FactorConversion || 1),
          idConversionVenta: detalle.IdConversionVenta,
          impuestoProducto: detalle.ImpuestoProducto || 'N',
          subtotal: Number(detalle.SubTotalProducto || 0),
          iva: Number(detalle.IvaProducto || 0),
          total: Number(detalle.Total || detalle.SubTotalProducto + detalle.IvaProducto || 0),
          fechaAgregado: new Date(),
          porcentajeIva: Number(detalle.PorcentajeIva || this.iva[0]?.Porcentaje || 12),
          esNuevo: false // Producto existente
        };

        // Guardar copia original para comparación
        this.productosOriginales.set(item.idItem, { ...item });

        return item;
      });

      //console.log('✅ Productos cargados para edición:', this.productosEditados);

    } catch (error) {
      console.error('Error al abrir edición:', error);
      this.snackBar.open('Error al cargar el pedido para edición', 'Cerrar', {
        duration: 3000,
        panelClass: ['error-snackbar']
      });
    }
  }

  actualizarCantidadEdicion(index: number, event: any) {
    const nuevaCantidad = Number(event.target.value);
    console.log('Nueva cantidad', nuevaCantidad);

    if (nuevaCantidad <= 0 || isNaN(nuevaCantidad)) {
      this.snackBar.open('La cantidad debe ser mayor a 0', 'Cerrar', {
        duration: 3000,
        panelClass: ['warning-snackbar']
      });
      return;
    }

    const productoEditado = this.productosEditados[index];
    const productoOriginal = this.productos.find(p => p.Id_Producto === productoEditado.idProducto);

    // Validar stock disponible
    if (productoOriginal) {
      const stockDisponible = this.calcularStockDisponible(productoOriginal);
      const cantidadOriginalItem = productoEditado.cantidadOriginal || 0;

      // Para productos existentes, sumar la cantidad original al stock disponible
      const stockTotalDisponible = productoEditado.esNuevo ?
        stockDisponible :
        stockDisponible + cantidadOriginalItem;

      if (nuevaCantidad > stockTotalDisponible) {
        this.snackBar.open(
          `Stock insuficiente. Disponible: ${stockTotalDisponible} ${productoEditado.unidadMedida}`,
          'Cerrar',
          {
            duration: 3000,
            panelClass: ['error-snackbar']
          }
        );
        return;
      }
    }

    productoEditado.cantidad = nuevaCantidad;
    productoEditado.subtotal = nuevaCantidad * productoEditado.precioUnitario;
    productoEditado.iva = (productoEditado.impuestoProducto === 'S') ?
      productoEditado.subtotal * ((productoEditado.porcentajeIva ?? 12) / 100) : 0;
    productoEditado.total = productoEditado.subtotal + productoEditado.iva;

    this.actualizarTotalesEdicion();
  }


  async eliminarItemEdicion(index: number) {
    const item = this.productosEditados[index];
    //console.log('Eliminando item de edición:', item);

    const result = await Swal.fire({
      title: '¿Estás seguro?',
      text: `¿Estás seguro de eliminar "${item.nombreProducto}" del pedido?`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Sí, eliminar',
      cancelButtonText: 'Cancelar',
      reverseButtons: true,
      backdrop: true,
      allowOutsideClick: false,
      customClass: {
        popup: 'custom-swal-popup',
      }
    });

    //Si el usuario confirma la eliminación
    if (result.isConfirmed) {
      try {
        // Mostrar loading mientras se procesa
        Swal.fire({
          title: 'Eliminando producto...',
          text: 'Por favor espera',
          allowOutsideClick: false,
          didOpen: () => {
            Swal.showLoading();
          }
        });

        // 1. Calcular cantidad a liberar (considerando conversión si aplica)
        const cantidadLiberar = item.necesitaConversion ?
          item.cantidad * item.factorConversion :
          item.cantidad;

        // 2. Actualizar stock
        const productoActualizado = {
          Transaccion: 'editar_stock',
          Id_Producto: item.idProducto,
          Stock: cantidadLiberar
        };

        await firstValueFrom(this.productoService.editarProducto(
          item.idProducto,
          productoActualizado
        ));

        // 3. Eliminar detalle del pedido
        const detalleEliminar = {
          Transaccion: 'eliminar_producto_detalle',
          IdItem: item.idItem,
          IdProducto: item.idProducto,
          IdPedido: this.pedidoEditando.IdPedido
        };

        await firstValueFrom(this.pedidoService.agregarDetallePedido(detalleEliminar));

        //4. Actualizar localmente
        const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
        if (productoEnLista) {
          productoEnLista.Stock = (productoEnLista.Stock || 0) + cantidadLiberar;
          productoEnLista.StockPedido = Math.max(0, (productoEnLista.StockPedido || 0) - cantidadLiberar);
        }

        //5. Forzar actualización del array de productos para detectar cambios
        this.productos = [...this.productos];

        //6. Si hay productos filtrados, también actualizarlos
        if (this.productosFiltradosEdicion.length > 0) {
          this.filtrarProductosEdicion();
        }

        //7. Eliminar del array de edición
        this.productosEditados.splice(index, 1);
        this.actualizarTotalesEdicion();

        //8. Actualizar el pedido
        await this.actualizarPedido();

        //Cerrar loading y mostrar éxito
        //Swal.close();

        //Cerrar el modal
        this.cerrarModalEdicion();
        this.obtenerPedidos();

        Swal.fire({
          title: '¡Éxito!',
          text: 'Producto eliminado correctamente',
          icon: 'success',
          timer: 1500,
          showConfirmButton: false
        });

      } catch (error) {
        console.error('Error al eliminar producto:', error);

        //Cerrar loading y mostrar el error
        Swal.close();

        Swal.fire({
          title: 'Error',
          text: 'No se pudo eliminar el producto',
          icon: 'error',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: '#d33',
        });
      }
    }
  }

  async revertirStockEdicion(): Promise<void> {
    try {
      const pedidosNuevosDevolver = this.productosEditados.filter(item => item.esNuevo);
      for (const item of pedidosNuevosDevolver) {
        const cantidadARevertir = item.necesitaConversion ?
          item.cantidad * item.factorConversion :
          item.cantidad;

        //Enviar cantidad para hacer la resta
        const productoActualizado = {
          Transaccion: 'editar_stock_pedido',
          Id_Producto: item.idProducto,
          StockPedido: -Math.abs(cantidadARevertir)
        };

        await firstValueFrom(this.productoService.editarProducto(
          item.idProducto,
          productoActualizado
        ));

        const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
        if (productoEnLista) {
          const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
          productoEnLista.StockPedido = Math.max(0, stockPedidoActual - cantidadARevertir);
          productoEnLista.StockPedido = productoEnLista.StockPedido || 0;
        }
      }
    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.error('Error al revertir stock del pedido:', errorMessage);
    }
  }

  async eliminarDelPedidoEdicion(index: number) {
    const item = this.productosEditados[index];

    try {
      const cantidadRevertir = item.necesitaConversion ?
        item.cantidad * item.factorConversion :
        item.cantidad;

      const productoActualizado = {
        Transaccion: 'editar_stock_pedido',
        Id_Producto: item.idProducto,
        StockPedido: -Math.abs(cantidadRevertir)
      }

      await firstValueFrom(this.productoService.editarProducto(
        item.idProducto,
        productoActualizado
      ));

    } catch (error) {
      console.error('Error el revertir stock pedido:', error);
      alert('Error al revertir el stock del producto');
      return;
    }

    //Actualizar loclamente
    const productoEnLista = this.productos.find(p => p.Id_Producto === item.idProducto);
    if (productoEnLista) {
      const stockPedidoActual = Number(productoEnLista.StockPedido || 0);
      const cantidadRevertir = item.necesitaConversion ?
        item.cantidad * item.factorConversion :
        item.cantidad;

      productoEnLista.StockPedido = Math.max(0, stockPedidoActual - cantidadRevertir);
      productoEnLista.StockPedido = productoEnLista.StockPedido || 0;
      this.productos = [...this.productos];
    }
    this.productosEditados.splice(index, 1);
  }

  async confirmarEdicionPedido() {
    Swal.fire({
      title: 'Confirmar Edición',
      icon: 'warning',
      html: `
            <div class="text-start">
                <p>¿Está seguro de confirmar la edición de este pedido?</p>
            </div>
        `,
      showConfirmButton: true,
      showCancelButton: true,
      confirmButtonText: 'Si, editar pedido',
      confirmButtonColor: 'rgba(38, 218, 77, 1)',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false,
      showClass: { popup: "animate_animated animatefadeIn animate_faster" },
    }).then((result) => {
      if (result.isConfirmed) {
        this.editarPedido();
      }
    });
  }

  private async editarPedido() {
    try {
      await this.actualizarPedido();
      await this.guardarDetallesPedidoEdicion(this.pedidoEditando.IdPedido, this.pedidoEditando.CodigoPedido);
      await this.actualizarStockProductosEdicion();

      // Cerrar modal y actualizar lista de pedidos
      this.cerrarModalEdicion();
      this.obtenerPedidos();

      Swal.fire({
        title: '¡Pedido Editado!',
        text: 'El pedido ha sido editado correctamente',
        icon: 'success',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: 'rgba(38, 218, 77, 1)',
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });

    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.log('Error al editar el pedido', errorMessage);

      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Error al crear el pedido',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#d33',
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });
    }
  }

  private async guardarDetallesPedidoEdicion(idPedido: number, codigoPedido: string) {
    try {
      const productosNuevos = this.productosEditados.filter(item => item.esNuevo);
      //const detallesPromesas = this.productosEditados.map(async (item) => {
      const detallesPromesas = productosNuevos.map(async (item) => {
        const detalle = {
          Transaccion: 'agregar_detalle_pedido',
          CodigoPedido: codigoPedido,
          IdPedido: idPedido,
          IdProducto: item.idProducto,
          CodigoProducto: item.codigoProducto,
          NombreProducto: item.nombreProducto,
          Marca: item.marca,
          PrecioUnitario: item.precioUnitario,
          IdUnidad: item.idUnidadMedida,
          UnidadMedida: item.unidadMedida,
          IdPrecioVenta: item.idPrecioVenta,
          ImpuestoProducto: item.impuestoProducto,
          PorcentajeIva: this.iva[0]?.Porcentaje || 12,
          CantidadSeleccionada: item.cantidad,
          SubTotal: item.subtotal,
          IVA: item.iva,
          Total: item.total,
          NecesitaConversion: item.necesitaConversion ? 'S' : 'N',
          FactorConversion: item.factorConversion,
          IdConversionVenta: item.idConversionVenta
        };
        return firstValueFrom(this.pedidoService.agregarDetallePedido(detalle));
      });

      await Promise.all(detallesPromesas);

    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.log('Error al guardar los nuevos detalles del pedido', errorMessage);
      throw new Error('No se pudieron guardar los nuevos detalles del pedido');
    }
  }

  private async actualizarStockProductosEdicion(): Promise<void> {
    //console.log('🔄 Actualizando stock de productos nuevos');

    // Filtrar solo productos nuevos
    const productosNuevos = this.productosEditados.filter(item => item.esNuevo);

    if (productosNuevos.length === 0) {
      return;
    }

    try {
      for (const item of productosNuevos) {
        const cantidadADescontar = item.necesitaConversion ?
          item.cantidad * item.factorConversion :
          item.cantidad;

        const datosActualizacion = {
          Transaccion: 'editar_stock',
          Id_Producto: item.idProducto,
          Stock: -cantidadADescontar  // Negativo para descontar
        };

        await firstValueFrom(
          this.productoService.editarProducto(item.idProducto, datosActualizacion)
        );
      }

      console.log(`✅ Stock actualizado para ${productosNuevos.length} productos`);

    } catch (error) {
      console.error('Error al actualizar stock:', error);
      throw new Error('No se pudo actualizar el stock de los productos');
    }
  }

  private async actualizarPedido(): Promise<void> {
    try {
      const pedidoActualizar = {
        Transaccion: 'editar_pedido',
        IdPedido: this.pedidoEditando.IdPedido,
        SubTotal: this.subtotalEdicion,
        IVA: this.ivaEdicion,
        Total: this.totalEdicion
      };

      //console.log('Actualizando pedido con:', pedidoActualizar);
      await firstValueFrom(this.pedidoService.editarPedido(
        this.pedidoEditando.IdPedido,
        pedidoActualizar
      ));

      // También actualizar localmente el pedido en edición
      this.pedidoEditando.SubTotal = this.subtotalEdicion;
      this.pedidoEditando.IVA = this.ivaEdicion;
      this.pedidoEditando.Total = this.totalEdicion;

      // 

    } catch (error) {
      console.error('Error al actualizar pedido en backend:', error);
      throw new Error('No se pudo actualizar los totales del pedido');
    }
  }

  private actualizarTotalesEdicion() {
    // Forzar actualización de las propiedades computadas
    this.productosEditados = [...this.productosEditados];
  }

  // Getters para los totales (se actualizan automáticamente)
  get subtotalEdicion(): number {
    return this.productosEditados.reduce((total, item) => total + item.subtotal, 0);
  }

  get ivaEdicion(): number {
    return this.productosEditados.reduce((total, item) => total + item.iva, 0);
  }

  get totalEdicion(): number {
    return this.subtotalEdicion + this.ivaEdicion;
  }
  //#endregion
}


