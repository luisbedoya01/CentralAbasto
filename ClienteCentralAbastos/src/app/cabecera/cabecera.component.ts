import { Component, inject, ViewChild, AfterViewInit } from '@angular/core';
import { AsyncPipe, CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Observable } from 'rxjs';
import { map, shareReplay, delay } from 'rxjs/operators';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { AuthService } from '../servicios/auth.service';

@Component({
  selector: 'app-cabecera',
  standalone: true,
  imports: [
    CommonModule, RouterModule, AsyncPipe, MatToolbarModule,
    MatButtonModule, MatSidenavModule, MatListModule, MatIconModule
  ],
  templateUrl: './cabecera.component.html',
  styleUrl: './cabecera.component.css'
})
export class CabeceraComponent implements AfterViewInit {
  @ViewChild('sidenav') sidenav!: MatSidenav;

  private breakpointObserver = inject(BreakpointObserver);

  isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
    .pipe(
      map(result => result.matches),
      shareReplay()
    );

  logeado = false;
  subMenuAbierto = false;
  subMenuReportesAbierto = false;
  
  constructor(private router: Router, private authService: AuthService) { }

  ngOnInit() {
    this.authService.logeado$.subscribe(data => {
      this.logeado = data;
    });
  }
  
  ngAfterViewInit() {
    this.isHandset$.pipe(delay(0)).subscribe(isHandset => {
      if (!isHandset) {
        this.log('ACCIÓN INICIAL: Es escritorio, abriendo menú.');
        this.sidenav.open();
      } else {
        this.log('ACCIÓN INICIAL: Es móvil, cerrando menú.');
        this.sidenav.close();
      }
    });
  }

  log(mensaje: string): void {
    console.log(`[${new Date().toLocaleTimeString()}] ${mensaje}`);
  }

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