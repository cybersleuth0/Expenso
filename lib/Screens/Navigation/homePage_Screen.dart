import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Screens/expense/Bloc/expBloc.dart';
import 'package:expenso/Screens/expense/Bloc/expState.dart';
import 'package:expenso/data/Model/FilterModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../expense/Bloc/expEvents.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userName;

  String filterDropdownValue = "Date";
  List<String> filterDropdownValueList = ["Date", "Month", "Year", "Category"];
  List<FilterExpenseModel> filteredExpenses = [];

  @override
  void initState() {
    super.initState();
    // Fetch all expenses on app start
    context.read<ExpBloc>().add(GetInitialExpEvent());
    AppConstant.initcalled++;
    getUsername().then((value) {
      setState(() {
        userName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("EXPENSO",
                style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 25,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600)),
            Icon(Icons.search, size: 30),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(13.0),
        child: BlocBuilder<ExpBloc, ExpState>(
          builder: (context, state) {
            if (state is ExpLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ExpSuccessState) {
              //Filter Data here
              // filterExpense(
              //     allexpense: state.allExpenseFromDb, filterType: filterFlag);
              filteredExpenses=state.allExpenseFromDb;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("assets/images/boy_3d_image.jpg"),
                        )),
                        Expanded(
                            flex: 3,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Morning\n',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: Colors.grey[600]),
                                  ),
                                  TextSpan(
                                    text: '$userName',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: DropdownMenu(
                              initialSelection: filterDropdownValue,
                              onSelected: (String? newValue) {
                                filterDropdownValue = newValue!;
                                if (filterDropdownValue == "Date") {
                                  context
                                      .read<ExpBloc>()
                                      .add(GetInitialExpEvent(type: 0));
                                  //filterFlag = 0; //0 for date
                                } else if (filterDropdownValue == "Month") {
                                  context
                                      .read<ExpBloc>()
                                      .add(GetInitialExpEvent(type: 1));
                                  //filterFlag = 1; //0 for month
                                } else if (filterDropdownValue == "Year") {
                                  context
                                      .read<ExpBloc>()
                                      .add(GetInitialExpEvent(type: 2));
                                  //filterFlag = 2; //0 for year
                                } else {
                                  context
                                      .read<ExpBloc>()
                                      .add(GetInitialExpEvent(type: 3));
                                  //filterFlag = 3; //0 for Category
                                }
                                //setState(() {});
                              },
                              dropdownMenuEntries:
                                  filterDropdownValueList.map((newvalue) {
                                return DropdownMenuEntry(
                                    value: newvalue, label: newvalue);
                              }).toList(),
                              inputDecorationTheme: InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      fontFamily: "Poppins", fontSize: 18),
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: InputBorder.none),
                            ))
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 140,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff5967cd),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Expense Total",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Poppins")),
                                  SizedBox(height: 2),
                                  Text("\₹ 3,722",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(' \₹ 240 ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      SizedBox(width: 5),
                                      Text('than last month',
                                          style: TextStyle(
                                              color: Colors.white54,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
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
                                scale: 1.7,
                                child: Image(
                                    image: AssetImage(
                                        "assets/images/home_image.png")),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("Expense List",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins")),
                    SizedBox(height: 15),
                    //Expense list
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: filteredExpenses.isEmpty
                          ? Center(
                              child: Text(
                              "You Have No Expense\nClick On the + Icon to add...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17, fontFamily: "Poppins"),
                            ))
                          : expenseList(),
                    )
                  ],
                ),
              );
            }

            if (state is ExpErrorState) {
              return Text(state.errorMsg);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget expenseList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredExpenses.length,
      itemBuilder: (context, index) {
        FilterExpenseModel group = filteredExpenses[index];
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
              // Header with date and total amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(group.type, // This is our date string
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 50),
                  Text(
                      "${group.totalAmt >= 0 ? "+" : "-"}\₹ ${group.totalAmt.abs().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: group.totalAmt >= 0 ? Colors.green : Colors.red,
                      )),
                ],
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey, height: 2),
              SizedBox(height: 10),

              // Individual expenses for each date
              ...group.mexpenses.map((expense) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        leading: Image.asset(
                          AppConstant.mcat
                              .where((item) {
                                return item.id == expense.expense_category_id;
                              })
                              .toList()[0]
                              .imgPath,
                        ),
                        title: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${expense.expense_title}\n',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    fontFamily: "Poppins"),
                              ),
                              TextSpan(
                                text: expense.expense_description ?? "",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        trailing: Text(
                          "\₹${expense.expense_amount.toStringAsFixed(2) ?? '0.00'}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }

  //get username

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstant.CRTUSERNAME) ?? "";
  }
}
