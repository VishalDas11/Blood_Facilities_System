
import 'package:blood/utils/Routes/routes.dart';
import 'package:blood/utils/Routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'component/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: AppColor.bgColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.red,
            centerTitle: true,
            titleTextStyle: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500)
          ),

      ),
      // color: Colors.white,
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}