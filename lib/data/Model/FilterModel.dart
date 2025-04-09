import 'package:expenso/data/Model/expense_model.dart';

class FilterExpenseModel {
  num totalAmt;
  String type;
  List<ExpenseModel> mexpenses;

  FilterExpenseModel(
      {required this.totalAmt, required this.type, required this.mexpenses});
}
