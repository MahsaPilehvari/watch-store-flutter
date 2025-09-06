import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/utilities/http_response_validator.dart';
import 'package:watch_store/utilities/shared_preferences_constant.dart';
import 'package:watch_store/utilities/shared_preferences_manager.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()) {
    SharedPreferencesManager().getString(SharedPreferencesConstant.token) ==
            null
        ? emit(LoggedOutState())
        : emit(LoggedInState());
  }
  final Dio _dio = Dio();

  sendSms(String mobile) async {
    emit(LoadingState());

    try {
      await _dio.post(Endpoints.sendSms, data: {"mobile": mobile}).then((
        value,
      ) {
        debugPrint(value.toString());
        if (value.statusCode == 201) {
          emit(SentState(mobile: mobile));
        } else {
          emit(ErrorState(message: "Error in SendingSms"));
        }
      });
    } catch (e) {
      emit(ErrorState(message: "Error: $e"));
    }
  }

  verifyCode(String mobile, String code) async {
    emit(LoadingState());
    try {
      await _dio
          .post(Endpoints.checkSmsCode, data: {"mobile": mobile, "code": code})
          .then((value) {
            debugPrint(value.toString());

            HTTPResponseValidator.isValidStatusCode(value.statusCode ?? 0);
            SharedPreferencesManager().saveString(
              "token",
              value.data["data"]["token"],
            );
            if (value.data["data"]["is_registered"]) {
              emit(VerifiedRegisteredState());
            } else {
              emit(VerifiedNotRegisteredState());
            }
          });
    } catch (e) {
      emit(ErrorState(message: "Error in Verifying Code: $e"));
    }
  }
}
