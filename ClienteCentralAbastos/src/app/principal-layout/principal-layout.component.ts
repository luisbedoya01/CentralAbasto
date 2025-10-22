import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';

// Importaciones de Angular Material
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';

import { AuthService } from '../servicios/auth.service';

@Component({
  selector: 'app-principal-layout',
  standalone: true,
  imports: [
    CommonModule, RouterModule, MatToolbarModule, MatButtonModule,
    MatSidenavModule, MatListModule, MatIconModule
  ],
  templateUrl: './principal-layout.component.html',
  styleUrls: ['./principal-layout.component.css']
})
export class PrincipalLayoutComponent {
  subMenuAbierto = false;
  subMenuReportesAbierto = false;

  constructor(private router: Router, private authService: AuthService) { }

  toggleSubMenu() {
    this.subMenuAbierto = !this.subMenuAbierto;
  }

  toggleSubMenuRep() {
    this.subMenuReportesAbierto = !this.subMenuReportesAbierto;
  }

  cerrarsesion() {
    this.authService.logout();
    this.router.navigate(['/']);
  }
}