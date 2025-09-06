import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/gen/assets.gen.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/Authentication/cubit/authentication_cubit.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/main_button.dart';

class SendSmsScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SendSmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(Assets.png.mainLogo.path),
                  (Dimensions.large * 2).height,
                  AppTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'شماره موبایل الزامی است';
                      } else if (value.length != 11) {
                        return 'شماره موبایل باید 11 رقم باشد';
                      } else if (!value.startsWith('09')) {
                        return 'شماره باید با 09 شروع شود';
                      }
                      return null;
                    },

                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    lable: AppStrings.enterYourNumber,
                    hint: AppStrings.hintPhoneNumber,
                    controller: _controller,
                  ),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is SentState) {
                        Navigator.pushNamed(
                          context,
                          ScreenNames.verifyCodeScreen,
                          arguments: state.mobile,
                        );
                      } else if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.amberAccent,
                            content: Text("خطا در ارسال کد فعالسازی"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return MainButtton(
                          text: AppStrings.sendOtpCode,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationCubit>(
                                context,
                              ).sendSms(_controller.text);
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
