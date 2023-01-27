import 'dart:async';
import 'package:blood/pages/home_screen.dart';
import 'package:blood/utils/Routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/toastMassage.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key,
    required this.name,
    required this.email,
    required this.city,
    required this.blood,
    required this.phoneNumber,
    required this.password}) : super(key: key);

  final String name;
  final String email;
  final String city;
  final String blood;
  final String phoneNumber;
  final String password;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {

  bool loading = false;
  bool isEmailVerified = false;
  late Timer timer;
  bool canResendEmail = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('Userdata');

  @override
  void initState(){
    super.initState();
    sendVerificationEmail();
   // isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(isEmailVerified){
      _auth.createUserWithEmailAndPassword(
          email: widget.email,
          password: widget.password).then((value){
        _firestore.doc(value.user!.uid).set({
          'Name': widget.name,
          'Email': widget.email,
          'City': widget.city,
          'BloodGroup' : widget.blood,
          'PhoneNumber': widget.phoneNumber
        }).then((value){
          Utils().toastMassage('Data has been stored');
          Navigator.pushNamed(context, RoutesName.login);
        }).onError((error, stackTrace){
          Utils().toastMassage(error.toString());
        });
      });

          }

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      CheckEmailVerified();
    });
  }

  Future sendVerificationEmail () async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });



    }
    catch(e){
      Utils().toastMassage(e.toString());
    }
  }

  Future CheckEmailVerified()async{
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified  = FirebaseAuth.instance.currentUser as bool;
    });

    if(isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const HomeScreen() : Scaffold(
      appBar: AppBar(title: const Text("Verify Email"), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text("Email has been sent in your email",
            style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40,),
            ElevatedButton.icon(
                onPressed: (){
                  canResendEmail ? sendVerificationEmail() : null;
                }, icon: Icon(Icons.email), label: Text("Resend Email")
            ),
            const SizedBox(height: 20,),

            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: const Text("Cancel"))
          ],
        ),
      ),
    );
    
  }
}
