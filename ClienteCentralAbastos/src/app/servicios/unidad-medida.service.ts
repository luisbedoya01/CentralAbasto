import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UnidadMedidaService {

  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';

  constructor(private http: HttpClient) { }

  getUnidadMedida(transaccion: string, idMedida?:number): Observable<any> {
    let params = new HttpParams()
      .set('Transaccion', transaccion);
    if (idMedida !== undefined) {
      params = params.set('Id_Medida', idMedida.toString());
    }
    return this.http.get<any[]>(`${this.baseUrl}medidaconversionget/`, { params });
  }

  agregarMedidaConversion(medida: any) {
    //return this.http.post(`${this.baseUrl}medidaconversion/`, medida);
    return this.http.post(this.baseUrl + "medidaconversion/", medida);
  }

  editarMedidaConversion(id: number, medida: any) {
    return this.http.post(this.baseUrl + "medidaconversion/" + id + "/", medida);
  }

  eliminarMedidaConversion(id: number, medida: any) {
    return this.http.post(this.baseUrl + "medidaconversion/" + id + "/", medida);
  }
}
