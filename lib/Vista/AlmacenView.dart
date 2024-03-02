import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AlmacenController.dart';
import 'package:flutter_application_3/Models/Modelo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VerProductosView extends StatefulWidget {
  const VerProductosView({Key? key, required List<Producto> productos}) : super(key: key);

  @override
  _VerProductosViewState createState() => _VerProductosViewState();
}

class _VerProductosViewState extends State<VerProductosView> {
  final VerProductosController verProductosController =
      VerProductosController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Almacen')),
      body: SingleChildScrollView(
        child: Column(
          children: verProductosController
              .verProductos()
              .map(
                (Producto producto) => ListTile(
                  leading: CircleAvatar(
                    child: Text(producto.id),
                  ),
                  title: Text(producto.nombre),
                  subtitle: Text(producto.precio.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      var box = Hive.box('productos');
                      await box.delete(producto.id);
                      setState(() {});
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
