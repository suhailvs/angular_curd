from rest_framework import viewsets
from .models import UserSerializer, UserDetails

class UserListAPIView(viewsets.ModelViewSet):
    queryset = UserDetails.objects.order_by('-modified')
    serializer_class = UserSerializer