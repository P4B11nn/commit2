import 'package:hive_flutter/hive_flutter.dart';

class AgregarProductosController {
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

    // Devuelve true para indicar que el producto se agregó con éxito
    return true;
  }
}
}