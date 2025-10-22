import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RolServiceService {

  baseUrl: string = 'http://127.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  getRol(transaccion: string) {
    let params = new HttpParams().set('Transaccion', transaccion);
    return this.http.get<any[]>(`${this.baseUrl}rolget/`, { params });
  }
}
