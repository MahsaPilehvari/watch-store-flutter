import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_store/components/extensions.dart';
import 'package:watch_store/data/model/registery_data.dart';
import 'package:watch_store/resources/dimensions.dart';
import 'package:watch_store/resources/strings.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/Authentication/cubit/authentication_cubit.dart';
import 'package:watch_store/screens/register/cubit/register_cubit.dart';
import 'package:watch_store/screens/register/cubit/register_state.dart';
import 'package:watch_store/utilities/image_handler.dart';
import 'package:watch_store/widgets/app_text_field.dart';
import 'package:watch_store/widgets/avatar.dart';
import 'package:watch_store/widgets/main_button.dart';
import 'package:watch_store/widgets/register_screen_appBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double lat = 0.0;
  double lng = 0.0;

  ImageHandler imageHandler = ImageHandler();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: RegisterScreenAppBar(size: size),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Center(
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisteredState) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        ScreenNames.mainScreen,
                        (route) => false,
                      );
                    } else if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.deepOrangeAccent,
                          content: Text(state.message),
                        ),
                      );
                    }
                    if (state is PickedLocationState) {
                      if (state.location != null) {
                        _locationController.text =
                            '${state.location!.latitude} - ${state.location!.longitude}';
                        lat = state.location!.latitude;
                        lng = state.location!.longitude;
                      }
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Dimensions.large.height,
                        Avatar(
                          onTap:
                              () async => await imageHandler
                                  .pickAndCropImage(source: ImageSource.gallery)
                                  .then((value) => setState(() {})),
                          file: imageHandler.getImage,
                          text: AppStrings.chooseProfileImage,
                        ),
                        Dimensions.medium.height,
                        AppTextField(
                          lable: AppStrings.nameLastName,
                          hint: AppStrings.hintNameLastName,
                          controller: _fullNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا نام و نام خانوادگی را وارد کنید';
                            }
                            return null;
                          },
                          inputType: TextInputType.name,
                        ),
                        AppTextField(
                          lable: AppStrings.homeNumber,
                          hint: AppStrings.hintHomeNumber,
                          controller: _phoneController,
                          inputType: TextInputType.phone,
                          validator: (value) {
                            if (value!.length < 11) {
                              return 'لطفا تلفن ثابت را وارد کنید';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                        AppTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'لطفا آدرس را وارد کنید';
                            }
                            return null;
                          },
                          lable: AppStrings.address,
                          hint: AppStrings.hintAddress,
                          controller: _addressController,
                        ),
                        AppTextField(
                          inputType: TextInputType.number,
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'لطفا کد پستی را وارد کنید';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          lable: AppStrings.postalCode,
                          hint: AppStrings.hintPostalCode,
                          controller: _postalCodeController,
                        ),
                        GestureDetector(
                          onTap: () async {
                            BlocProvider.of<RegisterCubit>(
                              context,
                            ).pickTheLocation(context: context);
                          },
                          child: AppTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'لطفا موقعیت مکانی را انتخاب کنید';
                              }
                              return null;
                            },
                            lable: AppStrings.location,
                            hint: AppStrings.hintLocation,
                            icon: Icon(Icons.place_outlined),
                            controller: _locationController,
                          ),
                        ),
                        Dimensions.medium.height,
                        if (state is LoadingState)
                          Center(child: CircularProgressIndicator())
                        else
                          MainButtton(
                            text: AppStrings.register,
                            onPressed: () async {
                              MultipartFile? imageFile;
                              if (imageHandler.getImage != null) {
                                imageFile = await MultipartFile.fromFile(
                                  imageHandler.getImage!.path,
                                );
                              }
                              if (_formKey.currentState!.validate()) {
                                RegisteryData userData = RegisteryData(
                                  name: _fullNameController.text,
                                  phone: _phoneController.text,
                                  postalCode: _postalCodeController.text,
                                  address: _addressController.text,
                                  lat: lat,
                                  lng: lng,
                                  image: imageFile,
                                );
                                BlocProvider.of<RegisterCubit>(
                                  // ignore: use_build_context_synchronously
                                  context,
                                ).register(userData: userData);
                              }
                            },
                          ),
                        Dimensions.large.height,
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
