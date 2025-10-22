from rest_framework import serializers
from .models import usuarios

class UsurioSerializer(serializers.ModelSerializer):
    class Meta:
        # fields = ('id', 'nombre', 'apellido', 'email', 'password')
        model = usuarios
        fields = '__all__'