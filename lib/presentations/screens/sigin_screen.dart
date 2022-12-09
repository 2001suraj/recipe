// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/login/login_bloc.dart';
import 'package:recipe_app/data/local/local_storage.dart';
import 'package:recipe_app/data/repo/cloud_storage.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/widgets/cus_title.dart';
import 'package:recipe_app/presentations/widgets/custom_btn.dart';
import 'package:recipe_app/presentations/widgets/custom_text_field.dart';
import 'package:recipe_app/presentations/widgets/normal_text_field.dart';
import 'package:recipe_app/presentations/widgets/show__snackbar.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = 'signin screen';
  SignInScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Spacer(),
                CustomTitle(
                  text: 'Sign Up',
                ),
                Spacer(),
                NormalTextField(
                  controller: name,
                  text: '@username',
                ),
                SizedBox(
                  height: 27,
                ),
                NormalTextField(
                  controller: email,
                  text: 'Your E-mail',
                ),
                SizedBox(
                  height: 27,
                ),
                CustomTextField(password: password),
                SizedBox(
                  height: 37,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'By signing up you agree to our Terms of use and Piracy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                Spacer(),
                BlocListener<LoginBloc, LoginState>(listener: (context, state) {
                  if (state is LoginsuccessState) {
                    Navigator.pushReplacementNamed(
                        context, MainScreen.routeName);
                  } else if (state is LoginfailureState) {
                    showsnackBar(
                        context: context,
                        text: state.message,
                        color: Colors.red);
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
                    if (name.text.isNotEmpty &&
                        email.text.isNotEmpty &&
                        password.text.isNotEmpty) {
                      context.read<LoginBloc>().add(SignUpAddEvent(
                          email: email.text, password: password.text));
                      LocalStorage().writedata(name: email.text);
                      CloudStorages().userinfo(
                          name: name.text, email: email.text, about: '');
                    } else {
                      showsnackBar(
                          context: context,
                          text: 'field is emply.',
                          color: Colors.orange);
                    }
                  },
                  text: 'Sign Up',
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: Text(
                          'Log In',
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
        ),
      ),
    );
  }
}
