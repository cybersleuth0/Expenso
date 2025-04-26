import 'package:expenso/Screens/Navigation/baseHomeScreen.dart';
import 'package:expenso/Screens/Navigation/homePage_Screen.dart';
import 'package:expenso/Screens/expense/addExpense_Screen.dart';
import 'package:expenso/data/Model/FilterModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../Screens/auth/loginScreen.dart';
import '../Screens/auth/signupScreen.dart';
import '../Screens/intro_Screen.dart';
import '../Screens/splash_Screen.dart';
import '../data/Model/expCategoryModel.dart';
import '../data/Model/expense_model.dart';

class AppConstant {
  static const String ISLOGIN = "is_login";
  static const String CRTUSERNAME = "username";
  static int initcalled = 0;
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

  static List<FilterExpenseModel> filterExpense(
      {required List<ExpenseModel> allexpense, required filterType}) {
    //This will store all filtered data
    List<FilterExpenseModel> filteredExpenses = [];

    //Lets create a dateFormat
    DateFormat df = DateFormat.yMMMd();
    filteredExpenses.clear();
    if (filterType == 0) {
      //0 for date
      List<String> uniqDates = [];

      // Find unique dates
      for (ExpenseModel eachExp in allexpense) {
        String alldates = df.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expense_createdAt)));
        if (!uniqDates.contains(alldates)) {
          uniqDates.add(alldates);
        }
      }

      // Process expenses for each date
      for (String eachdate in uniqDates) {
        num eachDateTotalAmt = 0.0; //this is the total amount of each date
        List<ExpenseModel> eachDateExpense =
            []; //this will store all expenses of each date

        for (ExpenseModel eachExp in allexpense) {
          //this  will give us single date from uniq dates
          String singledate = df.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expense_createdAt)));
          if (eachdate == singledate) {
            eachDateExpense.add(eachExp);
            if (eachExp.expense_type == "Debit") {
              eachDateTotalAmt -= eachExp.expense_amount;
            } else {
              eachDateTotalAmt += eachExp.expense_amount;
            }
          }
        }

        // Create a FilterExpenseModel for this date and add it to our results
        filteredExpenses.add(FilterExpenseModel(
            totalAmt: eachDateTotalAmt,
            type: eachdate, // using the date as the "type"
            mexpenses: eachDateExpense));
      }
    } else if (filterType == 1) {
      //1 for month
      DateFormat monthdf = DateFormat.M();
      List uniqMonths = [];
      //get all uniq months
      for (ExpenseModel eachExp in allexpense) {
        String month = monthdf.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expense_createdAt)));
        if (!uniqMonths.contains(month)) {
          uniqMonths.add(month);
        }
      }

      //process expenses for each month
      for (String month in uniqMonths) {
        num eachMonthTotalAmt = 0.0;
        List<ExpenseModel> eachMonthExpense = [];
        for (ExpenseModel eachExp in allexpense) {
          //get single month
          String singlemonth = monthdf.format(
              DateTime.fromMillisecondsSinceEpoch(
                  int.parse(eachExp.expense_createdAt)));
          if (singlemonth == month) {
            eachMonthExpense.add(eachExp);
            if (eachExp.expense_type == "Debit") {
              eachMonthTotalAmt -= eachExp.expense_amount;
            } else {
              eachMonthTotalAmt += eachExp.expense_amount;
            }
          }
        }
        filteredExpenses.add(FilterExpenseModel(
            totalAmt: eachMonthTotalAmt,
            type: month,
            mexpenses: eachMonthExpense));
      }
    } else if (filterType == 2) {
      DateFormat yeardf = DateFormat.y();
      //Now we have to get all uniqyear
      List uniqYear = [];
      for (ExpenseModel eachExp in allexpense) {
        String year = yeardf.format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(eachExp.expense_createdAt)));
        if (!uniqYear.contains(year)) {
          uniqYear.add(year);
        }
      }
      //process expenses for each year
      for (String year in uniqYear) {
        num eachYearTotalAmt = 0.0;
        List<ExpenseModel> eachYearExpense = [];
        for (ExpenseModel eachExp in allexpense) {
          String singleyear = yeardf.format(DateTime.fromMillisecondsSinceEpoch(
              int.parse(eachExp.expense_createdAt)));
          if (singleyear == year) {
            eachYearExpense.add(eachExp);
            if (eachExp.expense_type == "Debit") {
              eachYearTotalAmt -= eachExp.expense_amount;
            } else {
              eachYearTotalAmt += eachExp.expense_amount;
            }
          }
        }

        filteredExpenses.add(FilterExpenseModel(
            totalAmt: eachYearTotalAmt,
            type: year,
            mexpenses: eachYearExpense));
      }
    } else {
      //for category's
      filteredExpenses.clear();
      for (expCategoryModel eachCat in AppConstant.mcat) {
        num eachCatTotalAMT = 0.0; //this will store total amt for each cat
        List<ExpenseModel> eachCatExp = [];
        for (ExpenseModel eachExp in allexpense) {
          if (eachCat.id == eachExp.expense_category_id) {
            eachCatExp.add(eachExp);
            if (eachExp.expense_type == "Debit") {
              eachCatTotalAMT -= eachExp.expense_amount;
            } else {
              eachCatTotalAMT += eachExp.expense_amount;
            }
          }
        }
        if (eachCatExp.isNotEmpty) {
          filteredExpenses.add(FilterExpenseModel(
              totalAmt: eachCatTotalAMT,
              type: eachCat.name,
              mexpenses: eachCatExp));
        }
      }
    }
    return filteredExpenses;
  }
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
