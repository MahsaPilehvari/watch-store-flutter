import 'package:dio/dio.dart';
import 'package:watch_store/utilities/shared_preferences_constant.dart';
import 'package:watch_store/utilities/shared_preferences_manager.dart';

// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     String? token = SharedPreferencesManager().getString(
//       SharedPreferencesConstant.token,
//     );
//     if (token != null) {
//       options.headers["Authorization"] = "Bearer $token";
//     }
//     super.onRequest(options, handler);
//   }
// }

// class DioManager {
//   static final Dio _dio = Dio();
//   static Dio get dio {
//     _dio.interceptors.add(AuthInterceptor());
//     return _dio;
//   }
// }
// import 'package:dio/dio.dart';
// import 'package:watch_store/constants/shared_preferences_constant.dart';
// import 'package:watch_store/services/shared_preferences_manager.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = SharedPreferencesManager().getString(
      SharedPreferencesConstant.token,
    );

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
      print("🔐 Token added to request: $token");
    } else {
      print("⚠️ No token found in shared preferences");
    }

    super.onRequest(options, handler);
  }
}

class DioManager {
  static final Dio _dio =
      Dio()..interceptors.add(AuthInterceptor()); // فقط یک بار اضافه می‌شه

  static Dio get dio => _dio;
}
