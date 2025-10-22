import { Component } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { CommonModule } from '@angular/common';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';
import { AuthService } from '../../servicios/auth.service';

@Component({
  selector: 'app-inicio',
  standalone: true,
  imports: [MatButtonModule, MatCardModule, CommonModule, MatSidenavModule, MatToolbarModule, MatIconModule, MatDividerModule],
  templateUrl: './inicio.component.html',
  styleUrl: './inicio.component.css'
})
export class InicioComponent {
  //usuario: any;
  nombreUsuario: string = '';

  constructor(private authService: AuthService) { }

  ngOnInit(): void {
    this.authService.usuario$.subscribe(usuario => {
      if (usuario && usuario.nombres && usuario.apellidos) {
        this.nombreUsuario = `${usuario.nombres} ${usuario.apellidos}`;
      } else {
        this.nombreUsuario = '';
      }
    });
  }
}
