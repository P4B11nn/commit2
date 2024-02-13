import 'package:flutter/material.dart';

class AgregarProductos extends StatelessWidget {
  const AgregarProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Precio',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add product logic here
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}
