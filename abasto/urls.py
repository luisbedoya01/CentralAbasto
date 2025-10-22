from django.urls import path, include
from rest_framework import routers
from abasto import views

# router = routers.DefaultRouter()
# router.register(r'usuarios', views.UsuarioView,'usuarios')

urlpatterns = [
    #path("abasto/",include(router.urls))
    path('api/v1/usuariopost/', views.loginViewPost),
    path('api/v1/usuario/', views.registrarViewPost),
    path('api/v1/producto/', views.agregarProductoViewPost),
    path('api/v1/producto/<int:id>/', views.agregarProductoViewPost),
    path('api/v1/productoget/', views.getProductoViewGet),
    path('api/v1/categoriaget/', views.getCategoriaViewGet),
    path('api/v1/categoriapost/', views.agregarCategoriaViewPost),  
    path('api/v1/categoriaget/<int:IdProcucto>', views.getCategoriaViewGet),
    path('api/v1/estados/', views.getEstadosViewGet),
    path('api/v1/marca/', views.agregarMarcaViewPost),
    path('api/v1/marcaget/', views.getMarcaViewGet),
    path('api/v1/unidadget/', views.getUnidadViewGet),
    path('api/v1/unidad/', views.agregarUnidadViewPost),
    path('api/v1/proveedor/', views.agregarProveedorViewPost),
    path('api/v1/proveedorget/', views.getProveedorViewGet),
    path('api/v1/precioventa/', views.agregarPrecioVentaViewPost),
    path('api/v1/precioventa/<int:id>/', views.agregarPrecioVentaViewPost),
    path('api/v1/precioventaget/', views.getPrecioVentaViewGet),
    path('api/v1/precioventaget/<int:id>', views.getPrecioVentaViewGet),
    path('api/v1/usuarioget/',views.obtenerUsuarioViewGet),
    path('api/v1/usuario/<int:id>/', views.registrarViewPost),
    path('api/v1/rolget/', views.getRolViewGet),
    path('api/v1/medidaconversionget/',views.getMedidasConversionViewGet),
    path('api/v1/medidaconversionget/<int:id>',views.getMedidasConversionViewGet),
    path('api/v1/medidaconversion/', views.agregarMedidasConversionViewPost),
    path('api/v1/medidaconversion/<int:id>/', views.agregarMedidasConversionViewPost),
    path('api/v1/stockproductopost/<int:id>/', views.agregarStockProductoViewPost),
    # path('api/v1/stockproductoget/<int:id>',views.getStockProductoViewGet),
    path('api/v1/stockproductoget/<int:Id_Producto>/',views.getStockProductoViewGet),
    path('api/v1/ivaget/<int:id>/',views.getIvaViewGet),
    path('api/v1/ivaget/',views.getIvaViewGet),
    path('api/v1/ivapost/<int:id>/',views.agregarIvaViewPost),
    path('api/v1/ivapost/',views.agregarIvaViewPost),
    path('api/v1/pedidopost/',views.agregarPedidoViewPost),
    path('api/v1/pedidopost/<int:id>/',views.agregarPedidoViewPost),
    path('api/v1/pedidoget/',views.getPedidoViewGet),
    path('api/v1/detallepedidopost/',views.agregarDetallePedidoViewPost),
    path('api/v1/detallepedidoget/<int:id>/',views.getDetallePedidoViewGet),
    path('api/v1/detallepedidoget/',views.getDetallePedidoViewGet),
    path('api/v1/detallepedidoget/',views.getDetallePedidoViewGet),
    path('api/v1/facturapost/',views.agregarFacturaViewPost),
    path('api/v1/facturapost/<int:id>/',views.agregarFacturaViewPost),
    path('api/v1/detallefacturapost/',views.agregarDetalleFactura),
    path('api/v1/clienteget/',views.getClienteViewGet),
    path('api/v1/clientepost/',views.agregarClienteViewPost),
    path('api/v1/clientepost/<str:codigo>/<str:tipo>/', views.agregarClienteViewPost),
    path('api/v1/reporteget/', views.getReporteViewGet),
    
    # path('api/v1/precioventaget/<int:id>/', views.getPrecioVentaViewGet),
]