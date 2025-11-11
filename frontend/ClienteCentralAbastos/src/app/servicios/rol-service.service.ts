import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class RolServiceService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  getRol(transaccion: string) {
    let params = new HttpParams().set('Transaccion', transaccion);
    return this.http.get<any[]>(`${this.baseUrl}rolget/`, { params });
  }

  agregarRol(rol: any) {
    return this.http.post(this.baseUrl + "rol/", rol);
  }
}
