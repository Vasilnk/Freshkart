class ProductModel {
  final String name;
  final List<String> images;
  final String quantity;
  final String description;
  final String price;
  final bool offer;
  final String offerPrice;
  final String unitType;
  final String categoryName;

  ProductModel({
    required this.name,
    required this.images,
    required this.quantity,
    required this.description,
    required this.price,
    required this.offer,
    required this.offerPrice,
    required this.unitType,
    required this.categoryName,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      images: List<String>.from(map['images']),
      quantity: map['quantity'],
      description: map['discription'],
      price: map['price'],
      offer: map['offer'],
      offerPrice: map['offerPrice'],
      unitType: map['unitType'],
      categoryName: map['categoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'images': images,
      'quantity': quantity,
      'discription': description,
      'price': price,
      'offer': offer,
      'offerPrice': offerPrice,
      'unitType': unitType,
      'categoryId': categoryName,
    };
  }
}
