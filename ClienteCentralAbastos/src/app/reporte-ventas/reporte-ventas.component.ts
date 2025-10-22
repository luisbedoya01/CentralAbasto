import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgxChartsModule } from '@swimlane/ngx-charts';
import { ReportesService } from '../servicios/reportes.service';
import { FormGroup, FormControl, Validators, ReactiveFormsModule } from '@angular/forms';
import { Recoverable } from 'repl';
//import { MatFormField } from '@angular/material/form-field';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-reporte-ventas',
  imports: [CommonModule, NgxChartsModule, ReactiveFormsModule, MatFormFieldModule,
    MatInputModule,
    MatDatepickerModule,
    MatButtonModule],
  templateUrl: './reporte-ventas.component.html',
  styleUrl: './reporte-ventas.component.css'
})
export class ReporteVentasComponent {

  reporteForm = new FormGroup({
    fechaInicio: new FormControl('', Validators.required),
    fechaFin: new FormControl('', Validators.required)
  });

  chartData: any[] = [];
  estaCargando = false;

  // Opciones del gráfico
  xAxisLabel = 'Fecha';
  yAxisLabel = 'Total Vendido';

  public ventasFlag = false;

  constructor(private reportesService: ReportesService) { }

  generarReporte() {
    if (this.reporteForm.invalid) { return; }
    this.estaCargando = true;
    this.ventasFlag = true;
    this.chartData = [];

    const fechaInicio = this.formatearFecha(new Date(this.reporteForm.value.fechaInicio!));
    const fechaFin = this.formatearFecha(new Date(this.reporteForm.value.fechaFin!));

    this.reportesService.getReporteVentas(fechaInicio, fechaFin).subscribe({
      next: (data) => {
        //console.log('Respuesta del API', data);
        if (data && data.length > 0) {
          this.chartData = data.map(item => ({
            name: new Date(item.Fecha.replace(/-/g, '/')),
            value: item.TotalVendido || 0,
            extra: {
              ventasRealizadas: item.NumeroFacturas
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
