// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/business_logic/forget_password/forgetpassword_bloc.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/widgets/custom_btn.dart';
import 'package:recipe_app/presentations/widgets/normal_text_field.dart';
import 'package:recipe_app/presentations/widgets/show__snackbar.dart';

class ForgetpasswordScreen extends StatelessWidget {
  static const String routeName = 'forget password screen';
  ForgetpasswordScreen({Key? key}) : super(key: key);
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 30,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  )),
            ),
            Spacer(),
            Text(
              'Forget Password ? ',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
              child: Text(
                'Please enter your registered email address. An email natification with a password reset link will then be sent to you.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            NormalTextField(controller: email, text: 'Your E-mail'),
            Spacer(),
            BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
              builder: (context, state) {
                if (state is ForgetfailureInitial) {
                  return Text(
                    'intial',
                    style: TextStyle(color: Colors.white),
                  );
                } else if (state is ForgetloadingInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                } else if (state is ForgetsuccessInitial) {
                  return Text(
                    'data',
                    style: TextStyle(color: Colors.white),
                  );
                } else if (state is ForgetfailureInitial) {
                  return Text(state.message);
                }
                return Text(
                  'error',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
            CustomBtn(
              tap: () {
                context
                    .read<ForgetpasswordBloc>()
                    .add(ForgetAddEvent(email: email.text.trim()));
                showsnackBar(
                    context: context,
                    text: 'Password reset line is sent to your email',
                    color: Colors.green);
              },
              text: 'Send Email',
              color: Colors.white70,
              textcolor: Colors.black,
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
