import 'package:expenso/data/Model/FilterModel.dart';

/*
- Initial (empty) state
- Loading state (show progress indicator)
- Success state (show data)
- Error state (show error message)
 */
abstract class ExpState {} //base State

//- Initial (empty) state
class ExpInitialState extends ExpState {}

// - Loading state (show progress indicator)
class ExpLoadingState extends ExpState {}

//- Success state (show data)
class ExpSuccessState extends ExpState {
  //Here we have to specify what kind of data we are gonna show
  final List<FilterExpenseModel> allExpenseFromDb;

  ExpSuccessState({required this.allExpenseFromDb});
}

//- Error state (show error message)
class ExpErrorState extends ExpState {
  final String errorMsg;

  ExpErrorState({required this.errorMsg});
}
