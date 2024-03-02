import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VerProductosController {

  List<Producto> verProductos() {
    var productos = Hive.box('productos');
    if (productos.isNotEmpty) {
      List<Producto> listaProductos = [];
     for (var i = 0; i < productos.length; i++) {
        double? precio;
        try {
          precio = double.parse(productos.getAt(i)['precio']);
        } catch (e) {
         // Si el precio no puede ser convertido a double, se asigna null
          precio = null;
        }
        listaProductos.add(
          Producto(
            id: productos.getAt(i)['id'],
            nombre: productos.getAt(i)['nombre'],
            precio: precio ?? 0.0,
          ),
        );
      }
      return listaProductos;
    }
    return [];
  }
Future<void> imprimirProductos() async {
  Box<dynamic> box;
  if (Hive.isBoxOpen('productos')) {
    box = Hive.box('productos');
  } else {
    box = await Hive.openBox('productos');
  }
  var valores = box.values.toList();
  for (var valor in valores) {
    print(valor.toString());
  }
}

void eliminarProducto(String id) async {
  Box<dynamic> box;
  if (Hive.isBoxOpen('productos')) {
    box = Hive.box('productos');
  } else {
    box = await Hive.openBox('productos');
  }
  await box.delete(id);
}
}
