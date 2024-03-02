import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/carrito.dart';
import 'package:flutter_application_3/Vista/Pagoview.dart';


class SaludosView extends StatefulWidget {
  final CarritoController carritoController;

  const SaludosView({Key? key, required this.carritoController}) : super(key: key);


  @override
  State<SaludosView> createState() => _SaludosViewState();
}

class _SaludosViewState extends State<SaludosView> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Eliminar')),
              ],
              rows: widget.carritoController.obtenerProductos().map((producto) {
                return DataRow(cells: [
                  DataCell(Text(producto.id)),
                  DataCell(Text(producto.nombre)),
                  DataCell(Text(producto.precio.toString())),
                  DataCell(IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      widget.carritoController.eliminarProductoDelCarrito(producto);
                      setState(() {});
                    },
                  )
                  ),
                ]);
              }).toList(),
            ),
            //boton para ir a la ventana de pago
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PagoView()));
              },
              child: const Text('Pagar'),
            ),
           

          ],
        ),
      ),
    );
  }
}