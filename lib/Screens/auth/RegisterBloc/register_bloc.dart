import 'package:expenso/Local/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  Db_Helper dbHelper;

  RegisterBloc({required this.dbHelper}) : super(RegisterInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      if (await dbHelper.isUserAlreadyExist(
          email: event.RegisterNewUsr.user_email)) {
        emit(RegisterFailureState(errorMsg: "User Already Exist"));
      } else {
        bool check = await dbHelper.registerUser(newUser: event.RegisterNewUsr);
        if (check) {
          emit(RegisterSuccessState());
        } else {
          emit(RegisterFailureState(errorMsg: "Something Went Wrong"));
        }
      }
    });
  }
}
