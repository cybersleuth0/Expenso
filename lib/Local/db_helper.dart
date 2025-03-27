import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user_model.dart';

class Db_Helper {
  Db_Helper._(); //Single Ton Class
  static Db_Helper getInstance() => Db_Helper._();

  //STATIC VARIABLE NAME
  //user table
  static String USER_TABLE = "user_table";
  static String USER_ID = "user_id";
  static String USER_NAME = "user_name";
  static String USER_EMAIL = "user_email";
  static String USER_PASSWORD = "user_password";
  static String USER_confirm_PASSWORD = "user_confirm_password";
  static String USER_MOBILE = "user_mobile";
  static String USER_CREATED_AT = "user_createdAt";

  //Expense table
  static String EXPENSE_TABLE = "expense_table";
  static String EXPENSE_ID = "expense_id";
  static String EXPENSE_TITLE = "expense_title";
  static String EXPENSE_DESCRIPTION = "expense_description";
  static String EXPENSE_AMOUNT = "expense_amount";
  static String EXPENSE_BALANCE = "expense_balance";
  static String EXPENSE_TYPE = "expense_type"; //1=> Credit 2=> Debit
  static String EXPENSE_CATEGORY = "expense_category_id";
  static String EXPENSE_DATE = "expense_date";
  static String EXPENSE_CREATED_AT = "expense_createdAt";

  Database? _db;

  Future<Database> getDb() async {
    // if (_db != null) {
    //   return _db!;
    // } else {
    //   return _db = await Opendb();
    // }
    //_db = _db ?? await Opendb();
    _db ??= await OpenDb();
    return _db!;
  }

  //Creating Database
  Future<Database> OpenDb() async {
    //path of the database in user mobile
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbpath = join(appDir.path + "user.db");
    return await openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute("CREATE TABLE $USER_TABLE ("
          "$USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$USER_NAME TEXT, "
          "$USER_EMAIL TEXT, "
          "$USER_PASSWORD TEXT, "
          "$USER_confirm_PASSWORD TEXT, "
          "$USER_CREATED_AT TEXT, "
          "$USER_MOBILE TEXT)");

      db.execute("CREATE TABLE $EXPENSE_TABLE ( "
          "$EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$USER_ID INTEGER ,"
          "$EXPENSE_TITLE TEXT,"
          "$EXPENSE_DESCRIPTION TEXT,"
          "$EXPENSE_AMOUNT REAL,"
          "$EXPENSE_BALANCE REAL,"
          "$EXPENSE_TYPE TEXT,"//1-for credit 2-debit
          "$EXPENSE_DATE TEXT,"
          "$EXPENSE_CATEGORY TEXT"
          ")");
    });
  }

  //REGISTER USER
  Future<bool> registerUser({required UserModel newUser}) async {
    var db = await getDb();
    int roweffected = await db.insert(USER_TABLE, newUser.toMap());
    return roweffected > 0;
  }

  /*Check if user registered or not
    this function will check if user already exist or not
    and return true if user already exist and false if user does not exist*/
  Future<bool> isUserAlreadyExist({required String email}) async {
    var db = await getDb();
    List<Map<String, dynamic>> mData =
        await db.query(USER_TABLE, where: "$USER_EMAIL=?", whereArgs: [email]);
    return mData.isNotEmpty;
  }

  //log in user
  Future<bool> authentcateUser(
      {required String email, required String password}) async {
    var db = await getDb();
    var mdata = await db.query(USER_TABLE,
        where: "$USER_EMAIL=? AND $USER_PASSWORD=?",
        whereArgs: [email, password]);
    return mdata.isNotEmpty;
  }
}
