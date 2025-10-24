import { Routes } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { InicioComponent } from './principal/inicio/inicio.component';
import { RegistroComponent } from './login/registro/registro.component';
import { GestionInventarioComponent } from './inventario/gestion-inventario/gestion-inventario.component';
import { PedidosComponent } from './pedidos/pedidos.component';
import { CobrosComponent } from './cobros/cobros.component';
import { MedidasConversionComponent } from './medidas-conversion/medidas-conversion.component';
import { GestionIvaComponent } from './gestion-iva/gestion-iva.component';
import { AuthGuard } from './auth.guard';
import { ReporteVentasComponent } from './reporte-ventas/reporte-ventas.component';
import { ReporteVentasProductoComponent } from './reporte-ventas-producto/reporte-ventas-producto.component';
import { ReporteProductosBajoStockComponent } from './reporte-productos-bajo-stock/reporte-productos-bajo-stock.component';
import { PrincipalLayoutComponent } from './principal-layout/principal-layout.component';
import { LoginGuard } from './login.guard';
import { CambioClaveComponent } from './cambio-clave/cambio-clave.component';

export const routes: Routes = [
    // Rutas públicas (sin protección)
    { path: '', component: LoginComponent, canActivate: [LoginGuard] },
    { path: 'registro', component: RegistroComponent, canActivate: [LoginGuard] },

    {
        path: '',
        component: PrincipalLayoutComponent,
        canActivate: [AuthGuard],
        children: [
            { path: 'principal', component: InicioComponent},
            { path: 'inventario', component: GestionInventarioComponent},
            { path: 'gestionUsuarios', component: RegistroComponent},
            { path: 'pedidos', component: PedidosComponent},
            { path: 'cobros', component: CobrosComponent},
            { path: 'configuracionMedidas', component: MedidasConversionComponent},
            { path: 'configuracionIva', component: GestionIvaComponent},
            { path: 'reporteVentas', component: ReporteVentasComponent},
            { path: 'reporteProductos', component: ReporteVentasProductoComponent},
            { path: 'reporteProductosBajoStock', component: ReporteProductosBajoStockComponent},
            { path: 'cambioClave', component: CambioClaveComponent},
        ]
    },

    { path: '**', redirectTo: '' }
];
