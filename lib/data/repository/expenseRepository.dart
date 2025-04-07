import 'package:expenso/data/Local/db_helper.dart';
import 'package:expenso/data/Model/expense_model.dart';

class ExpenseRepository {
  Db_Helper db_helper;

  ExpenseRepository({required this.db_helper});

  // ================= CRUD Operations =================

  /// Adds new expense and returns success status
  Future<bool> addExpense({required ExpenseModel expense}) async {
    bool check = await db_helper.addNewExpense(newExp: expense);
    return check;
  }

  Future<List<ExpenseModel>>getAllExpenses()async{
    return await db_helper.fetchallExpenses();
  }
}
