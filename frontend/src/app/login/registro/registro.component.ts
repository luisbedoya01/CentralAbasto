import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { LoginService } from '../../servicios/login.service';
import { FormControl, FormGroup, Validators, ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RolServiceService } from '../../servicios/rol-service.service';
import Swal from 'sweetalert2';
import { firstValueFrom } from 'rxjs';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [MatIconModule, CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './registro.component.html',
  styleUrl: './registro.component.css'
})
export class RegistroComponent implements OnInit {

  usuarios: any[] = [];
  roles: any[] = [];
  usuariosFiltrados: any[] = [];
  usuariosPaginados: any[] = [];
  filtro: string = '';
  paginaActual: number = 1;
  itemsPorPagina: number = 5;
  opcionesPorPagina: number[] = [5, 10, 20];
  paginasTotales: number = 0;
  mensajeNoResultados: string = '';

  isModalVisible: boolean = false;
  isConfirmDeleteModalVisible: boolean = false;
  isModalRolVisible: boolean = false;

  modoEdicion: boolean = false;
  usuarioSeleccionado: any = null;

  idUsuario: any;
  cedulaUsuario: any;
  nombreUsuario: any;
  apellidoUsuario: any;
  rolUsuario: any;
  claveUsuario: any;
  respuesta: any = null;

  nombreRol: any;

  constructor(private loginService: LoginService, private rolService: RolServiceService) { }

  ngOnInit(): void {
    this.obtenerUsuarios();
    this.obtenerRol();
  }

  usuarioForm = new FormGroup({
    IdUsuario: new FormControl(),
    Cedula: new FormControl('', Validators.required),
    Nombres: new FormControl('', Validators.required),
    Apellidos: new FormControl('', Validators.required),
    IdRol: new FormControl('', Validators.required),
    Password: new FormControl(),
    Transaccion: new FormControl(),
  });

