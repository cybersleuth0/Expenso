import '../Local/db_helper.dart';

class ExpenseModel {
  int? expense_id;
  int? user_id;
  String expense_title;
  String expense_description;
  //String expense_date;
  String expense_createdAt;
  num expense_amount;
  num expense_balance;
  String expense_type; //1=> Credit 2=> Debit
  int expense_category_id;

  ExpenseModel({
    this.expense_id,
    this.user_id,
    required this.expense_title,
    required this.expense_description,
    required this.expense_amount,
    required this.expense_balance,
    required this.expense_type,
    required this.expense_category_id,
    required this.expense_createdAt,
  });

  /*For Inserting data we have to use toMap()
  Convert the data from object to map
  */
  Map<String, dynamic> toMap() {
    return {
      //we dont need to pass the id because it will auto increment in database and
      // when we are inserting the data we dont need to pass the id
      Db_Helper.EXPENSE_ID: expense_id,
      Db_Helper.USER_ID: user_id,
      Db_Helper.EXPENSE_TITLE: expense_title,
      Db_Helper.EXPENSE_DESCRIPTION: expense_description,
      //Db_Helper.EXPENSE_DATE: expense_date,
      Db_Helper.EXPENSE_AMOUNT: expense_amount,
      Db_Helper.EXPENSE_BALANCE: expense_balance,
      Db_Helper.EXPENSE_TYPE: expense_type,
      Db_Helper.EXPENSE_CATEGORY: expense_category_id.toString(),
      Db_Helper.EXPENSE_CREATED_AT: expense_createdAt,
    };
  }

/*For getting data we have to use fromMap()
  Convert the data from map to object
  */
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      //expense_id: map[Db_Helper.EXPENSE_ID], we dont need to pass the id because it will auto increment
      user_id: map[Db_Helper.USER_ID],
      expense_title: map[Db_Helper.EXPENSE_TITLE],
      expense_description: map[Db_Helper.EXPENSE_DESCRIPTION],
      //expense_date: map[Db_Helper.EXPENSE_DATE],
      expense_amount: map[Db_Helper.EXPENSE_AMOUNT],
      expense_balance: map[Db_Helper.EXPENSE_BALANCE],
      expense_type: map[Db_Helper.EXPENSE_TYPE],
      expense_category_id: int.parse(map[Db_Helper.EXPENSE_CATEGORY]),
      expense_createdAt: map[Db_Helper.EXPENSE_CREATED_AT],
    );
  }
}
