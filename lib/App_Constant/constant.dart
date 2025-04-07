import 'package:expenso/Screens/Navigation/baseHomeScreen.dart';
import 'package:expenso/Screens/Navigation/homePage_Screen.dart';
import 'package:expenso/Screens/expense/addExpense_Screen.dart';
import 'package:flutter/cupertino.dart';

import '../Screens/auth/loginScreen.dart';
import '../Screens/auth/signupScreen.dart';
import '../Screens/intro_Screen.dart';
import '../Screens/splash_Screen.dart';
import '../data/Model/expCategoryModel.dart';

class AppConstant {
  static const String ISLOGIN = "is_login";
  static List<expCategoryModel> mcat = [
    expCategoryModel(
        id: 0,
        name: "Shopping",
        imgPath: "assets/images/ExpenseCat/shopping.jpg"),
    expCategoryModel(
        id: 1,
        name: "Bills",
        imgPath: "assets/images/ExpenseCat/Bills_Invoice.jpg"),
    expCategoryModel(
        id: 2,
        name: "Movies/Pvr",
        imgPath: "assets/images/ExpenseCat/Entertainment.jpg"),
    expCategoryModel(
        id: 3,
        name: "OutSide-Food",
        imgPath: "assets/images/ExpenseCat/Food_Dining.jpg"),
    expCategoryModel(
        id: 4, name: "Swiggy", imgPath: "assets/images/ExpenseCat/swiggy.jpg"),
    expCategoryModel(
        id: 5,
        name: "Delivery_Fuel",
        imgPath: "assets/images/ExpenseCat/swiggy_petrol.jpg"),
    expCategoryModel(
        id: 6,
        name: "Maintenance",
        imgPath: "assets/images/ExpenseCat/Transportation.png"),
    expCategoryModel(
        id: 7,
        name: "Bike Fuel",
        imgPath: "assets/images/ExpenseCat/Petrol.jpg"),
  ];
}

class AppRoutes {
  static const String ROUTE_SPLASH = "/";
  static const String ROUTE_INTRO = "/intro";
  static const String ROUTE_LOGIN = "/login";
  static const String ROUTE_SIGNUP = "/signup";
  static const String ROUTE_HOME = "/home";
  static const String ROUTE_BASEPAGE = "/basepage";
  static const String ROUTE_ADDEXPENSE = "/addNewExpense";

  static Map<String, WidgetBuilder> getRoutes() => {
        ROUTE_SPLASH: (context) => SplashScreen(),
        ROUTE_INTRO: (context) => IntroPage(),
        ROUTE_LOGIN: (context) => LoginPage(),
        ROUTE_SIGNUP: (context) => Signuppage(),
        ROUTE_HOME: (context) => HomePage(),
        ROUTE_BASEPAGE: (context) => BasePage(),
        ROUTE_ADDEXPENSE: (context) => AddNewExpense()
      };
}
