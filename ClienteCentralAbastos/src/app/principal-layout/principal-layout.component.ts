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

// import { Component, inject, ViewChild, AfterViewInit } from '@angular/core';
// import { AsyncPipe, CommonModule } from '@angular/common';
// import { Router, RouterModule } from '@angular/router';
// import { Observable } from 'rxjs';
// import { map, shareReplay, delay } from 'rxjs/operators';
// import { MatToolbarModule } from '@angular/material/toolbar';
// import { MatButtonModule } from '@angular/material/button';
// import { MatSidenav, MatSidenavModule } from '@angular/material/sidenav';
// import { MatListModule } from '@angular/material/list';
// import { MatIconModule } from '@angular/material/icon';
// import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
// import { AuthService } from '../servicios/auth.service';

// @Component({
//   selector: 'app-principal-layout',
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
//   templateUrl: './principal-layout.component.html',
//   styleUrls: ['./principal-layout.component.css']
// })
// export class PrincipalLayoutComponent implements AfterViewInit {
//   @ViewChild('sidenav') sidenav!: MatSidenav;

//   private breakpointObserver = inject(BreakpointObserver);

//   isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
//     .pipe(
//       map(result => result.matches),
//       shareReplay()
//     );

//   subMenuAbierto = false;
//   subMenuReportesAbierto = false;
//   logeado = false;

//   constructor(private router: Router, private authService: AuthService) { }

//   ngOnInit() {
//     this.authService.logeado$.subscribe(data => {
//       this.logeado = data;
//     });
//   }

//   ngAfterViewInit() {
//     this.isHandset$.pipe(delay(0)).subscribe(isHandset => {
//       if (!isHandset) {
//         //this.sidenav.open();
//       } else {
//         this.sidenav.close();
//       }
//     });
//   }

//   // Métodos para los sub-menús
//   toggleSubMenu() {
//     this.subMenuAbierto = !this.subMenuAbierto;
//   }

//   toggleSubMenuRep() {
//     this.subMenuReportesAbierto = !this.subMenuReportesAbierto;
//   }

//   // Método para cerrar sesión
//   cerrarsesion() {
//     this.authService.logout();
//     this.router.navigate(['/']);
//   }
// }

// import { Component } from '@angular/core';
// import { CommonModule } from '@angular/common';
// import { Router, RouterModule } from '@angular/router';

// // Importaciones de Angular Material
// import { MatToolbarModule } from '@angular/material/toolbar';
// import { MatButtonModule } from '@angular/material/button';
// import { MatSidenavModule } from '@angular/material/sidenav';
// import { MatListModule } from '@angular/material/list';
// import { MatIconModule } from '@angular/material/icon';

// import { AuthService } from '../servicios/auth.service';

// @Component({
//   selector: 'app-principal-layout',
//   standalone: true,
//   imports: [
//     CommonModule, RouterModule, MatToolbarModule, MatButtonModule,
//     MatSidenavModule, MatListModule, MatIconModule
//   ],
//   templateUrl: './principal-layout.component.html',
//   styleUrls: ['./principal-layout.component.css']
// })
// export class PrincipalLayoutComponent {
//   subMenuReportesAbierto = false;

//   constructor(private router: Router, private authService: AuthService) { }

//   toggleSubMenuRep() {
//     this.subMenuReportesAbierto = !this.subMenuReportesAbierto;
//   }

//   cerrarsesion() {
//     this.authService.logout();
//     this.router.navigate(['/']);
//   }
// }

// import { Component } from '@angular/core';

// @Component({
//   selector: 'app-principal-layout',
//   imports: [],
//   templateUrl: './principal-layout.component.html',
//   styleUrl: './principal-layout.component.css'
// })
// export class PrincipalLayoutComponent {

// }
