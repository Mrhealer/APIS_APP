import 'package:apis_app/ui/auth/login_screen.dart';
import 'package:apis_app/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

import '404.dart';

class RouterGenerator {
  //* Routing list
  static const routeHome = "/home";
  static const routeLoginScreen = "/login";
  static const routeSignUpScreen = "/sign";
  static const routeAuthScreen = "/auth";

  static Route<dynamic> generateRouter(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  title: "Home",
                ));
        break;
      case routeLoginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      default:
        {
          return MaterialPageRoute(builder: (_) => WidgetNotFound());
        }
        break;
    }
  }
}
