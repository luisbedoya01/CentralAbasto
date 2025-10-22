import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormControl, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { LoginService } from '../servicios/login.service';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { AuthService } from '../servicios/auth.service';
import { CommonModule } from '@angular/common';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [MatFormFieldModule, MatIconModule, MatInputModule, ReactiveFormsModule, MatSnackBarModule, CommonModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})

export class LoginComponent {
  hide = true;
  cedula: any;
  password: any;
  respuesta: any = null;

  constructor(private router: Router, private loginService: LoginService,
    private authService: AuthService,
    private snackBar: MatSnackBar) { }

  usuarioLogin = new FormGroup({
    Cedula: new FormControl('', Validators.required),
    Password: new FormControl('', Validators.required),
    Transaccion: new FormControl()
  })

  // onLogin() {
  //   this.cedula = this.usuarioLogin.value.Cedula;
  //   this.password = this.usuarioLogin.value.Password;
  //   this.usuarioLogin.value.Transaccion = "login";

  //   if (this.cedula && this.password) {
  //     this.loginService.login(this.usuarioLogin.value).subscribe(
  //       (data: any) => {
  //         this.respuesta = data;

  //         // Se valida que si el API contesta vacio, significa que no encontró el usuario y clave
  //         if (data.length == 0) {
  //           Swal.fire({
  //             icon: 'error',
  //             title: 'Cédula o clave incorrectos',
  //             text: 'La cédula o clave son incorrectos. Inténtalo de nuevo.',
  //             confirmButtonText: 'Aceptar',
  //             confirmButtonColor: 'rgba(220, 53, 69, 1)',
  //             showClass: { popup: "animate_animated animatefadeIn animate_faster" }
  //           });
  //         } else {
  //           this.authService.setUsuario(data[0]);
  //           this.router.navigate(['/principal']);
  //         }

  //       },
  //       (error) => {
  //         const errorMessage = JSON.stringify(error, null, 2);
  //         Swal.fire({
  //           icon: 'error',
  //           title: 'Error de conexión',
  //           text: 'Ocurrió un error al conectar con el servidor. Por favor, intenta nuevamente más tarde.' + errorMessage,
  //           confirmButtonText: 'Aceptar',
  //           confirmButtonColor: 'rgba(220, 53, 69, 1)',
  //           showClass: { popup: "animate_animated animatefadeIn animate_faster" }
  //         });
  //       }
  //     )
  //   }
  //   else {
  //     Swal.fire({
  //       icon: 'warning',
  //       title: 'Campos incompletos',
  //       text: 'Por favor ingresa la cédula y contraseña.',
  //       confirmButtonText: 'Aceptar',
  //       confirmButtonColor: 'rgba(255, 193, 7, 1)',
  //       showClass: { popup: "animate_animated animatefadeIn animate_faster" }
  //     });
  //   }
  // }

  onLogin() {
    this.cedula = this.usuarioLogin.value.Cedula;
    this.password = this.usuarioLogin.value.Password;

    if (this.cedula && this.password) {
      this.loginService.login(this.usuarioLogin.value).subscribe(
        (data: any) => {
          this.authService.setUsuario(data);
          this.router.navigate(['/principal']);
        },
        (error) => {
          if (error.status === 401) {
            Swal.fire({
              icon: 'error',
              title: 'Cédula o clave incorrectos',
              text: 'La cédula o clave son incorrectos. Inténtalo de nuevo.',
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
            });
          } else {
            // Para cualquier otro error (de red, del servidor, etc.)
            Swal.fire({
              icon: 'error',
              title: 'Error de conexión',
              text: 'Ocurrió un error al conectar con el servidor. Por favor, intenta nuevamente más tarde.',
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
            });
          }
        }
      );
    } else {
      Swal.fire({
        icon: 'warning',
        title: 'Campos incompletos',
        text: 'Por favor ingresa la cédula y contraseña.',
        confirmButtonText: 'Aceptar',
        confirmButtonColor: '#ffc107',
      });
    }
  }

  onRegister() {
    this.router.navigate(['/Registro']);
  }
}
