
import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/create_recipe_page.dart';
import 'package:recipe_app/presentations/screens/add_screen.dart';
import 'package:recipe_app/presentations/screens/auth_screen.dart';
import 'package:recipe_app/presentations/screens/fav_screen.dart';
import 'package:recipe_app/presentations/screens/forget_password.dart';
import 'package:recipe_app/presentations/screens/home_screen.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/pages/onboarding_page.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/screens/search_screen.dart';
import 'package:recipe_app/presentations/screens/sigin_screen.dart';

class AppRoute {
  Route? ongenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MainScreen.routeName:
        return MaterialPageRoute(builder: (context) => MainScreen());
      case OnBoardpage.routeName:
        return MaterialPageRoute(builder: (context) => OnBoardpage());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (context) => SignInScreen());
      case AuthScreen.routeName:
        return MaterialPageRoute(builder: (context) => AuthScreen());
      case ForgetpasswordScreen.routeName:
        return MaterialPageRoute(builder: (context) => ForgetpasswordScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case SearchScreen.routeName:
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case AddScreen.routeName:
        return MaterialPageRoute(builder: (context) => AddScreen());
      case FavScreen.routeName:
        return MaterialPageRoute(builder: (context) => FavScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case CreateRecipePage.routeName:
        return MaterialPageRoute(builder: (context) => CreateRecipePage());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                    child: Text(
                      'Invalid Route ',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ));
    }
  }
}
