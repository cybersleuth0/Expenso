import 'package:expenso/App_Constant/constant.dart';
import 'package:expenso/Local/db_helper.dart';
import 'package:expenso/Screens/auth/LoginBloc/LoginBloc.dart';
import 'package:expenso/Screens/auth/RegisterBloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                RegisterBloc(dbHelper: Db_Helper.getInstance())),
        BlocProvider(
            create: (context) => LoginBloc(db_helper: Db_Helper.getInstance()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.ROUTE_SPLASH,
        routes: AppRoutes.getRoutes(),
      )));
}
