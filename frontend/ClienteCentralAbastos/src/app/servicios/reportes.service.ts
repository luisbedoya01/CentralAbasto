import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ReportesService {

  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  getReporteVentas(fechaInicio: string, fechaFin: string): Observable<any[]> {
    const params = new HttpParams()
      .set('Transaccion', 'ventas_por_fecha')
      .set('FechaInicio', fechaInicio)
      .set('FechaFin', fechaFin);
    return this.http.get<any[]>(`${this.baseUrl}reporteget/`, { params });
  }

  getTopProductos(fechaInicio: string, fechaFin: string): Observable<any[]> {
    const params = new HttpParams()
      .set('Transaccion', 'top_productos_vendidos')
      .set('FechaInicio', fechaInicio)
      .set('FechaFin', fechaFin);
    return this.http.get<any[]>(`${this.baseUrl}reporteget/`, { params });
  }

  getProductosBajoStock(): Observable<any[]> {
    const params = new HttpParams()
      .set('Transaccion', 'productos_bajo_stock');
    return this.http.get<any[]>(`${this.baseUrl}reporteget/`, { params });
  }
}
