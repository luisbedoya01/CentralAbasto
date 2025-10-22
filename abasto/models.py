from django.db import models
#Modelo para la clase rol_usuario
class rol_usuario(models.Model):
    id = models.IntegerField
    descripcion = models.CharField(max_length=100)

    def __str__(self):
        return self.descripcion

# Create your models here.
class usuarios(models.Model):
    id = models.IntegerField
    cedula = models.CharField(max_length=10)
    nombres = models.CharField(max_length=45)
    apellidos = models.CharField(max_length=45)
    clave = models.CharField(max_length=100)
    idrol = models.ForeignKey(rol_usuario, on_delete=models.CASCADE)
    correo = models.CharField(max_length=45)
    sueldo = models.FloatField(null=True)

    def __str__(self):
        return self.nombres + ' ' + self.apellidos
