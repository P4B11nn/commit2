 import 'package:flutter/material.dart';
import 'package:flutter_application_3/Vista/AgregarProductos.dart';
import 'package:flutter_application_3/Vista/AlmacenView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
       foregroundColor: Colors.cyan,
         centerTitle: true,
        title: const Text('Punto de Venta'),
      ),
      drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Menú'),
        ),
        ListTile(
          title: const Text('Almacen'),
          onTap: () {
            // Navega a la pantalla de Almacén
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AlmacenView()),
                );
          },
        ),
        ListTile(
          title: const Text('Añadir Producto'),
          onTap: () {
            // Navega a la pantalla de Historial de Ventas
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AgregarProductos()),
                );
          },
        ),
        // Agrega más ListTile aquí para más elementos en el menú
      ],
    ),
  ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10,),
        child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            //agregar un menu emergente lateral dond este el almacen y el historial de ventas
            //agregar un boton para agregar productos al almacen
            //agregar un boton para ver el historial de ventas
            const Text(
              'Bienvenido al Punto de Venta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
           
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID o nombre del Producto',
                contentPadding: EdgeInsets.all(10),
                prefix: Icon(Icons.search),
                //suffix: Icon(Icons.search),
                //buscar el pruducto en el almacen
              ),
            ),
            const SizedBox(height: 20),
           
            ElevatedButton(
              onPressed: () {
                // agregar producto al carrito     
              },
              child: const Text('Agregar a carrito'),
            ),
            const SizedBox(height: 20),              
            ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              child: const Text('Realizar Venta'),
            ),
          ],
        ),
        ),
      ),
      );
    }
}