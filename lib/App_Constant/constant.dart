import 'package:expenso/Screens/Navigation/baseHomeScreen.dart';
import 'package:expenso/Screens/Navigation/homePage_Screen.dart';
import 'package:flutter/cupertino.dart';

import '../Screens/auth/loginScreen.dart';
import '../Screens/auth/signupScreen.dart';
import '../Screens/intro_Screen.dart';
import '../Screens/splash_Screen.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = "/";
  static const String ROUTE_INTRO = "/intro";
  static const String ROUTE_LOGIN = "/login";
  static const String ROUTE_SIGNUP = "/signup";
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_BASEPAGE = "/basepage";

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => SplashScreen(),
        ROUTE_INTRO: (context) => IntroPage(),
        ROUTE_LOGIN: (context) => LoginPage(),
        ROUTE_SIGNUP: (context) => Signuppage(),
        ROUTE_HOME: (context) => HomePage(),
        ROUTE_BASEPAGE: (context) => BasePage(),
      };
}
