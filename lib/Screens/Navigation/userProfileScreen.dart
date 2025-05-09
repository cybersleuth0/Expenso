import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../App_Constant/constant.dart';

class profileScreenPage extends StatefulWidget {
  @override
  State<profileScreenPage> createState() => profileScreenPage_State();
}

class profileScreenPage_State extends State<profileScreenPage> {
  var userName;

  @override
  void initState() {
    super.initState();
    getUsername().then((value) {
      setState(() {
        userName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(
              "assets/images/boy_3d_image.jpg"), // Use your asset path
        ),
        SizedBox(height: 10),
        Text('$userName',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text("ayush@example.com", style: TextStyle(color: Colors.grey)),
        SizedBox(height: 30),
        ListTile(
          leading: Icon(Icons.account_balance_wallet_outlined),
          title: Text("Budget Settings"),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        ListTile(
          leading: Icon(Icons.lock_outline),
          title: Text("Privacy & Security"),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
        ),
        InkWell(
          onTap: () async {
            var prefs = await SharedPreferences.getInstance();
            prefs.remove(AppConstant.ISLOGIN);
            Navigator.pushReplacementNamed(context, AppRoutes.ROUTE_LOGIN);
          },
          child: ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ),
      ],
    ));
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstant.CRTUSERNAME) ?? "";
  }
}
