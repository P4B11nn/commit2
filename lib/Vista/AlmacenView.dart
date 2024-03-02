import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AlmacenController.dart';
import 'package:flutter_application_3/Models/Modelo.dart';

class VerProductosView extends StatefulWidget {
  const VerProductosView({Key? key, required this.stockss }) : super(key: key);
   final VerProductosController stockss;
  @override
  _VerProductosViewState createState() => _VerProductosViewState(stockss: stockss);
}

class _VerProductosViewState extends State<VerProductosView> {
  final VerProductosController verProductosController = VerProductosController();
  List<Producto> _productos = [];
  
  var stockss = VerProductosController();
  _VerProductosViewState({required this.stockss});
  @override
  void initState() {
    super.initState();
    _productos = verProductosController.verProductos();
  }


  _actualizarProducto(Producto producto,int nuevoStock) async {
     verProductosController.actualizarProducto(producto, nuevoStock);
    setState(() {
      _productos = verProductosController.verProductos();
    });
  }

  void _eliminarProducto(String id) async {
   verProductosController.eliminarProducto(id);
    setState(() {
      _productos = verProductosController.verProductos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Almacen')),
      body: SingleChildScrollView(
        child: Column(
          children: _productos.map(
            (Producto producto) => ListTile(
              leading: CircleAvatar(
                child: Text(producto.id),
              ),
              title: Text(producto.nombre),
             subtitle: Row(
          children: <Widget>[
            Text('\$${producto.precio}'),
            const SizedBox(width: 10),  
            // Añade un poco de espacio entre el precio y el stock
            Text('Stock: ${verProductosController.stocks[producto.id]}'),  // Muestra el stock del producto
          ],
        ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      verProductosController.mostrarDialogoActualizar(context, producto, _actualizarProducto);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _eliminarProducto(producto.id);
                    },
                  ),
                ],
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}