import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AlmacenController.dart';
import 'package:flutter_application_3/Controllers/carrito.dart';
import 'package:flutter_application_3/Vista/Pagoview.dart';
import 'package:hive_flutter/hive_flutter.dart';


// ignore: must_be_immutable
class SaludosView extends StatefulWidget {
 CarritoController carritoController = CarritoController();
  final Box carritoBox;
 final VerProductosController verProductosController = VerProductosController();
  SaludosView({Key? key, required this.carritoController, required this.carritoBox})
      : super(key: key);

  @override
  State<SaludosView> createState() => _SaludosViewState();
}

class _SaludosViewState extends State<SaludosView> {
int cantidad = 1;
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Precio')),
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Agregar')),
                  DataColumn(label: Text('Eliminar')),
                ],
              rows: widget.carritoController.obtenerProductos().map((producto) {
                return DataRow(cells: [
                  DataCell(Text(producto.id)),
                  DataCell(Text(producto.nombre)),
                  DataCell(Text(producto.precio.toString())),
                  DataCell(Text(cantidad.toString())),
                  DataCell(IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () {
                        setState(() {
                          cantidad += 1; // Incrementa la variable cantidad aquí
                          widget.verProductosController.decrementarStock(producto.id);
                        });
                      },
                    )),
                  DataCell(IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      widget.carritoController.eliminarProductoDelCarrito(producto);
                      widget.carritoBox.delete(producto.id);
                      setState(() {});
                    },
                  )),
                ]);
              }).toList(),
            ),
        ),
            //boton para ir a la ventana de pago
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PagoView(carritoBox: widget.carritoBox, carritoController: widget.carritoController)));
              },
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}