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
        precio = map['precio'] is double
            ? map['precio']
            : double.parse(map['precio']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
    };
  }

  Producto.fromMapcarrito(Map<String, dynamic> map)
      : id = map['id'],
        nombre = map['nombre'],
        precio = map['precio'] is double
            ? map['precio']
            : double.parse(map['precio']);
  Map<String, dynamic> toMapcarrito() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
    };
  }
}
