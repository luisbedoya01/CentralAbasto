import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatIconModule } from '@angular/material/icon';
import { LoginService } from '../../servicios/login.service';
import { FormControl, FormGroup, Validators, ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RolServiceService } from '../../servicios/rol-service.service';

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

    if (this.usuarioForm.valid) {
      if (this.modoEdicion) {
        this.loginService.editarUsuario(this.usuarioSeleccionado.id, this.usuarioForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            //console.log(data);
            if (data.length === 0) {
              console.error('Error: No se pudo editar el usuario');
            } else {
              console.log('Usuario editado correctamente:', data);
              this.obtenerUsuarios();
              this.cerrarModal();
            }
            console.log('Respuesta de la API:', data);
          },
          (error: any) => {
            //console.log(this.usuarioSeleccionado);
            console.error('Error al editar el usuario:', error);
          }
        );
        console.log('Editando usuario:', this.usuarioForm.value);
      } else {
        console.log('Guardando nuevo usuario:', this.usuarioForm.value);
        this.loginService.registro(this.usuarioForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            //console.log(data);
            if (data.length === 0) {
              console.error('Error: No se pudo registrar el usuario');
            } else {
              console.log('Usuario registrado correctamente:', data);
              this.obtenerUsuarios();
              this.cerrarModal();
            }
            console.log('Respuesta de la API:', data);
          },
          (error: any) => {
            console.error('Error al registrar el usuario:', error);
          }
        );
      }
    }
  }

  editarUsuario(usuario: any) {
    this.modoEdicion = true;
    this.usuarioSeleccionado = usuario;
    //console.log('Usuario seleccionado para editar:', this.usuarioSeleccionado);
    this.isModalVisible = true;

    this.usuarioForm.patchValue({
      IdUsuario: usuario.id,
      Cedula: usuario.cedula,
      Nombres: usuario.nombres,
      Apellidos: usuario.apellidos,
      IdRol: usuario.idrol,
    });

    //console.log('Id del usuario seleccionado para editar:', this.usuarioSeleccionado.id);
  }

  obtenerRol() {
    this.rolService.getRol('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.roles = data;
          //console.log('Roles obtenidos:', this.roles);
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

  eliminarUsuario(usuario: any) {
    this.usuarioSeleccionado = usuario;
    this.isConfirmDeleteModalVisible = true;
  }

  eliminarUsuarioConfirmado() {
    this.usuarioSeleccionado.Transaccion = 'eliminar_usuario';
    this.usuarioSeleccionado.IdUsuario = this.usuarioSeleccionado.id;
    this.loginService.eliminarUsuario(this.usuarioSeleccionado.IdUsuario, this.usuarioSeleccionado).subscribe(
      (data: any) => {
        this.respuesta = data;
        if (data.length === 0) {
          console.error('Error: No se pudo eliminar el usuario');
        } else {
          console.log('Usuario eliminado correctamente:', data);
          this.obtenerUsuarios();
          this.cerrarModalDelete();
        }
        console.log('Respuesta de la API:', data);
      }
    );
  }

  cerrarModalDelete() {
    this.isConfirmDeleteModalVisible = false;
  }
}