import 'package:flutter/material.dart';
import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VerProductosController {

   Map<String, int> stocks = {
  };
    List<Producto> verProductos() {
    var productos = Hive.box('productos');
    if (productos.isNotEmpty) {
      List<Producto> listaProductos = [];
      for (var i = 0; i < productos.length; i++) {
        listaProductos.add(
          Producto(
            id: productos.getAt(i)['id'],
            nombre: productos.getAt(i)['nombre'],
            precio: double.parse(productos.getAt(i)['precio'].toString()),
          ),
        );
         int stock = productos.getAt(i)['stock']??0;
         stocks[productos.getAt(i)['id']] = stock;
      }
      return listaProductos;
    }
    return [];
  }
Future<void> imprimirProductos() async {
  Box<dynamic> box;
  if (Hive.isBoxOpen('carrito')) {
    box = Hive.box('carrito');
  } else {
    box = await Hive.openBox('carrito');
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
void mostrarDialogoActualizar(BuildContext context,Producto producto,Function onUpdate) {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController(text: producto.nombre);
  final _precioController = TextEditingController(text: producto.precio.toString());
  final _stockController = TextEditingController(text: stocks[producto.id].toString());
  

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Actualizar o Modificar Producto'),
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nuevo nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nuevo precio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor defina stock o actualice el stock';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Actualizar'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                producto.nombre = _nombreController.text;
                producto.precio = double.parse(_precioController.text); 
                int nuevoStock = int.parse(_stockController.text);
                actualizarStock(producto.id, nuevoStock);
                actualizarProducto(producto,nuevoStock);
                Navigator.of(context).pop();  
                onUpdate(producto,nuevoStock);    
              }
            },
          ),
        ],
      );
    },
  );
}

void actualizarProducto(Producto productoActualizado,int nuevoStock) async {
 var    box = Hive.box('productos');
  await box.put(productoActualizado.id, productoActualizado.toMap());
  var productoMap = box.get(productoActualizado.id);
  productoMap['stock'] = nuevoStock;
  print(nuevoStock);
}
  void actualizarStock(String idProducto, int nuevoStock) {
  stocks[idProducto] = nuevoStock;
}
 void decrementarStock(String idProducto) {
    if (stocks.containsKey(idProducto) && stocks[idProducto]! > 0) {
       stocks[idProducto] = stocks[idProducto]! - 1; // Asigna un nuevo valor a la entrada del mapa aquí
    }
  }
}
