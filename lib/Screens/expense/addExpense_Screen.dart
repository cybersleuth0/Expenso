import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Bloc/ExpBloc/expBloc.dart';
import 'package:expenso/Bloc/ExpBloc/expEvents.dart';
import 'package:expenso/Bloc/ExpBloc/expState.dart';
import 'package:expenso/data/Model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddNewExpense extends StatefulWidget {
  @override
  State<AddNewExpense> createState() => _addNewExpenseState();
}

class _addNewExpenseState extends State<AddNewExpense> {
  var titleControler = TextEditingController();
  var descControler = TextEditingController();
  var amtControler = TextEditingController();

  int expCatIndex = -1; //for storing the category selected by user

  List<String> expType = ["Debit", "Credit"]; // for storing the type of expense

  String selectedExpType = "Debit";

  DateTime? selectedDateTime;

  DateFormat dateformater = DateFormat("dd-MM-yyyy");
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        bottomNavigationBar: null,
        extendBodyBehindAppBar: true,
        //makes the gradient extend under the AppBar.
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Add Expense",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),
        ),
        body: Stack(
          children: [
            //baqckground
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xff9A22CE),
                    Color(0xff6026CE),
                    Color(0xff303692),
                    Color(0xff0D2EA1),
                    Color(0xff0160DC),
                  ])),
            ),
            Positioned(
                top: 10,
                right: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/pocket.png",
                )),
            Padding(
              padding: EdgeInsets.only(top: 350, left: 24, right: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    //for Title
                    customTextFormField(
                        controller: titleControler,
                        keybordType: TextInputType.text,
                        lableText: "Title",
                        customIcon: Icon(Icons.title),
                        validator: (value) {
                          if (value!.isEmpty) return "Title Cannot Be Empty";
                          return null;
                        }),
                    const SizedBox(height: 25),
                    //for description
                    customTextFormField(
                        controller: descControler,
                        keybordType: TextInputType.multiline,
                        lableText: "Description",
                        customIcon: Icon(Icons.message),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Description Cannot Be Empty";
                          return null;
                        }),
                    const SizedBox(height: 25),
                    //for Amt
                    customTextFormField(
                        controller: amtControler,
                        keybordType: TextInputType.number,
                        lableText: "Amount",
                        customIcon: Icon(Icons.attach_money_outlined),
                        validator: (value) {
                          final RegExp amountRegex =
                              RegExp(r'^\d+(\.\d{1,2})?$');
                          if (value!.isEmpty) return "Please Enter Amount !!";
                          if (!amountRegex.hasMatch(value)) {
                            return "Please Enter valid Amount !!";
                          }
                          return null;
                        }),
                    const SizedBox(height: 25),
                    //Choose Expense where you want to add expense Category bottom
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: GridView.builder(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 5),
                                        itemCount: AppConstant.mcat.length,
                                        itemBuilder: (context, index) {
                                          return SingleChildScrollView(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                expCatIndex = index;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black54,
                                                          blurRadius: 6,
                                                          offset: Offset(0, 3),
                                                        )
                                                      ],
                                                    ),
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        AppConstant.mcat[index]
                                                            .imgPath,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    AppConstant
                                                        .mcat[index].name,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins"),
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                });
                          },
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.white),
                          child: expCatIndex > 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black87,
                                              blurRadius: 6,
                                              offset: Offset(0.3, 0.3),
                                            )
                                          ]),
                                      child: ClipOval(
                                        child: Image.asset(
                                          AppConstant.mcat[expCatIndex].imgPath,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "-  ${AppConstant.mcat[expCatIndex].name}",
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    )
                                  ],
                                )
                              : Text(
                                  "Choose Category",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600),
                                )),
                    ),
                    const SizedBox(height: 25),
                    //for Expense Type debit or credit
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      // Inner spacing
                      child: DropdownMenu<String>(
                        menuStyle: MenuStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.only(right: 24))),
                        inputDecorationTheme: InputDecorationTheme(
                          border: InputBorder.none, // Remove default underline
                          contentPadding: EdgeInsets.zero,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.black87, // Better contrast
                        ),
                        initialSelection: selectedExpType,
                        width: MediaQuery.of(context).size.width,
                        onSelected: (String? value) {
                          setState(() {
                            selectedExpType = value!;
                          });
                        },
                        dropdownMenuEntries: expType.map((value) {
                          return DropdownMenuEntry(
                            value: value,
                            label: value,
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    //Date Picker
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          selectedDateTime = await showDatePicker(
                              context: context,
                              firstDate:
                                  DateTime.now().subtract(Duration(days: 7)),
                              lastDate: DateTime.now());
                          setState(() {});
                        },
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.white),
                        child: Text(
                          (dateformater
                              .format(selectedDateTime ?? DateTime.now())),
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    //Add Expense Button
                    BlocListener<ExpBloc, ExpState>(
                        listener: (context, state) {
                          if (state is ExpSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text("Expense Added Successfully!!")),
                            );
                            Navigator.pop(context);
                          } else if (state is ExpErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMsg)),
                            );
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            // print("Title: ${titleControler.text}");
                            // print("Desc: ${descControler.text}");
                            // print("Amount: ${amtControler.text}");
                            // print("Expense category: ${expCatIndex}");
                            // print("Expense Type: ${selectedExpType}");
                            // print("Date Type: ${selectedDateTime}");

                            if (expCatIndex != -1 && selectedDateTime != null) {
                              if (_formkey.currentState!.validate()) {
                                context.read<ExpBloc>().add(AddExpEvent(
                                    newExpmodel: ExpenseModel(
                                        expense_title:
                                            titleControler.text.trim(),
                                        expense_description:
                                            descControler.text.trim(),
                                        expense_amount: double.parse(
                                            amtControler.text.trim()),
                                        expense_balance: 0,
                                        expense_type: selectedExpType,
                                        expense_category_id:
                                            AppConstant.mcat[expCatIndex].id,
                                        expense_createdAt: selectedDateTime!
                                            .millisecondsSinceEpoch
                                            .toString())));
                              }
                            } else {
                              selectedDateTime != null
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please Select Category Type!!")))
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Please Select Date")));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            shadowColor: Colors.black12,
                            backgroundColor: Color(0xff116bf1),
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Add Expense",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                        )),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            )
          ],
        ),
        extendBody: true,
      ),
    );
  }

  TextFormField customTextFormField(
      {required TextInputType keybordType,
      required String lableText,
      required TextEditingController controller,
      required Icon customIcon,
      required String? Function(String?)? validator}) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keybordType,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(color: Colors.black, fontSize: 22),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        fillColor: Colors.white,
        filled: true,
        label: Text(
          lableText,
          style: TextStyle(color: Colors.red),
        ),
        prefixIcon: customIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // Rounded Borders
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
