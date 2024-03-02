import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/carrito.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PagoView extends StatelessWidget {
  final Box carritoBox;
  final CarritoController carritoController;

  PagoView({Key? key, required this.carritoBox, required this.carritoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 0.0;

    carritoController.obtenerProductos().forEach((producto) {
      int cantidad = carritoController.obtenerCantidad(producto.id); // Obtiene la cantidad de cada producto
      total += producto.precio * cantidad; // Calcula el total basado en la cantidad de cada producto
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Total a pagar: \$${total.toStringAsFixed(2)}', // Muestra el total aquí
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}