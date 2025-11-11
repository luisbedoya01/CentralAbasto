import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MatButtonModule } from '@angular/material/button';
import { ReportesService } from '../servicios/reportes.service';

@Component({
  selector: 'app-reporte-productos-bajo-stock',
  standalone: true,
  imports: [CommonModule, MatButtonModule],
  templateUrl: './reporte-productos-bajo-stock.component.html',
  styleUrl: './reporte-productos-bajo-stock.component.css'
})
export class ReporteProductosBajoStockComponent {
  reportData: any[] = [];
  estaCargando = false;
  ventasFlag = false;

  constructor(private reportesService: ReportesService) { }

  generarReporte() {
    this.estaCargando = true;
    this.ventasFlag = true;
    this.reportData = [];

    this.reportesService.getProductosBajoStock().subscribe({
      next: (data) => {
        this.reportData = data;;
        this.estaCargando = false;
      },
      error: (error) => {
        console.error('Error al obtener el reporte de productos bajo stock', error);
        this.estaCargando = false;
      }
    });

  }

}
