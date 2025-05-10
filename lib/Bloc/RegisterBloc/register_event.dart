import '../../../data/Model/user_model.dart';

abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  UserModel RegisterNewUsr;

  RegisterUserEvent({required this.RegisterNewUsr});
}
