class CartItemModel {
  final num price;
  final String productId;
  final int quantity;
  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.price,
  });
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'productId': productId, 'quantity': quantity, 'price': price};
  }
}
