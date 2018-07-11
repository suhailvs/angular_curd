from django.db import models

# Create your models here.
class UserDetails(models.Model):
    firstName = models.CharField(max_length=255)
    email = models.CharField(max_length=255, blank=True)
    lastName = models.CharField(max_length=255)

from rest_framework import serializers
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetails
        fields = "__all__"