import 'package:expenso/data/Model/expense_model.dart';

class FilterExpenseModel {
  num totalAmt;

  /// The total amount for the filtered expenses.
  String type;

  /// The type of expense being filtered (e.g., "Food", "Transportation").
  List<ExpenseModel> mexpenses;

  /// A list of ExpenseModel objects that match the filter criteria.
  /// Creates a new instance of FilterExpenseModel.
  /// [totalAmt] The total amount for the filtered expenses.
  /// [type] The type of expense being filtered. it can be date,month,year
  /// [mexpenses] A list of ExpenseModel objects matching the filter.
  FilterExpenseModel(
      {required this.totalAmt, required this.type, required this.mexpenses});
}