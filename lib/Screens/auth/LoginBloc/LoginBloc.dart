import 'package:expenso/Screens/auth/LoginBloc/LoginEvent.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginState.dart';
import 'package:expenso/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  UserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(LoginInitialState()) {
    on<LoginuserEvent>((event, emit) async {
      emit(LoginLoadingState());
      // bool check = await db_helper.authentcateUser(email: event.email, password: event.password);
      bool check = await userRepository.authenticateuser(
          mail: event.email, passwd: event.password);
      if (check) {
        emit(LoginSuccessState());
      } else {
        emit(LoginFailureState(errMsg: "Invalid Credential"));
      }
    });
  }
}
