class Product {
  final String id;
  final String name;
  final String brand;
  final String size;
  final String description;
  final double quantity;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.size,
    required this.description,
    required this.quantity,
    required this.price,
  });

  // method to convert the firebase document in to a dart object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['model'] ?? '',
      size: json['size'] ?? '',
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? '',
      price: json['price'] ?? '',
    );
  }

  // convert the product model to a firebase document
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'model': brand,
      'size': size,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }
}
