import 'package:expenso/data/Local/db_helper.dart';

import '../Model/user_model.dart';

class UserRepository {
  Db_Helper db_helper;

  UserRepository({required this.db_helper});

  Future<bool> registerUser({required UserModel newusr}) async {
    bool check = await db_helper.registerUser(newUser: newusr);
    return check;
  }

  Future<bool> checkIfEmailAlreadyExists({required String email}) async {
    return await db_helper.isUserAlreadyExist(email: email);
  }

  //login Function
  Future<bool> authenticateuser(
      {required String mail, required String passwd}) async {
    return await db_helper.authentcateUser(email: mail, password: passwd);
  }
}
