import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class CategoriaService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  getCategoria(transaccion: string): Observable<any> {
    let params = new HttpParams().set('Transaccion', transaccion)
    return this.http.get<any[]>(`${this.baseUrl}categoriaget/`, { params });
  }

  agregarCategoria(categoria: any) {
    return this.http.post(this.baseUrl + "categoriapost/", categoria);

  }
}
