// ignore_for_file: file_names, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:recipe_app/presentations/pages/create_recipe_page.dart';
import 'package:recipe_app/presentations/pages/discover_page.dart';
import 'package:recipe_app/presentations/pages/edit_profile_page.dart';
import 'package:recipe_app/presentations/pages/following_page.dart';
import 'package:recipe_app/presentations/pages/other_user_profile.dart';
import 'package:recipe_app/presentations/pages/popular_recipes_page.dart';
import 'package:recipe_app/presentations/pages/recipe_individual_page.dart';
import 'package:recipe_app/presentations/pages/today_recipe_page.dart';
import 'package:recipe_app/presentations/pages/uploaded_recipe_page.dart';
import 'package:recipe_app/presentations/screens/add_screen.dart';
import 'package:recipe_app/presentations/screens/auth_screen.dart';
import 'package:recipe_app/presentations/screens/forget_password.dart';
import 'package:recipe_app/presentations/screens/home_screen.dart';
import 'package:recipe_app/presentations/screens/login_screen.dart';
import 'package:recipe_app/presentations/pages/onboarding_page.dart';
import 'package:recipe_app/presentations/screens/main_screen.dart';
import 'package:recipe_app/presentations/screens/profile_screen.dart';
import 'package:recipe_app/presentations/screens/search_recipe_screen.dart';
import 'package:recipe_app/presentations/screens/search_user_screen.dart';
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

      case AddScreen.routeName:
        return MaterialPageRoute(builder: (context) => AddScreen());
      case PopularRecipesPage.routeName:
        return MaterialPageRoute(builder: (context) => PopularRecipesPage());
      case TodayRecipePage.routeName:
        return MaterialPageRoute(builder: (context) => TodayRecipePage());
      case UploadedRecipePage.routeName:
        return MaterialPageRoute(builder: (context) => UploadedRecipePage());
      case SearchUserScreen.routeName:
        return MaterialPageRoute(builder: (context) => SearchUserScreen());
      case FollowingPage.routeName:
        return MaterialPageRoute(builder: (context) => FollowingPage());
      case SearchRecipeScreen.routeName:
        return MaterialPageRoute(builder: (context) => SearchRecipeScreen());
      case OtherUserProfilePage.routeName:
        return MaterialPageRoute(builder: (context) {
          final OtherUserProfilePage? otherUserProfilePage =
              routeSettings.arguments as OtherUserProfilePage;
          return OtherUserProfilePage(
            name: otherUserProfilePage!.name,
            email: otherUserProfilePage.email,
            image: otherUserProfilePage.image,
            followers: otherUserProfilePage.followers,
            following: otherUserProfilePage.following,
            about: otherUserProfilePage.about,
          );
        });

      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case CreateRecipePage.routeName:
        return MaterialPageRoute(builder: (context) => CreateRecipePage());
      case DiscoverPage.routeName:
        return MaterialPageRoute(builder: (context) => DiscoverPage());
      case IndividualPage.routeName:
        return MaterialPageRoute(builder: (context) {
          final IndividualPage? individual =
              routeSettings.arguments as IndividualPage?;
          return IndividualPage(
              des: individual!.des,
              name: individual.name,
              time: individual.time,
              image: individual.image,
              ingr: individual.ingr,
              step: individual.step,
              title: individual.title);
        });
      case EditProfilePage.routeName:
        return MaterialPageRoute(builder: (context) {
          final EditProfilePage? arg =
              routeSettings.arguments as EditProfilePage?;
          EditProfilePage argument;
          return EditProfilePage(
            ss: arg!.ss,
            email: arg.email,
            about: arg.about,
          );
        });
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
