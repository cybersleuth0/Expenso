import 'package:expenso/App_Constant/constant.dart';
import 'package:flutter/material.dart';

class AddNewExpense extends StatefulWidget {
  @override
  State<AddNewExpense> createState() => _addNewExpenseState();
}

class _addNewExpenseState extends State<AddNewExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.only(
                top: 350, // Logo height (200) + extra margin (20)
                left: 24,
                right: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  //for Title
                  customTextField(
                      keybordType: TextInputType.text,
                      lableText: "Title",
                      customIcon: Icon(Icons.title)),
                  const SizedBox(height: 25),
                  //for description
                  customTextField(
                      keybordType: TextInputType.multiline,
                      lableText: "Description",
                      customIcon: Icon(Icons.message)),
                  const SizedBox(height: 25),
                  //for Amt
                  customTextField(
                      keybordType: TextInputType.number,
                      lableText: "Amount",
                      customIcon: Icon(Icons.attach_money_outlined)),
                  const SizedBox(height: 25),
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 5),
                                      itemCount: AppConstant.mcat.length,
                                      itemBuilder: (context, index) {
                                        return SingleChildScrollView(
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
                                                  AppConstant
                                                      .mcat[index].imgPath,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              AppConstant.mcat[index].name,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins"),
                                            ),
                                          ]),
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
                        child: Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                        shadowColor: Colors.black12,
                        backgroundColor: Color(0xff116bf1),
                        foregroundColor: Colors.white),
                    child: Text(
                      "Add Expense",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      extendBody: true,
    );
  }

  TextField customTextField(
      {required TextInputType keybordType,
      required String lableText,
      required Icon customIcon}) {
    return TextField(
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
