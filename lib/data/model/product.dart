class Product {
  int id;
  int price;
  int discount;
  int discountPrice;
  int productCount;
  String title;
  String specialExpiration;
  String category;
  String brand;
  String image;

  Product({
    required this.id,
    required this.price,
    required this.discount,
    required this.discountPrice,
    required this.productCount,
    required this.title,
    required this.specialExpiration,
    required this.category,
    required this.brand,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      discount: json['discount'],
      discountPrice: json['discount_price'],
      productCount: json['product_count'],
      title: json['title'],
      specialExpiration: json['special_expiration'],
      category: json['category'],
      brand: json['brand'],
      image: json['image'],
    );
  }
}
