import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blood/component/app_color.dart';
import 'package:blood/pages/auth/slpash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash.jpg'), fit: BoxFit.fill)),
          ),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 28.0, fontWeight: FontWeight.w500, color: AppColor.blood),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Give Blood Save Life',
                      speed: Duration(milliseconds: 200)),
                ],
                totalRepeatCount: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
