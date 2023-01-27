import 'package:blood/component/TextField.dart';
import 'package:blood/utils/toastMassage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/RoundButton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailcontroller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.red,)),

        title: "Reset Password".text.red500.size(26).make(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/2.jpg'),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Reset Password".text.size(32).red500.semiBold.make(),
                const SizedBox(height: 10,),
                "Enter the email associated with your account and we'll send an email"
                    " with instruction to reset your password".text.bold.size(16).make(),

                const SizedBox(height: 60,),
                Field(hintText: "Enter Email", label: 'Email', controller: emailcontroller),

                const SizedBox(height: 30,),

                // TODO   Recover Password functionality

                RoundButton(
                  text: 'Forgot Password',
                  textColor: Colors.white,
                  color: Colors.red,
                  onPress: () {
                    _auth.sendPasswordResetEmail(email: emailcontroller.text).then((value){
                      Utils().toastMassage("We have sent you email to recover password. Please check email");
                    }).onError((error, stackTrace){
                      Utils().toastMassage(error.toString());
                    });
                  } ,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
