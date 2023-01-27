import 'package:blood/GoogleMap/current_location.dart';
import 'package:blood/pages/auth/emailverify.dart';
import 'package:blood/pages/blood_donate.dart';
import 'package:blood/pages/blood_donated_List.dart';
import 'package:blood/pages/blood_request.dart';
import 'package:blood/pages/home_screen.dart';
import 'package:blood/utils/Routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../../pages/auth/RegisterScreen.dart';
import '../../pages/auth/login_screen.dart';
import '../../pages/blood_request_list.dart';
import '../../pages/forgot_password_screen.dart';
import '../../pages/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      // TODO Splash Screen
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      // TODO Register Form Screen
      case RoutesName.SignUp:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      // TODO Login Screen
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      // TODO Home Screen
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      // TODO Blood Donate Form
      case RoutesName.bloodDonate:
        return MaterialPageRoute(builder: (context) => const BloodDonate());

    // TODO Blood Donate List
      case RoutesName.bloodDonaterList:
        return MaterialPageRoute(builder: (context) => const BloodDonaterList());


    // TODO Blood Request Form
      case RoutesName.bloodRequest:
        return MaterialPageRoute(builder: (context) => const BloodRequest());

      // TODO  Blood Request List
      case RoutesName.bloodRequestList:
        return MaterialPageRoute(builder: (context)=> const BloodRequestList());

        // TODO  Forgot Password Screen
      case RoutesName.forgotPasswordScreen:
        return MaterialPageRoute(builder: (context)=> const ForgotPasswordScreen());

      //   //TODO  Email Verification
      // case RoutesName.emailVerification:
      //   return MaterialPageRoute(builder: (context)=> const VerifyEmail());

      // TODO By Default
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("Not Route Found"),
                  ),
                ));
    }
  }
}