  rolForm = new FormGroup({
    Nombre: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  filtrarUsuarios() {
    const texto = this.filtro.toLowerCase();
    this.usuariosFiltrados = this.usuarios.filter(u =>
      u.cedula.toLowerCase().includes(texto) ||
      u.nombres.toLowerCase().includes(texto) ||
      u.apellidos.toLowerCase().includes(texto) ||
      u.rol.toLowerCase().includes(texto)
    );

    if (this.usuariosFiltrados.length === 0) {
      this.mensajeNoResultados = 'No se encontraron usuarios que coincidan con ' + `"${this.filtro}"`;
    } else {
      this.mensajeNoResultados = '';
    }
    this.paginaActual = 1;
    this.actualizarPaginacion();
  }

  actualizarPaginacion() {
    const inicio = (this.paginaActual - 1) * this.itemsPorPagina;
    const fin = inicio + this.itemsPorPagina;
    this.paginasTotales = Math.ceil(this.usuariosFiltrados.length / this.itemsPorPagina);
    this.usuariosPaginados = this.usuariosFiltrados.slice(inicio, fin);
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

  obtenerUsuarios() {
    this.loginService.getUsuario('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.usuarios = data;
          this.usuariosFiltrados = data;
          //console.log('Usuarios obtenidos:', this.usuarios);
          this.filtrarUsuarios();
        } else {
          console.error('Error: La respuesta no es un arreglo', data);
        }
      },
      (error: any) => {
        console.error('Error al obtener los usuarios:', error);
      }
    );
  }

  guardarUsuario() {
    this.idUsuario = this.usuarioForm.value.IdUsuario;
    this.cedulaUsuario = this.usuarioForm.value.Cedula;
    this.nombreUsuario = this.usuarioForm.value.Nombres;
    this.apellidoUsuario = this.usuarioForm.value.Apellidos;
    this.rolUsuario = this.usuarioForm.value.IdRol;
    this.usuarioForm.value.Password = this.usuarioForm.value.Cedula;
    this.usuarioForm.value.Transaccion = this.modoEdicion ? 'editar_usuario' : 'registrar';

    //console.log('Datos del usuario:', this.usuarioForm.value);



    if (!this.validaCedula(this.cedulaUsuario)) {
      Swal.fire({
        icon: 'error',
        title: 'Cédula Inválida',
        text: 'La cédula ingresada no es válida. Por favor, verifique el número.',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#d33',
      });
      return;
    }


    if (this.usuarioForm.valid) {
      if (this.modoEdicion) {
        this.loginService.editarUsuario(this.usuarioSeleccionado.id, this.usuarioForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            if (data.length === 0) {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Error al editar el usuario',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#d33',
              });
            } else {
              this.obtenerUsuarios();
              this.cerrarModal();
              Swal.fire({
                title: '¡Usuario Editado!',
                text: 'El usuario ha sido editado correctamente',
                icon: 'success',
                timer: 1000,
                showConfirmButton: false
              });
            }
            console.log('Respuesta de la API:', data);
          },
          (error: any) => {
            console.error('Error al editar el usuario:', error);
          }
        );
      } else {
        console.log('Guardando nuevo usuario:', this.usuarioForm.value);
        this.loginService.registro(this.usuarioForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            if (data.length === 0) {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se pudo registrar el usuario',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#d33',
              });
            } else {
              this.obtenerUsuarios();
              this.cerrarModal();
              Swal.fire({
                title: '¡Usuario Registrado!',
                text: 'El usuario ha sido registrado correctamente',
                icon: 'success',
                timer: 1000,
                showConfirmButton: false
              });

            }
            console.log('Respuesta de la API:', data);
          },
          (error: any) => {
            const errorMessage = JSON.stringify(error, null, 2);
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'Error al registrar usuario ' + errorMessage,
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
              showClass: { popup: "animate_animated animatefadeIn animate_faster" },
            });
          }
        );
      }
    }
  }

  editarUsuario(usuario: any) {
    this.modoEdicion = true;
    this.usuarioSeleccionado = usuario;
    this.isModalVisible = true;

    this.usuarioForm.patchValue({
      IdUsuario: usuario.id,
      Cedula: usuario.cedula,
      Nombres: usuario.nombres,
      Apellidos: usuario.apellidos,
      IdRol: usuario.idrol,
    });
  }

  private validaCedula(cedula: string): boolean {
    cedula = cedula.replace(/[-\s]/g, '');

    // Verificar que tenga 10 digitos
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

  actualizarClaveUsuario(usuario: any) {
    this.usuarioSeleccionado = usuario;
    const nombreUsuario = this.usuarioSeleccionado.nombres + ' ' + this.usuarioSeleccionado.apellidos;
    Swal.fire({
      title: 'Confirmar cambio',
      html: `
          <div class="text-start">
              <p>¿Está seguro de cambiar la clave del usuario?</p>
          </div>
          <div class="text-center">
              <strong><p class="text-muted small">${nombreUsuario}</p></strong>
          </div>
      `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sí, cambiar',
      confirmButtonColor: 'rgba(51, 105, 221, 1)',
      cancelButtonColor: '#6c757d',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false
    }).then((result) => {
      if (result.isConfirmed) {
        this.procesarCambioClave();
      }
    });
  }

  async procesarCambioClave(): Promise<void> {
    Swal.fire({
      title: 'Actualizando...',
      text: 'Por favor, espere un momento.',
      icon: 'info',
      allowOutsideClick: false,
      didOpen: () => {
        Swal.showLoading();
      }
    });

    try {
      const IdUsuario = this.usuarioSeleccionado.id;
      const usuario = {
        Transaccion: 'cambiar_clave',
        IdUsuario: this.usuarioSeleccionado.id,
        Password: this.usuarioSeleccionado.cedula
      };

      await firstValueFrom(this.loginService.cambiarClave(IdUsuario, usuario));

      Swal.fire({
        icon: 'success',
        title: '¡Clave Cambiada!',
        text: 'La clave ha sido actualizada correctamente.',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: 'rgba(38,218, 77,1)',
        allowOutsideClick: false,
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });
    } catch (error) {
      const errorMessage = JSON.stringify(error, null, 2);
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Error al actualizar clave' + errorMessage,
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#d33',
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      });
    }
  }

  obtenerRol() {
    this.rolService.getRol('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.roles = data;
        }
        else {
          console.error('Error: La respuesta no es un arreglo', data);
        }
      },
      (error: any) => {
        console.error('Error en la solicitud al servidor. Consulte al administrador:', error);
      }
    );
  }

  agregarUsuario() {
    this.modoEdicion = false;
    this.usuarioSeleccionado = null;
    this.isModalVisible = true;
  }


  cerrarModal() {
    this.isModalVisible = false;
    this.usuarioForm.reset();
  }

  guardarRol() {
    this.nombreRol = this.rolForm.value.Nombre;
    this.rolForm.value.Transaccion = "agregar_rol";

    if (this.rolForm.valid) {
      this.rolService.agregarRol(this.rolForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          if (data.length === 0) {
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'No se pudo registrar el rol',
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
            });
          } else {
            Swal.fire({
              title: '¡Rol Registrado!',
              text: 'Rol registrado correctamente',
              icon: 'success',
              timer: 1000,
              showConfirmButton: false
            });
            this.obtenerRol();
            this.cerrarModalRol();
          }
        },
        (error) => {
          const errorMessage = JSON.stringify(error, null, 2);
          Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Error al registrar rol ' + errorMessage,
            confirmButtonText: 'Aceptar',
            confirmButtonColor: '#d33',
            showClass: { popup: "animate_animated animatefadeIn animate_faster" },
          });
        }
      );
    }

  }

  eliminarUsuario(usuario: any) {
    this.usuarioSeleccionado = usuario;
    const nombreUsuario = this.usuarioSeleccionado.nombres + ' ' + this.usuarioSeleccionado.apellidos;
    Swal.fire({
      title: 'Confirmar eliminación',
      html: `
          <div class="text-start">
              <p>¿Está seguro de eliminar al usuario?</p>
          </div>
          <div class="text-center">
              <strong><p class="text-muted small">${nombreUsuario}</p></strong>
          </div>
      `,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonText: 'Sí, eliminar',
      confirmButtonColor: '#d33',
      cancelButtonColor: '#6c757d',
      cancelButtonText: 'No, cancelar',
      allowOutsideClick: false,
    }).then((result) => {
      if (result.isConfirmed) {
        this.eliminarUsuarioConfirmado();
      }
    });
  }

  async eliminarUsuarioConfirmado(): Promise<void> {
    this.usuarioSeleccionado.Transaccion = 'eliminar_usuario';
    this.usuarioSeleccionado.IdUsuario = this.usuarioSeleccionado.id;
    this.loginService.eliminarUsuario(this.usuarioSeleccionado.IdUsuario, this.usuarioSeleccionado).subscribe(
      (data: any) => {
        this.respuesta = data;
        if (data.length === 0) {
          console.error('Error: No se pudo eliminar el usuario');
          Swal.fire({
            title: 'Error',
            icon: 'error',
            text: 'Error al eliminar usuario',
            confirmButtonText: 'Aceptar',
            confirmButtonColor: '#d33',
            showClass: { popup: "animate_animated animatefadeIn animate_faster" },
          });
        } else {
          this.obtenerUsuarios();
          Swal.fire({
            title: 'Usuario eliminado',
            text: 'El usuario ha sido eliminado correctamente.',
            icon: 'success',
            confirmButtonText: 'Aceptar',
            confirmButtonColor: 'rgba(38,218, 77,1)',
            allowOutsideClick: false,
            showClass: { popup: "animate_animated animatefadeIn animate_faster" },
          });
        }
      }
    );
  }

  cerrarModalDelete() {
    this.isConfirmDeleteModalVisible = false;
  }

  abrirModalRol() {
    this.isModalRolVisible = true;
  }

  cerrarModalRol() {
    this.isModalRolVisible = false;
    this.rolForm.reset();
  }

}