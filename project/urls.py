from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from calorieapp.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',home,name='home'),
    path('about',about,name='about'),
    path('contact',contact,name='contact'),
    path('dashboard',dashboard,name='dashboard'),
    path('myprofile',myprofile,name='myprofile'),
    path('user_login',user_login,name='user_login'),
    path('user_register',user_register,name='user_register'),
    path('predict/<int:id>',predict,name='predict'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

