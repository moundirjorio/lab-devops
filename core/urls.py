from django.contrib import admin
from django.urls import path
from portal.views import home # type: ignore

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home, name='home'),
]