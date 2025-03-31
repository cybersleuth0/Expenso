import 'dart:async';
import 'package:expenso/App_Constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreen_State();
}

class SplashScreen_State extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      print("This is prefs: ${prefs.getInt(AppConstant.ISLOGIN)}");
      if (prefs.getInt(AppConstant.ISLOGIN) != null &&
          prefs.getInt(AppConstant.ISLOGIN) != 0) {
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_BASEPAGE);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Image(image: AssetImage("assets/images/splash_img3.jpg")),
    ));
  }
}
