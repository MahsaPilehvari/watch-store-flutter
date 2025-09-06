import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/order.dart';
import 'package:watch_store/data/model/user_address.dart';
import 'package:watch_store/data/model/profile.dart';
import 'package:watch_store/utilities/http_response_validator.dart';

abstract class IProfileDataSrc {
  Future<Profile> getProfileInfo();
  Future<List<UserAddress>> getUserAddresses();
  Future<List<Order>> getRecievedOrders();
  Future<List<Order>> getProcessingOrders();
  Future<List<Order>> getCanceledOrders();
}

class ProfileRemoteDataSrc implements IProfileDataSrc {
  Dio httpClient;

  ProfileRemoteDataSrc(this.httpClient);
  @override
  Future<List<Order>> getCanceledOrders() async {
    List<Order> orderList = [
      Order(
        id: 2,
        code: 1002,
        status: "لغو شده",
        orderDetails: [
          OrderDetails(
            id: 201,
            count: 3,
            price: 35000,
            discountPrice: 30000,
            product: "ساعت مچی عقربه ای مردانه سیتیزن",
            status: "لغو شده",
          ),
        ],
      ),
      Order(
        id: 2,
        code: 1002,
        status: "لغو شده",
        orderDetails: [
          OrderDetails(
            id: 201,
            count: 3,
            price: 35000,
            discountPrice: 30000,
            product: "ساعت مچی دیجیتال ورساچه ",
            status: "لغو  شده",
          ),
        ],
      ),
    ];
    final response = await httpClient.post(Endpoints.getCanceledOrders);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data['data'] as List) {
      orderList.add(Order.fromJson(element));
    }
    return orderList;
  }

  @override
  Future<List<Order>> getProcessingOrders() async {
    List<Order> orderList = [
      Order(
        id: 2,
        code: 1002,
        status: " سفارش در حال پردازش",
        orderDetails: [
          OrderDetails(
            id: 201,
            count: 3,
            price: 35000,
            discountPrice: 30000,
            product: "ساعت مچی عقربه ای مردانه سیتیزن",
            status: " سفارش در حال پردازش",
          ),
        ],
      ),
    ];
    final response = await httpClient.post(Endpoints.getProcessingOrders);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data['data'] as List) {
      orderList.add(Order.fromJson(element));
    }
    return orderList;
  }

  @override
  Future<Profile> getProfileInfo() async {
    final response = await httpClient.post(Endpoints.getProfileInfo);

    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

    return Profile.fromJson(response.data['data']);
  }

  @override
  Future<List<Order>> getRecievedOrders() async {
    List<Order> orderList = [
      Order(
        id: 1,
        code: 1001,
        status: "تحویل داده شده",
        orderDetails: [
          OrderDetails(
            id: 101,
            count: 2,
            price: 50000,
            discountPrice: 45000,
            product: "ساعت مچی عقربه ای سیکو",
            status: "تحویل داده شده",
          ),
          OrderDetails(
            id: 102,
            count: 1,
            price: 120000,
            discountPrice: 100000,
            product: "ساعت مچی دیجیتال کاسیو",
            status: "تحویل داده شده",
          ),
        ],
      ),
      Order(
        id: 3,
        code: 1003,
        status: "تحویل داده شده",
        orderDetails: [
          OrderDetails(
            id: 301,
            count: 1,
            price: 250000,
            discountPrice: 220000,
            product: "ساعت سیکو",
            status: "تحویل شده",
          ),
          OrderDetails(
            id: 302,
            count: 5,
            price: 5000,
            discountPrice: 4000,
            product: "ساعت اومکس",
            status: "تحویل شده",
          ),
        ],
      ),
    ];
    final response = await httpClient.post(Endpoints.getReceivedOrders);
    // print("response.data: ${response.data['data']}");
    // print("response.data: ${response.data['data']['order_details']}");
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data['data'] as List) {
      orderList.add(Order.fromJson(element));
    }
    // print(orderList);
    return orderList;
  }

  @override
  Future<List<UserAddress>> getUserAddresses() async {
    List<UserAddress> userAddressList = [
      UserAddress(
        id: 102,
        userId: 251,
        address: "تهران، خیابان هشتم ",
        postalCode: "145",
        createdAt: "createdAt",
        updatedAt: "updatedAt",
        lat: 145.2154,
        lng: 569.214,
      ),
      UserAddress(
        id: 102,
        userId: 251,
        address: "تهران، شریعتی ",
        postalCode: "145",
        createdAt: "createdAt",
        updatedAt: "updatedAt",
        lat: 145.2154,
        lng: 569.214,
      ),
      UserAddress(
        id: 102,
        userId: 251,
        address: "تهران، رسالت  ",
        postalCode: "145",
        createdAt: "createdAt",
        updatedAt: "updatedAt",
        lat: 145.2154,
        lng: 569.214,
      ),
    ];
    final response = await httpClient.post(Endpoints.getUserAddresses);
    HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
    for (var element in response.data['data'] as List) {
      userAddressList.add(UserAddress.fromJson(element));
    }
    return userAddressList;
  }
}

