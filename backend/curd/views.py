from django.shortcuts import render
from rest_framework import generics,viewsets, mixins
from .models import UserSerializer, UserDetails

class CreateListRetrieveViewSet(mixins.CreateModelMixin,
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