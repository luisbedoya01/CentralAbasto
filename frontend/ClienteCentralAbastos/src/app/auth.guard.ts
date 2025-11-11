import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { AuthService } from './servicios/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {
  constructor(
    private authService: AuthService, 
    private router: Router
  ) {}

  canActivate(): boolean {
    
    if (this.authService.isAuthenticated()) {
      return true;
    }
    
    console.log('Usuario NO autenticado - redirigir al login');
    this.router.navigate(['/']); 
    return false;
  }
}