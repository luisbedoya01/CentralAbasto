import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormControl, FormGroup, FormsModule, Validators } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { UnidadMedidaService } from '../servicios/unidad-medida.service';
import { UnidadService } from '../servicios/unidad.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { IvaService } from '../servicios/iva.service';


@Component({
  selector: 'app-gestion-iva',
  standalone: true,
  imports: [CommonModule, MatIconModule, FormsModule, ReactiveFormsModule],
  templateUrl: './gestion-iva.component.html',
  styleUrl: './gestion-iva.component.css'
})
export class GestionIvaComponent implements OnInit {

  iva: any[] = [];

  respuesta: any = null;
  isModalVisible: boolean = false;
  modoEdicion: boolean = false;

  idIva: any;
  descripcionIva: any;
  porcentajeIva: any;
  ivaSeleccionado: any = null;

  constructor(private ivaService: IvaService, private snackBar: MatSnackBar) { }

  ngOnInit(): void {
    this.obtenerIva();
  }

  abrirModalAgregarIVA() {
    this.modoEdicion = false;
    this.isModalVisible = true;
  }
  cerrarModalAgregarIVA() {
    this.ivaForm.reset();
    this.isModalVisible = false;
  }

  ivaForm = new FormGroup({
    IdIva: new FormControl(),
    DescripcionIva: new FormControl('', Validators.required),
    PorcentajeIva: new FormControl('', [Validators.required, Validators.min(0)]),
    Transaccion: new FormControl(),
  });

  obtenerIva() {
    this.ivaService.getIva('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.iva = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        const errorMessage = JSON.stringify(error, null, 2);
        console.log('Error en la solicitud al servidor. Console con el administrador:' + errorMessage);
      }
    );
  }

  guardarIva() {
    this.descripcionIva = this.ivaForm.value.DescripcionIva;
    this.porcentajeIva = this.ivaForm.value.PorcentajeIva;
    this.ivaForm.value.Transaccion = this.modoEdicion ? "editar_iva" : "agregar_iva";
    console.log('Datos a enviar',this.ivaForm.value);

    if (this.ivaForm.valid) {
      if (this.modoEdicion) {
        this.ivaService.editarIva(this.ivaSeleccionado.IdIva, this.ivaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              this.snackBar.open('Error al editar IVA', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['error-snackbar']
              });
            } else {
              this.snackBar.open('IVA editado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerIva();
              this.cerrarModalAgregarIVA();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            const errorMessage = JSON.stringify(error, null, 2);
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + errorMessage, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      } else {
        this.ivaService.agregarIva(this.ivaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              this.snackBar.open('Error al agregar IVA', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['error-snackbar']
              });
            } else {
              this.snackBar.open('IVA agregado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerIva();
              this.cerrarModalAgregarIVA();
            }
            console.log('Respuesta de la API:', data);
          },
          (error) => {
            const errorMessage = JSON.stringify(error, null, 2);
            console.log('Error', errorMessage)
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + errorMessage, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      }
    } else {
      this.snackBar.open('El formulario contiene errores. Por favor, verifique los datos.', 'Cerrar', {
        duration: 3000,
        horizontalPosition: 'center',
        verticalPosition: 'bottom',
        panelClass: ['error-snackbar']
      });
    }
  }


  editarIva(iva: any) {
    this.modoEdicion = true;
    this.ivaSeleccionado = iva;
    this.isModalVisible = true;
    console.log('Selección: ' , this.ivaSeleccionado);

    this.ivaForm.patchValue({
      IdIva: iva.IdIva,
      DescripcionIva: iva.DescripcionIva,
      PorcentajeIva: iva.PorcentajeIva
    });
  }

}
