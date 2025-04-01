import 'package:expenso/data/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Local/db_helper.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(RegisterInitialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(RegisterLoadingState());
      // if (await dbHelper.isUserAlreadyExist(
      //     email: event.RegisterNewUsr.user_email)) {
      //   emit(RegisterFailureState(errorMsg: "User Already Exist"));
      // } else {
      //   bool check = await dbHelper.registerUser(newUser: event.RegisterNewUsr);
      //   if (check) {
      //     emit(RegisterSuccessState());
      //   } else {
      //     emit(RegisterFailureState(errorMsg: "Something Went Wrong"));
      //   }
      // }
      if (await userRepository.checkIfEmailAlreadyExists(
          email: event.RegisterNewUsr.user_email)) {emit(RegisterFailureState(errorMsg: "User Already Exist"));
      } else {
        bool check =
            await userRepository.registerUser(newusr: event.RegisterNewUsr);
        if (check) {
          emit(RegisterSuccessState());
        } else {
          emit(RegisterFailureState(errorMsg: "Something Went Wrong"));
        }
      }
    });
  }
}
