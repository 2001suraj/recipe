import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/auth/auth_bloc.dart';
import 'package:recipe_app/presentations/pages/onboarding_page.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = 'auth screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitialState) {
            return OnBoardpage();
          } else if (state is AuthloadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthsuccessState) {
            return MainScreen();
          } else if (state is AuthfailureState) {
            return LoginScreen();
          }
          return Container();
        },
      ),
    );
  }
}
