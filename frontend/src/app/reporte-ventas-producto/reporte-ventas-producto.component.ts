import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormGroup, FormControl, Validators } from '@angular/forms';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatButtonModule } from '@angular/material/button';
import { NgxChartsModule } from '@swimlane/ngx-charts';
import { ReportesService } from '../servicios/reportes.service';

@Component({
  selector: 'app-reporte-ventas-producto',
  standalone: true,
  imports: [
    CommonModule, 
    ReactiveFormsModule, 
    MatFormFieldModule, 
    MatInputModule,
    MatDatepickerModule, 
    MatButtonModule, 
    NgxChartsModule
  ],
  templateUrl: './reporte-ventas-producto.component.html',
  styleUrl: './reporte-ventas-producto.component.css'
})
export class ReporteVentasProductoComponent {
  reporteForm = new FormGroup({
    fechaInicio: new FormControl('', Validators.required),
    fechaFin: new FormControl('', Validators.required)
  });

  chartData: any[] = [];
  estaCargando = false;
  ventasFlag = false;

  xAxisLabel = 'Ingresos Generados';
  yAxisLabel = 'Producto';

  constructor(private reportesService: ReportesService) { }

  generarReporte() {
    if (this.reporteForm.invalid) { return; }

    this.estaCargando = true;
    this.ventasFlag = true;
    this.chartData = [];

    const fechaInicio = this.formatearFecha(new Date(this.reporteForm.value.fechaInicio!));
    const fechaFin = this.formatearFecha(new Date(this.reporteForm.value.fechaFin!));

    this.reportesService.getTopProductos(fechaInicio, fechaFin).subscribe({
      next: (data) => {
        if (data && data.length > 0) {
          this.chartData = data.map(item => ({
            name: item.NombreProducto,
            value: item.IngresosGenerados || 0,
            extra: {
              unidades: item.UnidadesVendidas
            }
          }));
        }
        this.estaCargando = false;
      },
      error: (err) => {
        console.error('Error al obtener el reporte:', err);
        this.estaCargando = false;
      }
    });
  }

  private formatearFecha(fecha: Date): string {
    return fecha.toISOString().split('T')[0];
  }
}