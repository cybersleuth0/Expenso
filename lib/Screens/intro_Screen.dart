import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Expenso",
          style: TextStyle(fontFamily: "Poppins"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 150),
              Image(image: AssetImage("assets/images/splash_img.jpg")),
              SizedBox(height: 50),
              Text("Easy way to monitor \nyour expense",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Poppins"))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.pushReplacementNamed(context, "/login");
        },
        child: Icon(
          Icons.arrow_right_alt_outlined,
          size: 38,
          color: Colors.white,
        ),
      ),
    );
  }
}