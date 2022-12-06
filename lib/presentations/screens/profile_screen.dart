import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/logout/logout_bloc.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = 'ProfileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LogoutBloc>().add(logoutAddEvent());
              LocalStorage().clear();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is Logoutsuccess) {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }
        },
        child: Container(),
      ),
    );
  }
}
