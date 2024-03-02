import 'package:flutter/material.dart';
import 'package:flutter_application_3/Controllers/AgregarProductosController.dart';
import 'package:flutter_application_3/Models/Modelo.dart';

class AgregarProductoView extends StatelessWidget {
  final List<Producto> productos;
  AgregarProductoView({Key? key, required this.productos}) : super(key: key);
  final TextEditingController idcontroller = TextEditingController();
  final TextEditingController nombrecontroller = TextEditingController();
  final TextEditingController preciocontroller = TextEditingController();
  final AgregarProductosController agregarProductosController =
      AgregarProductosController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Agregar producto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ID'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: idcontroller,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un ID';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Nombre'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nombrecontroller,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Precio'),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: preciocontroller,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un precio';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    elevation: 10,
                  ),
                  onPressed: () {
  if (_formKey.currentState!.validate()) {
    bool isAdded = agregarProductosController.agregarProducto(
      id: idcontroller.text,
      nombre: nombrecontroller.text,
      precio: preciocontroller.text,
    );
    if (isAdded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado con éxito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El producto ya existe')),
      );
    }
    Navigator.pop(context);
  }
},
                  child: const Text(
                    'Agregar Producto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
