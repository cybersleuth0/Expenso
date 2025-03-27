import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Model/user_model.dart';
import 'package:expenso/Screens/auth/RegisterBloc/register_bloc.dart';
import 'package:expenso/Screens/auth/RegisterBloc/register_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signuppage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Signuppage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  /*
  */

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        resizeToAvoidBottomInset: false, //use for avoid keyboard overlap
        appBar: AppBar(
          leadingWidth: 0,
          centerTitle: true,
          title: const Text(
            "ExPenso",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/ori_logo.png",
                  height: 350,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 200),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //For heading Sign Up
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          //For Name
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name field cannot be empty!";
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: const Icon(Icons.person_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //For phone Number
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "PhoneNumber field cannot be empty!";
                              } else if (value.length != 10) {
                                return "Please enter a valid number";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            controller: mobileController,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              prefixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //For email
                          TextFormField(
                            validator: (value) {
                              var exp = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (!exp.hasMatch(value!)) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //For password
                          TextFormField(
                            validator: (value) {
                              var exp = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (!exp.hasMatch(value!)) {
                                return "Enter Valid Password !!";
                              } else if (value.isNotEmpty) {
                                return "Password field cannot be empty!";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: passController,
                            obscureText: !isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    isPasswordVisible = !isPasswordVisible;
                                    setState(() {});
                                  },
                                  child: isPasswordVisible
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(Icons.visibility_off)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //For Confirm password
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Confirm Pass field cannot be empty!";
                              } else if (value != passController.text) {
                                return "Password doesn't match!";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            controller: confirmPassController,
                            obscureText: !isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                    setState(() {});
                                  },
                                  child: isConfirmPasswordVisible
                                      ? const Icon(Icons.visibility_outlined)
                                      : const Icon(Icons.visibility_off)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  context.read<RegisterBloc>().add(
                                      RegisterUserEvent(
                                          RegisterNewUsr: UserModel(
                                              user_name:
                                                  nameController.text.trim(),
                                              user_email:
                                                  emailController.text.trim(),
                                              user_password:
                                                  passController.text.trim(),
                                              user_confirm_password:
                                                  confirmPassController.text
                                                      .trim(),
                                              user_mobile:
                                                  mobileController.text.trim(),
                                              user_createdAt: DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString())));

                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.ROUTE_LOGIN);
                                }
                              },
                              child: const Text(
                                "Sign up",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.ROUTE_LOGIN);
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: "Log in",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
