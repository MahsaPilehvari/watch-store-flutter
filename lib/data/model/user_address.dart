class UserAddress {
  final int id;
  final int userId;
  final String address;
  final String postalCode;
  final String createdAt;
  final String updatedAt;
  final double lat;
  final double lng;

  UserAddress({
    required this.id,
    required this.userId,
    required this.address,
    required this.postalCode,
    required this.createdAt,
    required this.updatedAt,
    required this.lat,
    required this.lng,
  });
  factory UserAddress.fromJson(Map<String, dynamic> element) {
    return UserAddress(
      id: element["id"],
      userId: element["user_id"],
      address: element["address"],
      postalCode: element["postal_code"],
      createdAt: element["created_at"],
      updatedAt: element["updated_at"],
      lat: element["lat"],
      lng: element["lng"],
    );
  }
}
