import 'package:expenso/Local/db_helper.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginEvent.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  Db_Helper db_helper;

  LoginBloc({required this.db_helper}) : super(LoginInitialState()) {
    on<LoginuserEvent>((event, emit) async {
      emit(LoginLoadingState());
      bool check = await db_helper.authentcateUser(
          email: event.email, password: event.password);
      if (check) {
        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState(errMsg: "Invalid Credential"));
      }
    });
  }
}
