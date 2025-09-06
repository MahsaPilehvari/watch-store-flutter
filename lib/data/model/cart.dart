class UserCart {
  int id;
  int productId;
  String product;
  int count;
  int price;
  int discount;
  int discountPrice;
  String image;
  UserCart({
    required this.id,
    required this.productId,
    required this.product,
    required this.count,
    required this.discount,
    required this.price,
    required this.discountPrice,
    required this.image,
  });

  factory UserCart.fromJson(Map<String, dynamic> json) {
    return UserCart(
      id: json['id'],
      productId: json['product_id'],
      product: json['product'],
      count: json['count'],
      price: json['price'],
      discount: json['discount'],
      discountPrice: json['discount_price'],
      image: json['image'],
    );
  }
}

class Cart {
  List<UserCart>? userCart;
  int totalWithoutDiscountPrice;
  int cartTotalPrice;

  Cart({
    required this.cartTotalPrice,
    required this.totalWithoutDiscountPrice,
    required this.userCart,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartTotalPrice: json["cart_total_price"],
      totalWithoutDiscountPrice: json["total_without_discount_price"],
      userCart:
          (json["user_cart"] as List?)
              ?.map((e) => UserCart.fromJson(e))
              .toList() ??
          [],
    );
  }
}
