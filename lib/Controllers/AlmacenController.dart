import 'package:flutter/material.dart';

class AlmacenController extends ChangeNotifier {
  // Add your properties and methods here
  
  // Example property
  List<String> productos = [];

  // Example method
  void agregarProducto(String producto) {
    productos.add(producto);
    notifyListeners();
  }
}
