// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AlmacenController.dart';
import 'package:flutter_application_3/Controllers/carrito.dart';
import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:flutter_application_3/Vista/AgregarProductos.dart';
import 'package:flutter_application_3/Vista/AlmacenView.dart';
import 'package:flutter_application_3/Vista/Inicio.dart';
import 'package:flutter_application_3/Vista/SaludosView.dart';
// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  List<Producto> productos = [
  ];
  HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController idController = TextEditingController();
  final CarritoController carritoController = CarritoController();
  final VerProductosController verProductosController =
      VerProductosController();
  Producto? productoBuscado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text('Punto de Ventas'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text('Menú'),
            ),
            ListTile(
              title: const Text('Almacen'),
              onTap: () {
                // Navega a la pantalla de Almacén
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  VerProductosView(stockss: verProductosController);
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Alta de Productos'),
              onTap: () {
                // Navega a la pantalla de Historial de Ventas
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AgregarProductoView(
                        productos: widget.productos,
                      );
                    },
                  ),
                );
              },
            ),
            // Agrega más ListTile aquí para más elementos en el menú
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue[50], // Un color de fondo agradable
                borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
              ),
              child: TextField(
                controller: idController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Buscar producto por ID',
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              child: const Text('Buscar'),
              onPressed: () async {
                if (idController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingrese un ID')),
                  );
                  return;
                }
                var box = await Hive.openBox('productos');
                var productoMap = box.get(idController.text);
                if (productoMap != null) {
                  var producto =
                      Producto.fromMap(productoMap.cast<String, dynamic>());
                  setState(() {
                    productoBuscado = producto;
                  });
                }
              },
            ),
            if (productoBuscado != null)
              ListTile(
                leading: CircleAvatar(
                  child: Text(productoBuscado!.id),
                ),
                title: Text(productoBuscado!.nombre),
                subtitle: Text(productoBuscado!.precio.toString()),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                elevation: 5,
              ),
              child: const Text('Agregar al carrito'),
              onPressed: () {
                if (productoBuscado == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Por favor, Ingrese el ID del producto')),
                  );
                  return;
                }
                var carritoBox = Hive.box('carrito');
                carritoBox.put(
                    productoBuscado!.id, productoBuscado!.toMapcarrito());
              },
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              child: const Text('Test Hive'),
              onPressed: () {
                verProductosController.imprimirProductos();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //color de fondo
                primary: Colors.blue,
                //color del texto
                onPrimary: Colors.white,
                //tamaño del boton
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                //tamaño del borde
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                //sombra
                elevation: 5,
              ),
              child: const Text('Ver carrito'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaludosView(
                        carritoController: carritoController,
                        carritoBox: Hive.box('carrito')),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Inicio(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      ),
    );

  }
}
