import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/components/text_style.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/Authentication/cubit/authentication_cubit.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/utilities/format_time.dart';
import 'package:watch_store/widgets/main_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  late Timer _timer;
  int _start = 120;

  startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _timer.cancel();
          Navigator.of(context).pop();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mobileArgument = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.png.mainLogo.path),
                  Dimensions.large.height,
                  Text(
                    AppStrings.otpCodeSendFor.replaceAll(
                      AppStrings.replace,
                      mobileArgument,
                    ),
                    style: LightAppTextStyle.title,
                  ),
                  Dimensions.small.height,
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      AppStrings.wrongNumberEditNumber,
                      style: LightAppTextStyle.primaryTheme,
                    ),
                  ),
                  Dimensions.large.height,
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '   وارد کردن کد فعالسازی الزامی است';
                      } else if (value.length != 4) {
                        return 'کد فعالسازی باید 4 رقمی باشد';
                      }
                      return null;
                    },

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    lable: AppStrings.enterVerificationCode,
                    prefixLable: formatTime(_start),
                    hint: AppStrings.hintVerificationCode,
                    controller: _controller,
                  ),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      _timer.cancel();
                      if (state is VerifiedNotRegisteredState) {
                        Navigator.pushNamed(
                          context,
                          ScreenNames.registerScreen,
                        );
                      } else if (state is VerifiedRegisteredState) {
                        Navigator.pushNamed(context, ScreenNames.mainScreen);
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.amberAccent,
                            content: Text("  کدفعالسازی موردتایید نیست!  "),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return CircularProgressIndicator();
                      } else {
                        return MainButtton(
                          text: AppStrings.next,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationCubit>(
                                context,
                              ).verifyCode(mobileArgument, _controller.text);
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
