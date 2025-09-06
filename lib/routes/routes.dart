import 'package:flutter/widgets.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/Authentication/verify_code_screen.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/screens/register/register_screen.dart';
import 'package:watch_store/screens/Authentication/send_sms_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.sendSmsScreens: (context) => SendSmsScreen(),
  ScreenNames.verifyCodeScreen: (context) => VerifyCodeScreen(),
  ScreenNames.registerScreen: (context) => RegisterScreen(),
  ScreenNames.mainScreen: (context) => MainScreen(),
};
