import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormControl, FormGroup, FormsModule, Validators } from '@angular/forms';
import { ReactiveFormsModule } from '@angular/forms';
import { MatIconModule } from '@angular/material/icon';
import { UnidadMedidaService } from '../servicios/unidad-medida.service';
import { UnidadService } from '../servicios/unidad.service';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-medidas-conversion',
  standalone: true,
  imports: [CommonModule, MatIconModule, FormsModule, ReactiveFormsModule],
  templateUrl: './medidas-conversion.component.html',
  styleUrl: './medidas-conversion.component.css'
})
export class MedidasConversionComponent implements OnInit {

  constructor(private medidasConversion: UnidadMedidaService,
    private unidadService: UnidadService,
    private snackBar: MatSnackBar) { }

  ngOnInit(): void {
    this.obtenerMedidasConversion();
    this.obtenerUnidades();
  }


  //#region Arreglos para las listas
  medidas: any[] = [];
  unidades: any[] = [];
  medidasFiltradas: any[] = [];
  medidasPaginadas: any[] = [];
  paginaActual: number = 1;
  itemsPorPagina: number = 5;
  opcionesPorPagina: number[] = [5, 10, 15, 20];
  paginasTotales: number = 0;
  //#endregion

  //#region Variables
  respuesta: any = null;
  isModalVisible: boolean = false;
  isModalVisibleEliminar: boolean = false;
  isModalUnidadMedidaVisible: boolean = false;
  modoEdicion: boolean = false;
  medidaSeleccionada: any = null;
  filtro: string = '';
  mensajeNoResultados: string = '';
  //#endregion

  //#region Propiedades del formulario
  // Medida de Conversión
  idMedida: any;
  idUnidadPrincipal: any;
  idUnidadConvertir: any;
  factorConversion: any;

  //Unidad de medida
  nombreUnidad: any;

  //#endregion

  abrirModalAgregarMedida() {
    this.isModalVisible = true;
  }

  cerrarModalAgregarMedida() {
    this.isModalVisible = false;
    this.medidaForm.reset();
  }

  medidaForm = new FormGroup({
    Id_Medida: new FormControl(),
    Id_Unidad_Principal: new FormControl('', Validators.required),
    Id_Unidad_Convertir: new FormControl('', Validators.required),
    Factor_Conversion: new FormControl('', [Validators.required, Validators.min(0)]),
    Transaccion: new FormControl(),
  });

  unidadForm = new FormGroup({
    Nombre: new FormControl('', Validators.required),
    Transaccion: new FormControl(),
  });

