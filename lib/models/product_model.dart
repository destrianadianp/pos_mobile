class ProductModel {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final String category;
  final String userId;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.category,
    required this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'category': category,
      'userId' : userId
    };
  }

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      productName: map['productName'],
      productImage: map['productImage'],
      price: map['price'],
      category: map['category'],
      userId: map['userId'] ?? ''
    );
  }
}
