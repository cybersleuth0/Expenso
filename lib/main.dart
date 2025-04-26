import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginBloc.dart';
import 'package:expenso/Screens/auth/RegisterBloc/register_bloc.dart';
import 'package:expenso/Screens/expense/Bloc/expBloc.dart';
import 'package:expenso/data/repository/expenseRepository.dart';
import 'package:expenso/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/Local/db_helper.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => RegisterBloc(
                userRepository:
                    UserRepository(db_helper: Db_Helper.getInstance()))),
        BlocProvider(
            create: (context) => LoginBloc(
                userRepository:
                    UserRepository(db_helper: Db_Helper.getInstance()))),
        BlocProvider(
            create: (context) => ExpBloc(
                expenseRepository:
                    ExpenseRepository(db_helper: Db_Helper.getInstance()))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.ROUTE_SPLASH,
        routes: AppRoutes.getRoutes(),
      )));
}
