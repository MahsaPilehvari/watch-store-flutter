import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/registery_data.dart';
import 'package:watch_store/screens/register/cubit/register_state.dart';
import 'package:watch_store/utilities/shared_preferences_constant.dart';
import 'package:watch_store/utilities/shared_preferences_manager.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final Dio _dio = Dio();

  pickTheLocation({required context}) async {
    final value = await showSimplePickerLocation(
      isDismissible: true,
      title: "انتخاب موقعیت مکانی",
      textCancelPicker: "لغو",
      textConfirmPicker: "انتخاب",
      zoomOption: ZoomOption(initZoom: 8),
      initCurrentUserPosition: UserTrackingOption.withoutUserPosition(),
      // initPosition:GeoPoint(latitude: 4.748, longitude: 8032)
      radius: 8,
      context: context,
    );
    if (value != null) {
      emit(PickedLocationState(location: value));
    }
  }

  register({required RegisteryData userData}) async {
    emit(RegisterLoadingState());
    try {
      String? token = SharedPreferencesManager().getString(
        SharedPreferencesConstant.token,
      );
      // debugPrint("****after press registeration button: $token");
      _dio.options.headers['Authorization'] = "Bearer $token";
      await _dio
          .post(Endpoints.register, data: FormData.fromMap(userData.toMap()))
          .then((value) {
            if (value.statusCode == 201) {
              emit(RegisteredState());
            } else {
              emit(
                RegisterErrorState(
                  message:
                      "Server returned a non-201 status code: ${value.statusCode}",
                ),
              );
            }
          });
    } catch (e) {
      emit(RegisterErrorState(message: "Registration failed with error: $e"));
    }
  }

  // register({required UserRegistery userRegistery}) async {
  //   emit(RegisterLoadingState());
  //   try {
  //     String? token = SharedPreferencesManager().getString(
  //       SharedPreferencesConstant.token,
  //     );

  //     debugPrint("****after press registration button: Token = $token");

  //     _dio.options.headers['Authorization'] = "Bearer $token";

  //     final requestData = userRegistery.toMap();
  //     debugPrint("****Data to be sent: $requestData");

  //     final response = await _dio.post(
  //       Endpoints.register,
  //       data: FormData.fromMap(requestData),
  //     );

  //     debugPrint("****Server Response: ${response.data}");
  //     if (response.statusCode == 201) {
  //       debugPrint("****Attempting to emit OkResponseState");
  //       emit(OkResponseState());
  //       debugPrint("****ٌWhy do not navigate to the mainScreen!!!!!");
  //     } else {
  //       emit(
  //         RegisterErrorState(
  //           message:
  //               "Server returned a non-201 status code: ${response.statusCode}",
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     String errorMessage;
  //     if (e.response != null) {
  //       errorMessage =
  //           "Server Error: ${e.response!.statusCode} - ${e.response!.statusMessage}";
  //       debugPrint("Server error details: ${e.response!.data}");
  //     } else {
  //       errorMessage = "Network Error: Please check your internet connection.";
  //       debugPrint("Network error details: $e");
  //     }
  //     emit(RegisterErrorState(message: errorMessage));
  //   } catch (e) {
  //     emit(RegisterErrorState(message: "An unexpected error occurred: $e"));
  //   }
  // }
}