  obtenerMedidasConversion() {
    this.medidasConversion.getUnidadMedida('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          //console.log('Datos obtenidos:', data);
          //console.log('Todo bien');
          this.medidas = data;
          this.medidasFiltradas = data;
          this.filtrarMedidas();
        } else {
          console.log('Error: La respuesta no es un arreglo', data);
        }
      },
      (error) => {
        console.log('Error al obtener las medidas de conversión:', error);
      }
    );
  }

  obtenerUnidades() {
    this.unidadService.getUnidad('consulta_general').subscribe(
      (data: any) => {
        if (Array.isArray(data)) {
          this.unidades = data;
        }
        else {
          console.log('Error: la respuesta del servidor no es un array', data);
        }
      },
      (error) => {
        console.log('Error en la solicitud al servidor. Consulte con el administrador: ' + error);
      }
    );
  }

  agregarMedida() {
    this.idMedida = this.medidaForm.value.Id_Medida;
    this.idUnidadPrincipal = this.medidaForm.value.Id_Unidad_Principal;
    this.idUnidadConvertir = this.medidaForm.value.Id_Unidad_Convertir;
    this.factorConversion = this.medidaForm.value.Factor_Conversion;
    this.medidaForm.value.Transaccion = this.modoEdicion ? "editar_medida_conversion" : "agregar_medida_conversion";

    //console.log('Datos a enviar:', this.medidaForm.value);

    if (this.medidaForm.valid) {
      if (this.modoEdicion) {
        // Si está en modo edición, llamamos al servicio de edición
        //console.log('Editando medida de conversión:', this.medidaForm.value);
        this.medidasConversion.editarMedidaConversion(this.medidaSeleccionada.Id_Medida, this.medidaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            if (data.length === 0) {
              this.snackBar.open('Error al editar la medida de conversión', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['error-snackbar']
              });
            } else {
              this.snackBar.open('Medida de conversión editada correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerMedidasConversion();
              this.cerrarModalAgregarMedida();
            }
            console.log('Respuesta del servidor:', data);
          },
          (error) => {
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      } else {
        // Si no está en modo edición, llamamos al servicio de agregar
        this.medidasConversion.agregarMedidaConversion(this.medidaForm.value).subscribe(
          (data: any) => {
            this.respuesta = data;
            console.log(data);
            if (data.length === 0) {
              this.snackBar.open('Error al agregar producto', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
            } else {
              this.snackBar.open('Producto agregado correctamente', 'Cerrar', {
                duration: 3000,
                horizontalPosition: 'center',
                verticalPosition: 'bottom',
                panelClass: ['succes-snackbar']
              });
              this.obtenerMedidasConversion();
              this.cerrarModalAgregarMedida();
            }
            console.log('Respuesta del servidor:', data);
          },
          (error) => {
            this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
              duration: 4000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['error-snackbar']
            });
          }
        );
      }
    } else {
      this.snackBar.open('Todos los campos son requeridos', 'Cerrar', {
        duration: 3000,
        horizontalPosition: 'center',
        verticalPosition: 'bottom',
        panelClass: ['error-snackbar']
      });
    }
  }

  filtrarMedidas() {
    const texto = this.filtro.trim().toLowerCase();
    this.medidasFiltradas = this.medidas.filter(p =>
      p.Nombre_Medida_Principal.toLowerCase().includes(texto) ||
      p.Nombre_Medida_Convertir.toLowerCase().includes(texto) ||
      p.Factor_Conversion.toString().includes(texto)
    );

    if (this.medidasFiltradas.length === 0) {
      this.mensajeNoResultados = 'No se encontraron resultados para ' + `"${this.filtro}"`;
    } else {
      this.mensajeNoResultados = '';
    }

    this.paginaActual = 1;
    this.actualizarPaginacion();
  }

  actualizarPaginacion() {
    const inicio = (this.paginaActual - 1) * this.itemsPorPagina;
    const fin = inicio + this.itemsPorPagina;
    this.paginasTotales = Math.ceil(this.medidasFiltradas.length / this.itemsPorPagina);
    this.medidasPaginadas = this.medidasFiltradas.slice(inicio, fin);
  }

  cambiarItemsPorPagina() {
    this.paginaActual = 1; // Reiniciar a la primera página al cambiar el número de items por página
    this.actualizarPaginacion();
  }

  cambiarPagina(nuevaPagina: number) {
    if (nuevaPagina >= 1 && nuevaPagina <= this.paginasTotales) {
      this.paginaActual = nuevaPagina;
      this.actualizarPaginacion();
    }
  }

  editarMedida(medida: any) {
    this.modoEdicion = true;
    this.medidaSeleccionada = medida;
    this.isModalVisible = true;

    console.log(this.medidaSeleccionada);

    this.medidaForm.patchValue({
      Id_Medida: medida.Id_Medida,
      Id_Unidad_Principal: medida.Id_Unidad_Principal,
      Id_Unidad_Convertir: medida.Id_Unidad_Convertir,
      Factor_Conversion: medida.Factor_Conversion,
    });      
  }
  
  eliminarMedida(medida: any) {
    this.medidaSeleccionada = medida;
    this.isModalVisibleEliminar = true;
  }

  cerrarModalEliminar() {
    this.isModalVisibleEliminar = false;
  }

  eliminarMedidaConfirmada() {
    this.medidaSeleccionada.Transaccion = "eliminar_medida_conversion";
    this.medidasConversion.eliminarMedidaConversion(this.medidaSeleccionada.Id_Medida, this.medidaSeleccionada).subscribe(
      (data: any) => {
        this.respuesta = data;
        if (data.length === 0) {
          this.snackBar.open('Error al eliminar la medida de conversión', 'Cerrar', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
        } else {
          this.snackBar.open('Medida de conversión eliminada correctamente', 'Cerrar', {
            duration: 3000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['succes-snackbar']
          });
          this.obtenerMedidasConversion();
          this.cerrarModalEliminar();
        }
        console.log('Respuesta del servidor:', data);
      }
    );
  }

  abrirModalUnidadMedida() {
    this.isModalUnidadMedidaVisible = true;
  }

  cerrarModalUnidadMedida() {
    this.isModalUnidadMedidaVisible = false;
    //this.unidadForm.reset();
  }

  guardarUnidadMedida() {
    this.nombreUnidad = this.unidadForm.value.Nombre;
    this.unidadForm.value.Transaccion = "agregar_unidad";

    if (this.unidadForm.valid) {
      this.unidadService.agregarUnidad(this.unidadForm.value).subscribe(
        (data: any) => {
          this.respuesta = data;
          console.log(data);
          if (data.length === 0) {
            this.snackBar.open('Error al agregar unidad de medida', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
          } else {
            this.snackBar.open('Unidad de medida agregada correctamente', 'Cerrar', {
              duration: 3000,
              horizontalPosition: 'center',
              verticalPosition: 'bottom',
              panelClass: ['succes-snackbar']
            });
            this.obtenerUnidades();
            this.cerrarModalUnidadMedida();
          }
          console.log('Respuesta de la API:', data);
        },
        (error) => {
          this.snackBar.open('Error en la solicitud al servidor. Consulte con el administrador:' + error, 'Cerrar', {
            duration: 4000,
            horizontalPosition: 'center',
            verticalPosition: 'bottom',
            panelClass: ['error-snackbar']
          });
        }
      );
    }
  }

}
