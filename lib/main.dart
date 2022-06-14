import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/home_layout.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/modules/onboarding_screen.dart';
import 'package:shopapp/modules/register_screen.dart';
import 'package:shopapp/utilities/cubit/shop/cubit.dart';
import 'package:shopapp/utilities/network/local/cach_helper.dart';
import 'package:shopapp/utilities/network/remote/dio_helper.dart';
import 'package:shopapp/utilities/shared/bloc_observer.dart';
import 'package:shopapp/utilities/shared/theme.dart';
import 'package:shopapp/utilities/shared/variables.dart';

void main(List<String> args) {
  late Widget widget;

  WidgetsFlutterBinding.ensureInitialized();
  late bool? onBoarding;
  CachHelper.init().then(
    (value) async {
      CachHelper.loadData('token').then((value) {
        userToken = value;
        print(value);
      });
      onBoarding = await CachHelper.loadData('onBoarding');

      if (onBoarding != null) {
        if (userToken != null) {
          widget = const HomeLayout();
        } else {
          widget = const LoginScreen();
        }
      } else {
        widget = const OnBoardingScreen();
      }
    },
  ).then(
    (value) => BlocOverrides.runZoned(
      () {
        runApp(MyApp(widget));
      },
      blocObserver: MyBlocObserver(),
    ),
  );
  DioHelper.init();
}

class MyApp extends StatelessWidget {
  final Widget startingPage;
  const MyApp(this.startingPage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return ShopCubit();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
<<<<<<< HEAD
        // home: startingPage,
        home: const RegisterScreen(),
=======
        home: startingPage,

>>>>>>> 8add71c255b8ee60dcdf011b89d7b58af5cfda1a
      ),
    );
  }
}
