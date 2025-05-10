import 'package:expenso/data/Model/expense_model.dart';

abstract class ExpEvent {}

class AddExpEvent extends ExpEvent {
  //now we have to ask tp pass the data that we need for this action
  ExpenseModel newExpmodel;

  AddExpEvent({required this.newExpmodel});
}

//class FetchExpEvent extends ExpEvent {}

class GetInitialExpEvent extends ExpEvent {
  int type;

  GetInitialExpEvent({this.type = 0});
}