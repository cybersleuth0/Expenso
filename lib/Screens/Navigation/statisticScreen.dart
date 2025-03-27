import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Statistic",
                style: TextStyle(fontSize: 28, fontFamily: "Poppins")),
            // SizedBox(width: 50),
            Text("This Month", style: TextStyle(fontFamily: "Poppins")),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Expense Total",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              Expanded(child: Icon(Icons.linear_scale))
                            ],
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
            ],
          ),
        ),
      ),
    );
  }
}
