class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String size;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.size,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  CartItem copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? price,
    String? size,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}
