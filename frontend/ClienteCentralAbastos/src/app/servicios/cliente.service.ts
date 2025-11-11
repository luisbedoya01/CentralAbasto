import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ClienteService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  agregarCliente(cliente: any) {
    return this.http.post(this.baseUrl + "clientepost/", cliente);
  }

  editarCliente(codigo: string, tipo: string, cliente: any) {
    return this.http.post(
      this.baseUrl + "clientepost/" + codigo + "/" + tipo + "/",
      cliente
    );
  }

  buscarCliente(codigo: string, tipo: string, transaccion: string): Observable<any> {
    let params = new HttpParams()
      .set('CodigoIdentificacion', codigo)
      .set('CodTipoId', tipo)
      .set('Transaccion', transaccion);

    return this.http.get<any[]>(`${this.baseUrl}clienteget/`, { params });
  }
}
