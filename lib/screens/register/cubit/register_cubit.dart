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
}
