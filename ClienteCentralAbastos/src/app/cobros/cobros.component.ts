import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { PedidoService } from '../servicios/pedido.service';
import { FormControl, FormGroup, Validators, ReactiveFormsModule, FormsModule, ValidationErrors, AbstractControl } from '@angular/forms';
import { firstValueFrom, Observable } from 'rxjs';
import { FacturaService } from '../servicios/factura.service';
import Swal from 'sweetalert2';
import { ClienteService } from '../servicios/cliente.service';

export interface RespuestFactura {
  IdFactura: number,
  CodigoFactura: string;
}

export interface Cliente {
  CodigoIdentificacion: string,
  CodigoTipoId: string,
  NombresCliente: string,
  ApellidosCliente: string,
  TelefonoCliente: string,
  EmailCliente: string
}

@Component({
  selector: 'app-cobros',
  imports: [MatIconModule, CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './cobros.component.html',
  styleUrl: './cobros.component.css'
})
export class CobrosComponent implements OnInit {

  pedidos: any[] = [];
  detallePedido: any[] = [];

  isModalVisible: boolean = false;
  isModalFacturarVisible: boolean = false;
  facturaConDatos: boolean = false;

  tipoFacturacion: string = 'consumidorFinal';

  private idClienteGuardado: string = '';
  private tipoIdClienteGuardado: string = '';

  idPedido: any;
  idCliente: any;
  codigoPedido: any;
  subTotalPedido: any;
  ivaPedido: any;
  totalPedido: any;
  filtro: string = '';
  paginaActual: number = 1;
  itemsPorPagina: number = 5;
  opcionesPorPagina: number[] = [5, 10, 20];
  paginasTotales: number = 0;
  pedidosFiltrados: any[] = [];
  pedidosPaginados: any[] = [];
  mensajeNoResultados: string = '';

  pedidoSeleccionado: any;

  //Variables para campos editables
  camposEditables = {
    id: true,
    tipo: true,
    nombre: true,
    apellido: true,
    telefono: true,
    email: true,
  };

  clienteEncontrado: boolean = false;

  formCliente = new FormGroup({
    TipoIdCliente: new FormControl('', Validators.required),
    IdCliente: new FormControl('', [Validators.required, this.validarIdentificacion.bind(this)]),
    NombreCliente: new FormControl('', Validators.required),
    ApellidoCliente: new FormControl('', Validators.required),
    TelefonoCliente: new FormControl('', [
      Validators.required,
      Validators.pattern(/^[0-9]{10}$/)
    ]),
    EmailCliente: new FormControl('', [
      Validators.required,
      Validators.email
    ])
  });


  constructor(private pedidoService: PedidoService,
    private facturaService: FacturaService,
    private clienteService: ClienteService) { }

  ngOnInit(): void {
    this.obtenerPedidos();
  }

  filtrarPedidos() {
    const texto = this.filtro.trim().toLocaleLowerCase();
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
        } else {
          console.log('Error la respuesta del API no es un array', data);
        }
      },
      (error: any) => {
        const errorMessage = JSON.stringify(error, null, 2);
        console.error('Error al obtener los pedidos', errorMessage);
      }
    );
  }

  obtenerDetallePedido() {
    this.detallePedido = [];

    this.pedidoService.getDetallePedido(this.pedidoSeleccionado.IdPedido, 'consulta_detalle_pedido').subscribe(
      (data: any) => {
        if (data.mensaje) {
          console.log(data.mensaje);
        } else if (Array.isArray(data)) {
          this.detallePedido = data;
          console.log('Detalle pedido:', this.detallePedido);
        } else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error en la solicitud al servidor. Consulte con el administrador', errorMessage);
      }
    );
  }

  consultarPedido(pedido: any) {
    this.pedidoSeleccionado = pedido;
    this.isModalVisible = true;

    if (this.pedidoSeleccionado.IdPedido) {
      this.obtenerDetallePedido();
    }
  }

  facturarPedido(pedido: any) {
    this.pedidoSeleccionado = pedido;
    this.isModalFacturarVisible = true;

    if (this.pedidoSeleccionado.IdPedido) {
      this.obtenerDetallePedido();
    }
  }

  actualizarEstadoCampos(): void {

    if (this.camposEditables.id) {
      this.formCliente.get('IdCliente')?.enable();
    } else {
      this.formCliente.get('IdCliente')?.disable();
    }

    if (this.camposEditables.tipo) {
      this.formCliente.get('TipoIdCliente')?.enable();
    } else {
      this.formCliente.get('TipoIdCliente')?.disable();
    }

    if (this.camposEditables.nombre) {
      this.formCliente.get('NombreCliente')?.enable();
    } else {
      this.formCliente.get('NombreCliente')?.disable();
    }

    if (this.camposEditables.apellido) {
      this.formCliente.get('ApellidoCliente')?.enable();
    } else {
      this.formCliente.get('ApellidoCliente')?.disable();
    }

    if (this.camposEditables.telefono) {
      this.formCliente.get('TelefonoCliente')?.enable();
    } else {
      this.formCliente.get('TelefonoCliente')?.disable();
    }

    if (this.camposEditables.email) {
      this.formCliente.get('EmailCliente')?.enable();
    } else {
      this.formCliente.get('EmailCliente')?.disable();
    }
  }

  habilitarTodosLosCampos(): void {
    this.camposEditables = {
      id: true,
      tipo: true,
      nombre: true,
      apellido: true,
      telefono: true,
      email: true
    };
    this.actualizarEstadoCampos();
  }

  puedeBuscarCliente(): boolean {
    const idCliente = this.formCliente.get('IdCliente')?.value;
    const tipoId = this.formCliente.get('TipoIdCliente')?.value;
    return !!idCliente && !!tipoId;
  }

  onIdentificacionBlur(): void {
    if (this.puedeBuscarCliente()) {
      this.buscarCliente();
    }
  }

  async buscarCliente(): Promise<void> {

    const idClienteControl = this.formCliente.get('IdCliente');

    if (idClienteControl?.invalid) {
      this.mostrarErrorValidacion();
      return;
    }

    const CodigoIdentificacion = this.formCliente.get('IdCliente')?.value;
    const CodTipoId = this.formCliente.get('TipoIdCliente')?.value;
    const Transaccion = 'consultar_cliente';

    console.log('Valores del formulario:', {
      CodigoIdentificacion,
      CodTipoId,
      Transaccion
    });

    if (!CodigoIdentificacion || !CodTipoId) {
      console.log('Faltan datos en el formulario');
      return;
    }

    try {
      const cliente = await firstValueFrom(
        this.clienteService.buscarCliente(
          CodigoIdentificacion,
          CodTipoId,
          Transaccion
        )
      );

      if (cliente && cliente.length > 0) {
        console.log('Cliente encontrado:', cliente[0]);
        this.cargarDatosCliente(cliente[0]);
        this.clienteEncontrado = true;
      } else {
        console.log('No se encontró el cliente');
        this.clienteEncontrado = false;
        this.habilitarTodosLosCampos();
      }

    } catch (error) {
      console.error('Error al buscar cliente:', error);
      this.clienteEncontrado = false;
    }
  }

  cargarDatosCliente(cliente: any): void {

    // Guardar los valor de identificacion antes de deshabilitar
    this.idClienteGuardado = cliente.IdentificacionCliente;
    this.tipoIdClienteGuardado = cliente.CodTipoIdentificacion;

    this.formCliente.patchValue({
      TipoIdCliente: cliente.CodTipoIdentificacion,
      IdCliente: cliente.IdentificacionCliente,
      NombreCliente: cliente.NombresCliente,
      ApellidoCliente: cliente.ApellidosCliente,
      TelefonoCliente: cliente.TelefonoCliente,
      EmailCliente: cliente.EmailCliente
    });

    this.camposEditables = {
      id: false,
      tipo: false,
      nombre: false,
      apellido: false,
      telefono: true,
      email: true
    };

    this.actualizarEstadoCampos();

    console.log('Valores guardados:', {
      idCliente: this.idClienteGuardado,
      tipoId: this.tipoIdClienteGuardado
    });
  }

  async guardarInformacionCliente(): Promise<boolean> {

    if (!this.clienteEncontrado) {
      const idClienteControl = this.formCliente.get('IdCliente');
      if (idClienteControl?.invalid) {
        this.mostrarErrorValidacion();
        return false;
      }
    }

    if (this.formCliente.invalid) {
      this.marcarCamposComoTocados();
      return false;
    }

    const datosCliente = this.formCliente.getRawValue();

    try {
      if (this.clienteEncontrado) {
        const telefono = datosCliente.TelefonoCliente?.trim() || '';
        const email = datosCliente.EmailCliente?.trim() || '';

        if (!telefono || !email) {
          console.error('❌ Teléfono o email están vacíos');
          return false;
        }

        const datosActualizacion = {
          Transaccion: 'actualizar_cliente',
          TelefonoCliente: telefono,
          EmailCliente: email
        };

        await firstValueFrom(
          this.clienteService.editarCliente(
            this.idClienteGuardado,
            this.tipoIdClienteGuardado,
            datosActualizacion
          )
        );



      } else {

        const datosNuevoCliente = {
          Transaccion: 'registrar_cliente',
          CodigoIdentificacion: datosCliente.IdCliente,
          CodigoTipoId: datosCliente.TipoIdCliente,
          NombresCliente: datosCliente.NombreCliente,
          ApellidosCliente: datosCliente.ApellidoCliente,
          TelefonoCliente: datosCliente.TelefonoCliente,
          EmailCliente: datosCliente.EmailCliente
        };

        console.log('Datos a enviar', datosNuevoCliente);

        await firstValueFrom(
          this.clienteService.agregarCliente(datosNuevoCliente)
        );

        this.clienteEncontrado = true;
        this.camposEditables.nombre = false;
        this.camposEditables.apellido = false;
        this.actualizarEstadoCampos();

        console.log('Nuevo cliente guardado');
      }
      return true;
    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.error('❌ Error completo al guardar cliente:', errorMessage);
      return false;
    }
  }

  marcarCamposComoTocados(): void {
    Object.keys(this.formCliente.controls).forEach(key => {
      this.formCliente.get(key)?.markAsTouched();
    });
  }

  private validarIdentificacion(control: AbstractControl): ValidationErrors | null {
    const valor = control.value;

    if (!valor) {
      return null;
    }

    // Obtener el tipo de identificacion seleccionado
    const tipoIdControl = this.formCliente?.get('TipoIdCliente');
    const tipoId = tipoIdControl?.value;

    if (!tipoId) {
      return null;
    }

    if (tipoId === 'C') {
      if (!this.validaCedula(valor)) {
        return { cedulaInvalida: true };
      }
    } else if (tipoId === 'R') {
      if (!/^[0-9]{13}$/.test(valor)) {
        return { rucInvalido: true };
      }
    }
    return null;
  }

  private validaCedula(cedula: string): boolean {
    cedula = cedula.replace(/[-\s]/g, '');

    // Verificar que tenga 10 dígitos
    if (!/^[0-9]{10}$/.test(cedula)) {
      return false;
    }

    // Verificar que los dos primeros digitos sean validos (provincia)
    const provincia = parseInt(cedula.substring(0, 2));
    if (provincia < 1 || provincia > 24) {
      return false;
    }

    const digitos = cedula.split('').map(Number);

    let suma = 0;
    for (let i = 0; i < 9; i++) {
      let multiplicacion = digitos[i] * (i % 2 === 0 ? 2 : 1);
      if (multiplicacion > 9) {
        multiplicacion -= 9;
      }
      suma += multiplicacion;
    }

    const digitoVerificadorCalculado = suma % 10 === 0 ? 0 : 10 - (suma % 10);

    return digitoVerificadorCalculado === digitos[9];
  }

  onTipoIdentificacionChange(): void {
    const idClienteControl = this.formCliente.get('IdCliente');
    if (idClienteControl) {
      idClienteControl.updateValueAndValidity();
    }
  }

  private mostrarErrorValidacion(): void {
    const tipoId = this.formCliente.get('TipoIdCliente')?.value;
    const idClienteControl = this.formCliente.get('IdCliente');

    if (idClienteControl?.errors) {
      if (idClienteControl.errors['cedulaInvalida']) {
        Swal.fire({
          title: 'Cédula inválida',
          text: 'La cédula ingresada no es válida. Por favor, verifique el número.',
          icon: 'error',
          confirmButtonText: 'Entendido'
        });
      } else if (idClienteControl.errors['rucInvalido']) {
        Swal.fire({
          title: 'RUC inválido',
          text: 'El RUC debe tener exactamente 13 dígitos.',
          icon: 'error',
          confirmButtonText: 'Entendido'
        });
      }
    }
  }

  async confirmarFacturacionPedido() {
    const result = await Swal.fire({
      title: 'Confirmar Facturación',
      html: `
            <div class="text-start">
                <p>¿Está seguro de facturar este pedido?</p>
                <p class="text-muted small"><strong>Pedido:</strong> ${this.pedidoSeleccionado.CodigoPedido}</p>
            </div>
        `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: 'rgba(38, 218, 77, 1)',
      confirmButtonText: 'Si, facturar pedido',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false,
      showLoaderOnConfirm: true,
      preConfirm: () => {
        return this.procesarPedidoFacturar();
      }
    });

    if (result.isConfirmed) {
      Swal.fire({
        title: '¡Pedido Facturado!',
        text: 'El pedido ha sido facturado correctamente',
        icon: 'success',
        timer: 1000,
        showConfirmButton: false
      });
      this.obtenerPedidos();
    }
  }

  async procesarPedidoFacturar() {
    if (this.tipoFacturacion === 'conDatos') {
      if (this.formCliente.invalid) {
        Object.keys(this.formCliente.controls).forEach(key => {
          this.formCliente.get(key)?.markAsTouched();
        });
        return
      }

      // Guardar informacion del cliente
      const clienteGuardado = await this.guardarInformacionCliente();
      if (!clienteGuardado) {
        throw new Error('No se puedo guardar la información del cliente');
      }

      try {

        const datosCliente = this.formCliente.getRawValue();
        const datosFactura = {
          Transaccion: 'generar_factura',
          TipoIdCliente: this.tipoIdClienteGuardado || datosCliente.TipoIdCliente,
          IdCliente: this.idClienteGuardado || datosCliente.IdCliente,
          IdPedido: this.pedidoSeleccionado.IdPedido,
          NombreCliente: datosCliente.NombreCliente,
          ApellidoCliente: datosCliente.ApellidoCliente,
          TelefonoCliente: datosCliente.TelefonoCliente,
          EmailCliente: datosCliente.EmailCliente,
          SubTotal: this.pedidoSeleccionado.SubtotalPedido,
          IVA: this.pedidoSeleccionado.IvaPedido,
          TotalFactura: this.pedidoSeleccionado.TotalPedido
        };

        const pedidoFacturar = {
          Transaccion: 'facturar_pedido',
          IdPedido: this.pedidoSeleccionado.IdPedido
        };

        await firstValueFrom(this.pedidoService.editarPedido(this.pedidoSeleccionado.IdPedido, pedidoFacturar));

        const respuesta = await firstValueFrom(
          this.facturaService.agregarFactura(datosFactura) as Observable<RespuestFactura>);

        if (respuesta && respuesta.IdFactura && respuesta.CodigoFactura) {
          const idFactura = respuesta.IdFactura;
          const codigoFactura = respuesta.CodigoFactura;

          await this.guardarDetallePedido(idFactura, codigoFactura);

          this.cerrarModalFacturarPedido();
          this.obtenerPedidos();
        }
      } catch (error) {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error al agregar la factura', errorMessage);
      }
    } else {
      try {
        const datosFactura = {
          Transaccion: 'generar_factura',
          TipoIdCliente: 'N',
          IdCliente: 'N/A',
          IdPedido: this.pedidoSeleccionado.IdPedido,
          NombreCliente: 'N/A',
          ApellidoCliente: 'N/A',
          TelefonoCliente: 'N/A',
          EmailCliente: 'N/A',
          SubTotal: this.pedidoSeleccionado.SubtotalPedido,
          IVA: this.pedidoSeleccionado.IvaPedido,
          TotalFactura: this.pedidoSeleccionado.TotalPedido
        };

        const pedidoFacturar = {
          Transaccion: 'facturar_pedido',
          IdPedido: this.pedidoSeleccionado.IdPedido
        };

        await firstValueFrom(this.pedidoService.editarPedido(this.pedidoSeleccionado.IdPedido, pedidoFacturar));

        const respuesta = await firstValueFrom(
          this.facturaService.agregarFactura(datosFactura) as Observable<RespuestFactura>);

        if (respuesta && respuesta.IdFactura && respuesta.CodigoFactura) {
          const idFactura = respuesta.IdFactura;
          const codigoFactura = respuesta.CodigoFactura;

          await this.guardarDetallePedido(idFactura, codigoFactura);

          this.cerrarModalFacturarPedido();
          this.obtenerPedidos();

          console.log(`✅ Factura del Pedido - ${codigoFactura} confirmada exitosamente`);
        }
      } catch (error) {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error al agregar la factura', errorMessage);
      }
    }
  }

  private async guardarDetallePedido(idFactura: number, codigoFactura: string) {
    try {
      const detallePromesas = this.detallePedido.map(async (item) => {
        const detalle = {
          Transaccion: 'agregar_detalle_factura',
          CodigoFactura: codigoFactura,
          IdFactura: idFactura,
          IdProducto: item.IdProducto,
          CodigoProducto: item.CodigoProducto,
          NombreProducto: item.NombreProducto,
          Marca: item.Marca,
          UnidadMedida: item.ModoVenta,
          CantidadSeleccionada: item.Cantidad,
          PrecioUnitario: item.PrecioUnitario,
          SubTotal: item.SubTotalProducto,
          IVA: item.IvaProducto,
          Total: item.Total,
          ImpuestoProducto: item.ImpuestoProducto,
          PorcentajeIva: item.PorcentajeIva
        };
        return firstValueFrom(this.facturaService.agregarDetalleFactura(detalle));
      });

      await Promise.all(detallePromesas);

    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      console.log('Error al guardar el detalle del pedido', errorMessage);
      throw new Error('No se pudieron guardar los detalles del pedido');
    }
  }

  cerrarModalGestionPedido() {
    this.isModalVisible = false;
  }

  cerrarModalFacturarPedido() {
    this.isModalFacturarVisible = false;
    this.tipoFacturacion = 'consumidorFinal';
    this.limpiarFormulario();
  }

  limpiarFormulario() {
    this.formCliente.reset();
    this.clienteEncontrado = false;
    this.idClienteGuardado = '';
    this.tipoIdClienteGuardado = '';
    this.habilitarTodosLosCampos();
  }

  calcularSubTotal(): number {
    if (!this.detallePedido || this.detallePedido.length === 0) {
      return 0;
    }
    return this.detallePedido.reduce((total, detalle) => total + detalle.SubTotalProducto, 0);
  }

  calcularTotalIva(): number {
    if (!this.detallePedido || this.detallePedido.length === 0) {
      return 0;
    }
    return this.detallePedido.reduce((total, detalle) => total + detalle.IvaProducto, 0);
  }

  calcularTotal(): number {
    return this.calcularSubTotal() + this.calcularTotalIva();
  }

}
