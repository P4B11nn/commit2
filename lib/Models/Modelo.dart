class Producto {
  String id;
  String nombre;
  double precio;

  Producto({
    required this.nombre,
    required this.precio,
    required this.id,
  });

  Producto.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nombre = map['nombre'],
        precio = double.parse(map['precio']);
}