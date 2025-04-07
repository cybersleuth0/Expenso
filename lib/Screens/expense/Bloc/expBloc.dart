import 'package:expenso/Screens/expense/Bloc/expEvents.dart';
import 'package:expenso/Screens/expense/Bloc/expState.dart';
import 'package:expenso/data/Local/db_helper.dart';
import 'package:expenso/data/Model/expense_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpBloc extends Bloc<ExpEvent, ExpState> {
  Db_Helper db_helper;

  ExpBloc({required this.db_helper}) : super(ExpInitialState()) {
    on<AddExpEvent>((event, emit) async {
      //First we have to emit the loading state
      emit(ExpLoadingState());
      //now we have to add the new expense
      bool check = await db_helper.addNewExpense(newExp: event.newExpmodel);

      if (check) {
        List<ExpenseModel> updatedExpenses = await db_helper.fetchallExpenses();
        emit(ExpSuccessState(allExpenseFromDb: updatedExpenses));
      } else {
        emit(ExpErrorState(errorMsg: "Something Went Wrong!!"));
      }
    });
    on<FetchExpEvent>((event, emit) async {
      List<ExpenseModel> updatedExpenses = await db_helper.fetchallExpenses();
      emit(ExpSuccessState(allExpenseFromDb: updatedExpenses));
    });
  } //In super we have to pass the initial state
}
