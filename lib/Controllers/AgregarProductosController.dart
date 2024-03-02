import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AgregarProductosController {
   Map<String, int> stocks = {};
  bool agregarProducto({
    required String id,
    required String nombre,
    required String precio,
  }) {
   {
    //1.- validar mis datos (entrada)

    //2.- guardar en la base de datos
    var productos = Hive.box('productos');
    
    // Comprueba si el producto ya existe
    if (productos.containsKey(id)) {
      // Si el producto ya existe, devuelve false
      return false;
    }

    // Si el producto no existe, agrégalo a la base de datos
    productos.put(
      id,
      {
        'id': id,
        'nombre': nombre,
        'precio': precio,
      },
    );
    stocks[id] = 0;
    // Devuelve true para indicar que el producto se agregó con éxito
    return true;
  }
}

 void actualizarStock(String id, int nuevoStock) {
    // Actualiza el stock del producto en el mapa stocks
    stocks[id] = nuevoStock;
  }
}