// Future<List<Order>> getRecievedOrders() async {
  //   List<Order> orderList = [ 
        
      
    
  //     ];
  //   try {
  //     final response = await httpClient.post(Endpoints.getReceivedOrders);
  //     print("API Endpoint: ${Endpoints.getReceivedOrders}");
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Raw Response Data: ${response.data}");

  //     HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);
  //     for (var element in response.data['data'] as List) {
  //       orderList.add(Order.fromJson(element));
  //     }
  //     print("Parsed Order List: $orderList");
  //     return orderList;
  //   } catch (e, stack) {
  //     print("Error in getRecievedOrders: $e");
  //     print("StackTrace: $stack");
  //     rethrow;
  //   }
  // }



// برای اینکه در صورت عدم وجود دیتا از سمت سرور، لیست سفارشات خالی نباشه و حداقل یه سری داده‌ی تستی داشته باشید،
// می‌تونید از یه لیست داده‌های تستی استفاده کنید. این کار به شما کمک می‌کنه تا در زمان توسعه و تست برنامه،
// UI رو بدون نیاز به اتصال به سرور بررسی کنید.

//   Future<List<Order>> getRecievedOrders() async {
//   final response = await httpClient.post(Endpoints.getReceivedOrders);
//   // print("response.data: ${response.data['data']}");

//   // اعتبارسنجی کد وضعیت HTTP
//   HTTPResponseValidator.isValidStatusCode(response.statusCode ?? 0);

//   // بررسی می‌کنیم که آیا دیتا از سمت سرور دریافت شده یا خیر
//   // اگر دیتا وجود نداشت، لیست تستی رو برمی‌گردونیم
//   if (response.data == null || response.data['data'] == null) {
//     return _getFakeOrderList();
//   }

//   // اگر دیتا وجود داشت، اون رو به مدل تبدیل می‌کنیم
//   List<Order> orderList = [];
//   for (var element in response.data['data'] as List) {
//     orderList.add(Order.fromJson(element));
//   }
  
//   // print(orderList);
//   return orderList;
// }

// // این متد لیست داده‌های تستی رو برمی‌گردونه
// List<Order> _getFakeOrderList() {
//   return [
//     Order(
//       id: 1,
//       code: 1001,
//       status: "پرداخت شده",
//       orderDetails: [
//         OrderDetails(
//           id: 101,
//           count: 2,
//           price: 50000,
//           discountPrice: 45000,
//           product: "کفش ورزشی",
//           status: "آماده ارسال",
//         ),
//         OrderDetails(
//           id: 102,
//           count: 1,
//           price: 120000,
//           discountPrice: 100000,
//           product: "ساعت هوشمند",
//           status: "در حال پردازش",
//         ),
//       ],
//     ),
//     Order(
//       id: 2,
//       code: 1002,
//       status: "در حال ارسال",
//       orderDetails: [
//         OrderDetails(
//           id: 201,
//           count: 3,
//           price: 35000,
//           discountPrice: 30000,
//           product: "تی‌شرت",
//           status: "ارسال شده",
//         ),
//       ],
//     ),
//     Order(
//       id: 3,
//       code: 1003,
//       status: "تحویل داده شده",
//       orderDetails: [
//         OrderDetails(
//           id: 301,
//           count: 1,
//           price: 250000,
//           discountPrice: 220000,
//           product: "لپ‌تاپ",
//           status: "تحویل شده",
//         ),
//         OrderDetails(
//           id: 302,
//           count: 5,
//           price: 5000,
//           discountPrice: 4000,
//           product: "خودکار",
//           status: "تحویل شده",
//         ),
//       ],
//     ),
//   ];
// }