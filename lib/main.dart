// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/forget_password/forgetpassword_bloc.dart';
import 'package:recipe_app/business_logic/login/login_bloc.dart';
import 'package:recipe_app/business_logic/logout/logout_bloc.dart';
import 'package:recipe_app/data/repo/user_repo.dart';
import 'package:recipe_app/presentations/pages/onboarding_page.dart';
import 'package:recipe_app/presentations/routes/app-route.dart';
import 'package:recipe_app/presentations/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'business_logic/auth/auth_bloc.dart';

int? initialScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  initialScreen =  sharedPreferences.getInt('initialScreen');
  await sharedPreferences.setInt('initialScreen', 1);
  runApp(MyApp(
    appRoute: AppRoute(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.appRoute}) : super(key: key);
  AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(UserRepo())..add(AuthAddEvent()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(UserRepo()),
        ),
        BlocProvider(
          create: (context) => ForgetpasswordBloc(UserRepo())
        ),
        BlocProvider(
          create: (context) => LogoutBloc(UserRepo())
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white)),
        ),
        initialRoute: initialScreen == 0 || initialScreen == null
            ? OnBoardpage.routeName
            : AuthScreen.routeName,
        onGenerateRoute: appRoute.ongenerateRoute,
      ),
    );
  }
}
