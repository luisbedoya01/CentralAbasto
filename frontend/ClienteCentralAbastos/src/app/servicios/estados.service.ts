import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class EstadosService {
  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  getEstado(transaccion: string): Observable<any> {
    let params = new HttpParams().set('Transaccion', transaccion)
    return this.http.get<any[]>(`${this.baseUrl}estados/`, { params });
  }
}
