import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Expenso",
                style: TextStyle(fontSize: 28, fontFamily: "Poppins")),
            // SizedBox(width: 50),
            Icon(
              Icons.search,
              size: 38,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //first row name and circile avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage("assets/images/boy_3d_image.jpg"),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Morning\n',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Poppins",
                            color: Colors.grey[400], // Light grey color
                          ),
                        ),
                        TextSpan(
                          text: 'Błaszczykowski',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Colors.black87, // Darker text for emphasis
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("This Month", style: TextStyle(fontFamily: "Poppins"))
                ],
              ),
              SizedBox(height: 15),
              //Expense Total box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Color(0xff7b88ff),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expense Total",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "\$3,722",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color(0xffdd6565),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text('+\$240',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(width: 5),
                              Text('than last month',
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      fontFamily: "Poppins")),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Transform.scale(
                      alignment: Alignment.center,
                      scale: 1.9,
                      child: Image(
                          image: AssetImage("assets/images/home_image.png")),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text("Expense List",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins")),
              SizedBox(height: 15),
              //Expense List
              Column(
                children: [
                  expenseList(),
                  expenseList(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseList() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        children: [
          //First row of the list day and total amt
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Tuesday, 14",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(width: 50),
              const Text("-\$100",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.grey,
            height: 2,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/splash_img.jpg"),
                  ),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Shop\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontFamily: "Poppins",
                          ),
                        ),
                        TextSpan(
                          text: 'Błaszczykowski',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Text(
                    "\$90",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: "Poppins",
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
