class Profile {
  final UserInfo userInfo;
  final int userProcessingCount;
  final int userReceivedCount;
  final int userCanceledCount;

  Profile({
    required this.userCanceledCount,
    required this.userInfo,
    required this.userProcessingCount,
    required this.userReceivedCount,
  });

  factory Profile.fromJson(Map<String, dynamic>? element) {
    return Profile(
      userCanceledCount: element?['user_cancel_count'] ?? 0,
      userProcessingCount: element?['user_processing_count'] ?? 0,
      userReceivedCount: element?['user_received_count'] ?? 0,
      userInfo: UserInfo.fromJson(
        element?['user_info'] as Map<String, dynamic>,
      ),
    );
  }
}

class UserInfo {
  final String id;
  final String name;
  final String mobile;
  final String phone;
  final Address address;

  UserInfo({
    required this.address,
    required this.id,
    required this.name,
    required this.mobile,
    required this.phone,
  });

  factory UserInfo.fromJson(Map<String, dynamic>? element) {
    return UserInfo(
      id: element?['id']?.toString() ?? '',
      name: element?['name']?.toString() ?? '  نام کاربر نامشخص',
      mobile: element?['mobile']?.toString() ?? 'شماره وارد نشده',
      phone: element?['phone']?.toString() ?? 'تلفن وارد نشده',
      address: Address.fromJson(element?["address"] as Map<String, dynamic>),
    );
  }
}

class Address {
  final String address;
  final String postalCode;
  final double lat;
  final double lng;

  Address({
    required this.address,
    required this.postalCode,
    required this.lat,
    required this.lng,
  });

  factory Address.fromJson(Map<String, dynamic>? element) {
    return Address(
      address: element?["address"] ?? "آدرس ثبت نشده",
      postalCode: element?["postal_code"] ?? "کدپستی ثبت نشده",
      lat: (element?["lat"] as num).toDouble(),
      lng: (element?["lng"] as num).toDouble(),
    );
  }
}
