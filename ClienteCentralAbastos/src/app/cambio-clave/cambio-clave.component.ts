import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormGroup, FormControl, Validators, AbstractControl } from '@angular/forms';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import Swal from 'sweetalert2';
import { AuthService } from '../servicios/auth.service';
import { firstValueFrom } from 'rxjs';
import { LoginService } from '../servicios/login.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-cambio-clave',
  imports: [CommonModule, ReactiveFormsModule, MatFormFieldModule, MatInputModule,
    MatButtonModule, MatIconModule, MatCardModule],
  templateUrl: './cambio-clave.component.html',
  styleUrl: './cambio-clave.component.css'
})
export class CambioClaveComponent implements OnInit {
  cambioClaveForm: FormGroup;
  hideNueva = true;
  usuarioSeleccionado: any = null;
  constructor(private authService: AuthService, private loginService: LoginService, private route: Router) {
    this.cambioClaveForm = new FormGroup({
      Password: new FormControl('', [Validators.required, Validators.minLength(8)]),
      Transaccion: new FormControl(),
    });
  }

  ngOnInit(): void {
    const usuario = this.authService.getUsuario();
    this.usuarioSeleccionado = usuario;
    console.log('Usuario en cambio clave: ', usuario);
    if (usuario.primerLogin) {
      Swal.fire({
        title: 'Cambio de clave requerido',
        text: 'Es necesario que cambies tu clave en este primer inicio de sesión.',
        icon: 'info',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#3085d6',
        allowOutsideClick: false
      });
    }
  }

  cambiarClave() {
    Swal.fire({
      title: 'Confirmar cambio',
      html: `
            <div class="text-start">
                <p>¿Está seguro de cambiar su clave?</p>
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
        this.procesaCambiarClave();
      }
    });
  }

  async procesaCambiarClave(): Promise<void> {
    try {
      const IdUsuario = this.usuarioSeleccionado.id;
      const usuario = {
        Transaccion: 'cambiar_clave',
        IdUsuario: this.usuarioSeleccionado.id,
        Password: this.cambioClaveForm.value.Password
      };
      console.log('Datos a enviar', usuario);
      await firstValueFrom(this.loginService.cambiarClave(IdUsuario, usuario));
      Swal.fire({
        icon: 'success',
        title: '¡Clave Cambiada!',
        text: 'La clave ha sido actualizada correctamente.',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: 'rgba(38,218, 77,1)',
        allowOutsideClick: false,
        showClass: { popup: "animate_animated animatefadeIn animate_faster" },
      }).then(() => {
        this.route.navigate(['/principal'])
        this.limpiarFormulario();
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

  limpiarFormulario() {
    this.cambioClaveForm.reset();
  }
}
