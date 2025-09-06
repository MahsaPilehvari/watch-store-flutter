import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/theme_data.dart';
import 'package:watch_store/data/config/remote_config.dart';
import 'package:watch_store/data/repository/cart_repo.dart';
import 'package:watch_store/data/repository/product_repo.dart';
import 'package:watch_store/data/repository/profile_repo.dart';
import 'package:watch_store/data/src/profile_data_src.dart';
import 'package:watch_store/routes/routes.dart';
import 'package:watch_store/screens/Authentication/cubit/authentication_cubit.dart';
import 'package:watch_store/screens/Authentication/send_sms_screen.dart';
import 'package:watch_store/screens/product_list/bloc/productlist_bloc.dart';
import 'package:watch_store/screens/register/cubit/register_cubit.dart';
import 'package:watch_store/screens/shopping_cart/bloc/cart_bloc.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/screens/profile/bloc/profile_bloc.dart';
import 'package:watch_store/utilities/shared_preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ProductListBloc(productRepository)),
        BlocProvider(create: (context) => CartBloc(cartRepository)),
        BlocProvider(
          create:
              (context) => ProfileBloc(
                ProfileRepository(ProfileRemoteDataSrc(DioManager.dio)),
              )..add(ProfileInitEvent()),
        ),
      ],
      child: MaterialApp(
        locale: Locale("fa"),
        debugShowCheckedModeBanner: false,
        title: 'Watch Store',
        // theme: AppTheme.lightTheme,
        theme: lightTheme(),
        // initialRoute: ScreenNames.root,
        routes: routes,
        home:
        // MainScreen(),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return MainScreen();
            } else if (state is LoggedOutState) {
              return SendSmsScreen();
            } else {
              return SendSmsScreen();
            }
          },
        ),
      ),
    );
  }
}
