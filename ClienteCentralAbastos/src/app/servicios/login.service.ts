import { Injectable } from '@angular/core';
import { HttpClient, HttpParams} from '@angular/common/http';
import { Observable } from 'rxjs';
import { UsuarioInterface } from '../interfaces/UsuarioInterface';

@Injectable({
  providedIn: 'root'
})

export class LoginService {

  baseUrl: string = 'http://127.0.0.1:8000/centralAbasto/api/v1/';
  
  constructor(private http: HttpClient) { }

  login(user: any){
    return this.http.post(this.baseUrl+"usuariopost/", user);
  }

  registro(user: any){
    return this.http.post(this.baseUrl+"usuario/", user);
  }

  getUsuario(transaccion: string): Observable<any> {
    let params = new HttpParams().set('Transaccion', transaccion);
    return this.http.get<any[]>(`${this.baseUrl}usuarioget/`, { params });
  }

  editarUsuario(id: number, usuario: any) {
    return this.http.post(this.baseUrl + "usuario/" + id + "/", usuario);
  }

  eliminarUsuario(id: number, usuario: any) {
    return this.http.post(this.baseUrl + "usuario/" + id + "/", usuario);
  }
}
