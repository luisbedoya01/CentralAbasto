import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class StockProductoService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  getStockProducto(idProducto: number, transaccion: string): Observable<any> {
    if (!idProducto) {
      return throwError(() => new Error('ID de producto es requerido'));
    }
    const url = `${this.baseUrl}stockproductoget/${idProducto}/`;
    const params = new HttpParams().set('Transaccion', transaccion);

    return this.http.get<any>(url, { params });
  }

  agregarStockProducto(stock: any) {
    if (!stock.IdProducto) {
      console.error('Error: El stock debe tener un IdProducto válido.');
      return throwError('Id requerido');
    }
    const url = `${this.baseUrl}stockproductopost/${stock.IdProducto}/`;
    console.log('URL completa con ID:', url);
    return this.http.post(url, stock);
  }
}
