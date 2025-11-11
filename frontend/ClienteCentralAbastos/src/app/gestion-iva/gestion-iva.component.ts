import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormControl, FormGroup, FormsModule, Validators } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { UnidadMedidaService } from '../servicios/unidad-medida.service';
import { UnidadService } from '../servicios/unidad.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { IvaService } from '../servicios/iva.service';
import Swal from 'sweetalert2';

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
    console.log('Datos a enviar', this.ivaForm.value);

    if (this.ivaForm.valid) {
      if (this.modoEdicion) {
        this.ivaService.editarIva(this.ivaSeleccionado.IdIva, this.ivaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Error al editar el IVA',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#d33',
              });

            } else {
              this.obtenerIva();
              this.cerrarModalAgregarIVA();
              Swal.fire({
                title: '¡IVA Editado!',
                text: 'El IVA ha sido editado correctamente',
                icon: 'success',
                timer: 1000,
                showConfirmButton: false
              });
            }
          },
          (error) => {
            const errorMessage = JSON.stringify(error, null, 2);
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'Error al actualizar IVA' + errorMessage,
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
              showClass: { popup: "animate_animated animatefadeIn animate_faster" },
            });
          }
        );
      } else {
        this.ivaService.agregarIva(this.ivaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'No se pudo registrar el IVA',
                confirmButtonText: 'Aceptar',
                confirmButtonColor: '#d33',
              });
            } else {
              this.obtenerIva();
              this.cerrarModalAgregarIVA();
              Swal.fire({
                title: '¡IVA Registrado!',
                text: 'El IVA ha sido registrado correctamente',
                icon: 'success',
                timer: 1000,
                showConfirmButton: false
              });
            }
          },
          (error) => {
            const errorMessage = JSON.stringify(error, null, 2);
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'Error en la solicitud al servidor. Consulte con el administrador: ' + errorMessage,
              confirmButtonText: 'Aceptar',
              confirmButtonColor: '#d33',
              showClass: { popup: "animate_animated animatefadeIn animate_faster" },
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

    this.ivaForm.patchValue({
      IdIva: iva.IdIva,
      DescripcionIva: iva.DescripcionIva,
      PorcentajeIva: iva.PorcentajeIva
    });
  }

}
