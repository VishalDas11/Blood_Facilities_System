import 'dart:async';

import 'package:blood/utils/Routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.home);
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamed(context, RoutesName.login);
      });
    }
  }
}
