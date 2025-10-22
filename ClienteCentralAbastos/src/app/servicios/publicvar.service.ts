import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable()
export class PublicVarService {
 
  public logeado$ = new BehaviorSubject<boolean>(false);

  constructor() { }
}