// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/presentations/screens/forget_password.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/screens/sigin_screen.dart';
import 'package:recipe_app/presentations/widgets/cus_title.dart';
import 'package:recipe_app/presentations/widgets/custom_btn.dart';
import 'package:recipe_app/presentations/widgets/custom_text_field.dart';
import 'package:recipe_app/presentations/widgets/normal_text_field.dart';
import 'package:recipe_app/presentations/widgets/show__snackbar.dart';

import '../../business_logic/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login page';
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            CustomTitle(
              text: 'Log In',
            ),
            Spacer(),
            NormalTextField(
              controller: email,
              text: 'Your E-mail',
            ),
            SizedBox(
              height: 27,
            ),
            CustomTextField(password: password),
            SizedBox(
              height: 27,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, ForgetpasswordScreen.routeName);
                },
                child: Text(
                  'Forget Password ?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Spacer(),
            BlocListener<LoginBloc, LoginState>(listener: (context, state) {
              if (state is LoginsuccessState) {
                Navigator.pushReplacementNamed(context, MainScreen.routeName);
              } else if (state is LoginfailureState) {
                showsnackBar(
                    context: context, text: state.message, color: Colors.red);
              }
            }, child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginInitialState) {
                  return Container();
                } else if (state is LoginloadindState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (state is LoginsuccessState) {
                  return Container();
                } else if (state is LoginfailureState) {
                  return Container();
                }
                return Text('some error');
              },
            )),
            SizedBox(
              height: 20,
            ),
            CustomBtn(
                  color: Colors.orange,
                  textcolor: Colors.white,
              tap: () {
                context.read<LoginBloc>().add(
                    LoginAddEvent(email: email.text, password: password.text));
                    LocalStorage().writedata(name: email.text);

              },
              text: 'Log In',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ))
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
