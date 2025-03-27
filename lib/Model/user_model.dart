import '../Local/db_helper.dart';

class UserModel {
  int? user_id;
  String user_name;
  String user_email;
  String user_password;
  String user_confirm_password;
  String user_mobile;
  String user_createdAt;

  UserModel({
    this.user_id,
    required this.user_name,
    required this.user_email,
    required this.user_password,
    required this.user_confirm_password,
    required this.user_mobile,
    required this.user_createdAt,
  });

  /*For Inserting data we have to use toMap()
  Convert the data from object to map
  */
  Map<String, dynamic> toMap() {
    return {
      //we dont need to pass the id because it will auto increment in database and
      // when we are inserting the data we dont need to pass the id
      Db_Helper.USER_NAME: user_name,
      Db_Helper.USER_EMAIL: user_email,
      Db_Helper.USER_PASSWORD: user_password,
      Db_Helper.USER_confirm_PASSWORD: user_confirm_password,
      Db_Helper.USER_MOBILE: user_mobile,
      Db_Helper.USER_CREATED_AT: user_createdAt,
    };
  }

/*For getting data we have to use fromMap()
  Convert the data from map to object
  */
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map[Db_Helper.USER_ID],
      user_name: map[Db_Helper.USER_NAME],
      user_email: map[Db_Helper.USER_EMAIL],
      user_password: map[Db_Helper.USER_PASSWORD],
      user_confirm_password: map[Db_Helper.USER_confirm_PASSWORD],
      user_mobile: map[Db_Helper.USER_MOBILE],
      user_createdAt: map[Db_Helper.USER_CREATED_AT],
    );
  }
}
