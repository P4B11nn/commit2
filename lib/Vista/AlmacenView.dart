import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AlmacenController.dart';

class AlmacenView extends StatelessWidget {
  final AlmacenController almacenController = AlmacenController();

  AlmacenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almacen'),
      ),
      body: Container(
        // Add your UI elements here
        
      ),
    );
  }
}
