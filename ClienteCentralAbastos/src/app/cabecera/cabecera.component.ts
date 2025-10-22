import { Component, inject, ViewChild, AfterViewInit } from '@angular/core';
import { AsyncPipe, CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { Observable } from 'rxjs';
import { map, shareReplay, delay } from 'rxjs/operators';

// Importaciones de Angular Material
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
import { MatListModule } from '@angular/material/list';
import { MatIconModule } from '@angular/material/icon';

// Herramienta para detectar el tamaño de la pantalla
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';

// Tus servicios
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

  // ✅ MÉTODO DE DEPURACIÓN
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

// import { Component, inject, ViewChild, AfterViewInit } from '@angular/core';
// import { AsyncPipe, CommonModule } from '@angular/common';
// import { Router, RouterModule } from '@angular/router';
// import { Observable } from 'rxjs';
// import { map, shareReplay, delay } from 'rxjs/operators';

// // Importaciones de Angular Material
// import { MatToolbarModule } from '@angular/material/toolbar';
// import { MatButtonModule } from '@angular/material/button';
// import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
// import { MatListModule } from '@angular/material/list';
// import { MatIconModule } from '@angular/material/icon';

// // Herramienta para detectar el tamaño de la pantalla
// import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';

// // Tus servicios
// import { AuthService } from '../servicios/auth.service';

// @Component({
//   selector: 'app-cabecera',
//   standalone: true,
//   imports: [
//     CommonModule,
//     RouterModule,
//     AsyncPipe,
//     MatToolbarModule,
//     MatButtonModule,
//     MatSidenavModule,
//     MatListModule,
//     MatIconModule
//   ],
//   templateUrl: './cabecera.component.html',
//   styleUrl: './cabecera.component.css'
// })
// export class CabeceraComponent implements AfterViewInit {
//   @ViewChild('sidenav') sidenav!: MatSidenav; // Obtenemos una referencia al menú del HTML

//   private breakpointObserver = inject(BreakpointObserver);

//   // Observable que nos dice si estamos en una pantalla tipo "handset" (móvil)
//   isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
//     .pipe(
//       map(result => result.matches),
//       shareReplay()
//     );

//   // Tus propiedades existentes
//   subMenuAbierto = false;
//   subMenuReportesAbierto = false;
//   logeado = false;
  
//   constructor(private router: Router, private authService: AuthService) { }

//   ngOnInit() {
//     this.authService.logeado$.subscribe(data => {
//       this.logeado = data;
//     });
//   }
  
//   // Se ejecuta después de que la vista se ha inicializado
//   ngAfterViewInit() {
//     this.isHandset$.pipe(delay(0)).subscribe(isHandset => {
//       if (!isHandset) {
//         this.sidenav.open(); // Si es escritorio, abre el menú al inicio
//       } else {
//         this.sidenav.close(); // Si es móvil, ciérralo al inicio
//       }
//     });
//   }

//   toggleSubMenu() {
//     this.subMenuAbierto = !this.subMenuAbierto;
//   }
  
//   toggleSubMenuRep() {
//     this.subMenuReportesAbierto = !this.subMenuReportesAbierto;
//   }

//   cerrarsesion() {
//     this.authService.logout();
//     this.router.navigate(['/']); 
//   }
// }

// import { Component, Input, ViewChild } from '@angular/core';
// import { CommonModule } from '@angular/common';
// import { MatToolbarModule } from '@angular/material/toolbar';
// import { MatIconModule } from '@angular/material/icon';
// import { MatButtonModule } from '@angular/material/button';
// import { MatMenuModule } from '@angular/material/menu';
// import { MatExpansionModule } from '@angular/material/expansion';
// import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
// import { MatListModule } from '@angular/material/list';
// import { AuthService } from '../servicios/auth.service';
// import { Router } from '@angular/router';
// import { RouterOutlet } from '@angular/router';
// import { RouterLink } from '@angular/router';
// @Component({
//   selector: 'app-cabecera',
//   imports: [CommonModule, MatToolbarModule,
//     MatIconModule, MatButtonModule, MatMenuModule, MatExpansionModule,
//     MatSidenav, MatSidenavModule, MatListModule, RouterOutlet, RouterLink],
//   standalone: true,
//   templateUrl: './cabecera.component.html',
//   styleUrl: './cabecera.component.css'
// })
// export class CabeceraComponent {
//   panelOpenState = false;
//   subMenuAbierto = false;
//   subMenuReportesAbierto = false;
//   logeado = false;
//   constructor(private router: Router, private authService: AuthService) { }

//   ngOnInit() {
//     // Con el subscribe escuchamos si la variable sufrió algún cambio
//     this.authService.logeado$.subscribe(data => {
//       this.logeado = data;
//     });

//     // if (!this.authService.isAuthenticated()) {
//     //   this.router.navigate(['/']);
//     // }
//   }

//   toggleSubMenu() {
//     this.subMenuAbierto = !this.subMenuAbierto;
//   }
  
//   toggleSubMenuRep() {
//     this.subMenuReportesAbierto = !this.subMenuReportesAbierto;
//   }

//   opennuevoUsuario() {
//   }

//   closeLogin() {
//   }

//   openLogin() {

//   }

//   cerrarsesion() {
//     // Actualizo la variable global del servicio
//     this.authService.logout();
//   }
// }
