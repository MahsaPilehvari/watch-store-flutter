import 'dart:convert';

class RegisteryData {
  final String name;
  final String phone;
  final String address;
  final String postalCode;
  final dynamic image;
  final double? lat;
  final double? lng;

  RegisteryData({
    required this.name,
    required this.phone,
    required this.postalCode,
    required this.address,
    required this.lat,
    required this.lng,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["name"] = name;
    map["phone"] = phone;
    map["address"] = address;
    map["postal_code"] = postalCode;
    map["image"] = image;
    map["lat"] = lat;
    map["lng"] = lng;

    return map;
  }

  factory RegisteryData.fromJson(String? jsonString) {
    Map<String, dynamic> map = jsonDecode(jsonString!);
    return RegisteryData(
      name: map['name'],
      phone: map['phone'],
      postalCode: map['postalCode'],
      address: map['address'],
      lat: map['lat'],
      lng: map['lng'],
      image: map['image'],
    );
  }
}
