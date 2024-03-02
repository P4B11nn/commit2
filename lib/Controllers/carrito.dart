
import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CarritoController {
  Box carritoBox = Hive.box('carrito');

  CarritoController();  
  List<Producto> obtenerProductos() {
  return carritoBox.values.map((value) {
    Map<String, dynamic> map = new Map();
    value.forEach((key, value) {
      map[key.toString()] = value;
    });
    return Producto.fromMapcarrito(map);
  }).toList();
}

  void agregarProductoAlCarrito(Producto producto) {
    carritoBox.put(producto.id, producto.toMapcarrito());
  }

  void eliminarProductoDelCarrito(Producto producto) {
    carritoBox.delete(producto.id);
  }

  double obtenerTotalPrecio() {
  return obtenerProductos().fold(0.0, (previousValue, producto) => previousValue + producto.precio);
}
  int obtenerCantidad(String id) {
  return carritoBox.get(id)['cantidad'];
}
  void actualizarCantidad(String id, int nuevaCantidad) {
  carritoBox.put(id, {
    'id': id,
    'nombre': carritoBox.get(id)['nombre'],
    'precio': carritoBox.get(id)['precio'],
    'cantidad': nuevaCantidad,
  });
}
}
