class Order {
  int id;
  int code;
  String status;
  List<OrderDetails> orderDetails;

  Order({
    required this.code,
    required this.id,
    required this.orderDetails,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      code: json['code'],
      id: json['id'],
      orderDetails:
          (json['order_details'] as List?)
              ?.map((e) => OrderDetails.fromJson(e))
              .toList() ??
          [],

      status: json['status'],
    );
  }
}

class OrderDetails {
  int id;
  int count;
  int price;
  int discountPrice;
  String product;
  String status;

  OrderDetails({
    required this.count,
    required this.discountPrice,
    required this.id,
    required this.price,
    required this.product,
    required this.status,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> element) {
    return OrderDetails(
      count: element['count'],
      discountPrice: element['discount_price'],
      id: element['id'],
      price: element['price'],
      product: element['product'],
      status: element['status'],
    );
  }
}
