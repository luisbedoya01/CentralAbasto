import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PedidoService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  getPedido(transaccion: string): Observable<any> {
    let params = new HttpParams().set('Transaccion', transaccion);
    return this.http.get<any[]>(`${this.baseUrl}pedidoget/`, { params })
  }

  agregarPedido(pedido: any) {
    return this.http.post(this.baseUrl + "pedidopost/", pedido);
  }

  agregarDetallePedido(detalle: any) {
    return this.http.post(this.baseUrl + "detallepedidopost/", detalle);
  }

  editarPedido(id: number, pedido: any) {
    return this.http.post(this.baseUrl + "pedidopost/" + id + "/", pedido);
  }

  getDetallePedido(id: number, transaccion: string): Observable<any> {
    let params = new HttpParams()
      .set('IdPedido', id)
      .set('Transaccion',transaccion);
    
    return this.http.get<any[]>(`${this.baseUrl}detallepedidoget/`, { params });
  }

}
