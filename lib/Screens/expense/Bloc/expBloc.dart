import 'package:expenso/Screens/expense/Bloc/expEvents.dart';
import 'package:expenso/Screens/expense/Bloc/expState.dart';
import 'package:expenso/data/Model/expense_model.dart';
import 'package:expenso/data/repository/expenseRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpBloc extends Bloc<ExpEvent, ExpState> {
  // Db_Helper db_helper;
  ExpenseRepository expenseRepository;

  ExpBloc({required this.expenseRepository}) : super(ExpInitialState()) {
    on<AddExpEvent>((event, emit) async {
      //First we have to emit the loading state
      emit(ExpLoadingState());
      //now we have to add the new expense
      // bool check = await db_helper.addNewExpense(newExp: event.newExpmodel);
      bool check =
          await expenseRepository.addExpense(expense: event.newExpmodel);

      if (check) {
        List<ExpenseModel> updatedExpenses =
            await expenseRepository.getAllExpenses();
        // List<ExpenseModel> updatedExpenses = await db_helper.fetchallExpenses();
        emit(ExpSuccessState(allExpenseFromDb: updatedExpenses));
      } else {
        emit(ExpErrorState(errorMsg: "Something Went Wrong!!"));
      }
    });
    on<FetchExpEvent>((event, emit) async {
      List<ExpenseModel> updatedExpenses =
          await expenseRepository.getAllExpenses();
      emit(ExpSuccessState(allExpenseFromDb: updatedExpenses));
    });
  } //In super we have to pass the initial state
}
