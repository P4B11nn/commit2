import 'package:flutter/material.dart';
import 'package:flutter_application_3/Vista/InicioView.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Tienda',
      theme: ThemeData(
        primarySwatch: Colors.cyan
        ,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Inicio(),
    );
  }
}

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Mi Tienda'),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'La mejor tienda para tus necesidades',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child:  const Text('Ir al Punto de Venta', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[800],
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[50],
    );
  }
}