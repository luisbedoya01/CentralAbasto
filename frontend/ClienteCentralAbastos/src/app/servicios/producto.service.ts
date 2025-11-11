import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductoService {

  // baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/'; // Desarrollo
  baseUrl = 'https://centralabastoapi.onrender.com/centralAbasto/api/v1/'; // Produccion

  constructor(private http: HttpClient) { }

  getProducto(transaccion: string, idProducto?: number): Observable<any> {
    let params = new HttpParams()
        .set('Transaccion',transaccion);
    if (idProducto !== undefined){
      params = params.set('IdProducto', idProducto.toString());
    }
    return this.http.get<any[]>(`${this.baseUrl}productoget/`, { params });
  }

  getProductoId(id: number): Observable<any> {
    return this.http.get<any>(`${this.baseUrl}productoget/${id}/`);
  }

  agregarProducto(producto: any){
    return this.http.post(this.baseUrl+"producto/", producto);
  }

  editarProducto(id: number, producto: any){
    return this.http.post(this.baseUrl+"producto/"+id+"/", producto);
  }

  eliminarProducto(id: number,producto: any){
    return this.http.post(this.baseUrl+"producto/"+id+"/", producto);
  }
}
