import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Bloc/ExpBloc/expEvents.dart';
import 'package:expenso/Bloc/ExpBloc/expState.dart';
import 'package:expenso/data/Model/FilterModel.dart';
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
        List<ExpenseModel> allExpenses =
            await expenseRepository.getAllExpenses();
        List<FilterExpenseModel> allFilterdExpense =
            AppConstant.filterExpense(allexpense: allExpenses, filterType: 1);
        // List<ExpenseModel> updatedExpenses = await db_helper.fetchallExpenses();
        emit(ExpSuccessState(allExpenseFromDb: allFilterdExpense));
      } else {
        emit(ExpErrorState(errorMsg: "Something Went Wrong!!"));
      }
    });

    on<GetInitialExpEvent>((event, emit) async {
      emit(ExpLoadingState());
      List<ExpenseModel> allExpenses = await expenseRepository.getAllExpenses();
      List<FilterExpenseModel> allFilterdExpense = AppConstant.filterExpense(
          allexpense: allExpenses, filterType: event.type);
      emit(ExpSuccessState(allExpenseFromDb: allFilterdExpense));
    });
  } //In super we have to pass the initial state
}
