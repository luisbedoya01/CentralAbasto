import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  agregarFactura(factura: any) {
    return this.http.post(this.baseUrl + "facturapost/", factura);
  }

  agregarDetalleFactura(detalle: any) {
    return this.http.post(this.baseUrl + "detallefacturapost/", detalle);
  }
}
