from django.shortcuts import render
from rest_framework import generics,viewsets, mixins
from .models import UserSerializer, UserDetails

#https://spapas.github.io/2018/05/08/django-reponse-add-delay/
import time
class TimeDelayMixin(object, ):
    def dispatch(self, request, *args, **kwargs):
        time.sleep(2)
        return super().dispatch(request, *args, **kwargs)

class CreateListRetrieveViewSet(TimeDelayMixin,mixins.CreateModelMixin,
                                mixins.ListModelMixin,
                                mixins.RetrieveModelMixin,
                                mixins.UpdateModelMixin,
                                mixins.DestroyModelMixin,
                                viewsets.GenericViewSet):    
    pass

class UserListAPIView(CreateListRetrieveViewSet):
    queryset = UserDetails.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        print (request.data)
        #return super().to_representation(instance)
        return super(UserListAPIView, self).create(request, *args, **kwargs)