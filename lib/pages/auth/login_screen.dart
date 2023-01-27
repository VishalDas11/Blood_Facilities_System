import 'package:blood/component/RoundButton.dart';
import 'package:blood/component/TextField.dart';
import 'package:blood/utils/toastMassage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/Routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  final _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    emailController;
    passwordController;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: "Login".text.semiBold.black.size(25).make(),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // TODO Image
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'assets/images/1.jpg',
                  fit: BoxFit.fill,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Sign In".text.size(40).bold.black.make(),
                        const SizedBox(
                          height: 20,
                        ),

                        // TODO Email TextFormField
                        Field(
                            hintText: "Enter Email", label: "Email",
                            controller: emailController, prefixIcon: Icon(Icons.email),),
                        const SizedBox(
                          height: 20,
                        ),

                        // TODO Password TextFormField
                        Field(
                          hintText: "Enter Password", label: "Password",
                          controller: passwordController, prefixIcon: Icon(Icons.lock),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            "FORGOT PASSWORD"
                                .text
                                .align(TextAlign.end)
                                .red500
                                .bold
                                .underline
                                .make().onInkTap(() {
                                  Navigator.pushNamed(context, RoutesName.forgotPasswordScreen);
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // TODO Login Button
                        RoundButton(
                            text: "Login",
                            textColor: Colors.white,
                            color: Colors.red,
                            loading: loading,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                 setState(() {
                                   loading = true;
                                 });
                                _auth.signInWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password: passwordController.text.toString()).then((value) {
                                      setState(() {
                                        loading = false;
                                      });
                                  Utils().toastMassage("Login Successfully");
                                  Navigator.pushNamed(context, RoutesName.home);
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    loading = false;
                                  });
                                  Utils().toastMassage(error.toString());
                                });
                              }
                            }),

                        const SizedBox(
                          height: 10,
                        ),
                        "OR".text.bold.size(16).make().centered(),
                        const SizedBox(
                          height: 10,
                        ),

                        // TODO Login With Google
                        RoundButton(
                          text: "Login With Google",
                          onPress: () {},
                          textColor: Colors.black,
                          borderSide: const BorderSide(color: Colors.black),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Don't have an Account? ".text.bold.make(),
                            // TODO Sign Up Button
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesName.SignUp);
                                },
                                child:
                                    "Sign Up".text.underline.bold.red600.make())
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
