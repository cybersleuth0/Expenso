abstract class LoginEvents {}

class LoginuserEvent extends LoginEvents {
  final String email;
  final String password;

  LoginuserEvent({required this.email, required this.password});
}
