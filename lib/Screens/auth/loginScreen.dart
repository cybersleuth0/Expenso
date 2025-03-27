import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginBloc.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginEvent.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool isLoading = false; //use for manging loading state

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ExPenso",
          style: TextStyle(
              fontFamily: "Poppins", fontSize: 28, fontWeight: FontWeight.w600),
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
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ori_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 270),
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
                        const Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
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
                        TextField(
                          controller: passwordController,
                          obscureText: !isPasswordVisible,
                          //this will work opposite
                          // if is passwordvisible is true then it will hide password
                          // and if it is false then it will show password
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                                onTap: () {
                                  isPasswordVisible = !isPasswordVisible;
                                  /*
                                  If the password is hidden (false), it becomes visible (true).
                                  If the password is visible (true), it becomes hidden (false).
                                  */
                                  setState(() {});
                                  /*
                                  THis will rebuild the ui
                                  */
                                },
                                child: isPasswordVisible
                                    ? Icon(Icons.visibility_outlined)
                                    : const Icon(Icons.visibility_off)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: BlocListener<LoginBloc, LoginStates>(
                            listener: (context, state) {
                              if (state is LoginLoadingState) {
                                isLoading = true;
                                setState(() {});
                              } else if (state is LoginSuccessState) {
                                isLoading = false;
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Login Successfully !!")));
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.ROUTE_BASEPAGE);
                              } else if (state is LoginFailureState) {
                                isLoading = false;
                                setState(() {});
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errMsg)));
                              }
                            },
                            child: BlocBuilder<LoginBloc, LoginStates>(
                                builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(LoginuserEvent(
                                      email: emailController.text.trim(),
                                      password:
                                          passwordController.text.trim()));
                                },
                                child: isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(width: 5),
                                          Text("LoggedIn...."),
                                        ],
                                      )
                                    : const Text(
                                        "Sign in",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Forgot password?"),
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
                            context, AppRoutes.ROUTE_SIGNUP);
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign up",
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
    );
  }
}
