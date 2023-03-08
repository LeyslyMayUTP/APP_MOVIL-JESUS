class Producto {
  String name;
  String price;
  String quantity;

  Producto({
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory Producto.fromJson(Map json) {
    return Producto(
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
    );
  }
}
