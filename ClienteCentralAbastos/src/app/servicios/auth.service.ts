import { Injectable, Inject, PLATFORM_ID, NgZone } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { BehaviorSubject } from 'rxjs';
import { Router } from '@angular/router';
import Swal from 'sweetalert2';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  // Inicializar con datos del localStorage si existen
  //private usuarioObject = new BehaviorSubject<any>(this.getUsuarioFromStorage());
  private usuarioObject = new BehaviorSubject<any>(null);
  public usuario$ = this.usuarioObject.asObservable();

  // BehaviorSubject para el estado de login
  private logueadoSubject = new BehaviorSubject<boolean>(this.isLoggedIn());
  public logeado$ = this.logueadoSubject.asObservable();

  // Propiedades para el temporizador de inactividad
  private inactivityTimer: any;
  private readonly INACTIVITY_TIMEOUT_MS = 15 * 60 * 1000; // 1 minuto

  constructor(private router: Router, @Inject(PLATFORM_ID) private platformId: Object, private ngZone: NgZone) {
    this.cargarDatos();
    this.setUpInactivityMonitor();
  }

  private cargarDatos(): void {
    if (isPlatformBrowser(this.platformId)) {
      const usuario = this.getUsuarioFromStorage();
      if (usuario) {
        this.usuarioObject.next(usuario);
        this.logueadoSubject.next(true);
      }
    }
  }

  // Obtener usuario del localStorage
  private getUsuarioFromStorage(): any {
    if (isPlatformBrowser(this.platformId)) {
      //const usuarioString = localStorage.getItem('authData');
      const usuarioString = sessionStorage.getItem('authData');

      // console.log('AuthService: Leyendo de localStorage:', usuarioString);

      // Verificar que el string exista y no sea inválido
      if (usuarioString && usuarioString !== 'undefined' && usuarioString !== 'null') {
        try {
          const usuarioObjeto = JSON.parse(usuarioString);
          //return JSON.parse(usuarioString);
          return usuarioObjeto;
        } catch (e) {
          console.error('Error al parsear authData desde localStorage', e);
          //localStorage.removeItem('authData'); // Limpiar dato inválido
          sessionStorage.removeItem('authData'); // Limpiar dato inválido
          return null;
        }
      }
    }
    return null;
  }

  // Verificar si está logueado
  private isLoggedIn(): boolean {
    if (isPlatformBrowser(this.platformId)) {
      // Comprueba que authData existe y no es vacio
      //const authData = localStorage.getItem('authData');
      const authData = sessionStorage.getItem('authData');
      return !!authData && authData !== 'undefined' && authData !== 'null';
    }
    return false;
  }

  isAuthenticated(): boolean {
    return this.logueadoSubject.value;
  }

  // Método para establecer usuario (usado en login)
  setUsuario(usuario: any) {
    // Actualizar el BehaviorSubject
    this.usuarioObject.next(usuario);
    this.logueadoSubject.next(true);

    // Guardar en localStorage
    if (isPlatformBrowser(this.platformId)) {
      //localStorage.setItem('authData', JSON.stringify(usuario));
      sessionStorage.setItem('authData', JSON.stringify(usuario));
    }
  }

  // Configura el monitoreo de actividad
  private setUpInactivityMonitor(): void {
    if (isPlatformBrowser(this.platformId)) {
      this.ngZone.runOutsideAngular(() => {
        this.resetInactivityTimer(); // Inicia el temporizador al cargar
        // Escuchar eventos de actividad del usuario
        window.addEventListener('mousemove', this.resetInactivityTimer.bind(this));
        window.addEventListener('keypress', this.resetInactivityTimer.bind(this));
        window.addEventListener('click', this.resetInactivityTimer.bind(this));
        window.addEventListener('scroll', this.resetInactivityTimer.bind(this));
      });
    }
  }

  // Reinicia el temporizador de inactividad
  private resetInactivityTimer(): void {
    if (isPlatformBrowser(this.platformId)) {
      clearTimeout(this.inactivityTimer);
      // Solo establece el temporizador si el usuario está autenticado
      if (this.isAuthenticated()) {
        this.inactivityTimer = setTimeout(() => {
          this.ngZone.run(() => {
            // Doble verificación antes de cerrar sesión
            if (this.isAuthenticated()) {
              //this.logout();
              Swal.fire({
                title: 'Sesión expirada',
                text: 'Tu sesión ha sido cerrada por inactividad.',
                icon: 'warning',
                confirmButtonText: 'Aceptar',
                allowOutsideClick: false,
              }).then(() => {
                this.logout();
              });
            }
          });
        }, this.INACTIVITY_TIMEOUT_MS);
      }
    }
  }

  // Limpia/detiene el temporizador de inactividad
  private clearInactivityTimer(): void {
    if (isPlatformBrowser(this.platformId)) {
      clearTimeout(this.inactivityTimer);
    }
  }

  // Obtener usuario actual
  getUsuario() {
    return this.usuarioObject.value;
  }

  // Cerrar sesión
  logout() {
    // Limpiar localStorage
    if (isPlatformBrowser(this.platformId)) {
      //localStorage.removeItem('authData');
      sessionStorage.removeItem('authData');
    }

    // Actualizar BehaviorSubjects
    this.usuarioObject.next(null);
    this.logueadoSubject.next(false);

    // Detiene el temporizador de inactividad al cerrar sesión manualmente
    this.clearInactivityTimer();

    // Redirigir al login
    this.router.navigate(['/']);
  }
}