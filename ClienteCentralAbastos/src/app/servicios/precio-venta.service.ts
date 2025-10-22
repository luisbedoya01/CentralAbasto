import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PrecioVentaService {

  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  // getPreciosVenta(transaccion: string): Observable<any> {
  //   let params = new HttpParams().set('Transaccion', transaccion)
  //   return this.http.get<any[]>(`${this.baseUrl}precioventaget/`, { params });
  // }

  // getPrecioVenta(id: number, transaccion: string): Observable<any> {
  //   let params = new HttpParams().set('IdProducto', id);
  //   return this.http.get<any>(`${this.baseUrl}precioventaget/${transaccion}/${params}/`);
  // }

  getPrecioVenta(id: number, transaccion: string): Observable<any> {
    let params = new HttpParams()
        .set('IdProducto', id)  
        .set('Transaccion', transaccion);
    
    return this.http.get<any[]>(`${this.baseUrl}precioventaget/`, { params });
  }

  agregarPrecioVenta(precioVenta: any) {
    return this.http.post(this.baseUrl + "precioventa/", precioVenta);
  }

  editarPrecioVenta(id: number, precioVenta: any) {
    return this.http.post(this.baseUrl + "precioventa/"+id+"/", precioVenta);
  }
  
  eliminarPrecioVenta(id: number, precioVenta: any) {
    return this.http.post(this.baseUrl+"precioventa/"+id+"/", precioVenta);
  }

}
