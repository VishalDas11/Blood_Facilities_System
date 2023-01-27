import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../component/DropDownTextField.dart';
import '../../component/RoundButton.dart';
import '../../component/TextField.dart';
import '../../utils/Routes/routes_name.dart';
import '../../utils/toastMassage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final bloodController = SingleValueDropDownController();

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('Userdata');

  // TODO     Register Button Functionality
  register(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading =true;
      });
      String uid = DateTime.now().microsecondsSinceEpoch.toString();
      _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString()).then((value){

        _firestore.doc(uid).set({
          "Name": nameController.text,
          "Email": emailController.text,
          "PhoneNumber": phoneNumberController.text,
          "City": cityController.text,
          "Blood Group": bloodController.dropDownValue!.name,
        });
      }).then((value){
        Navigator.pushNamed(context, RoutesName.login);
        Utils().toastMassage('Register Successfully');
        setState(() {
          loading= false;
        });
      }).onError((error, stackTrace){
        Utils().toastMassage(error.toString());
      });
    }
  }
  @override
  void dispose(){
    super.dispose();
    nameController;
    passwordController;
    phoneNumberController;
    cityController;
    emailController;
    bloodController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          //  TODO Register Form
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                "Register ".text.bold.size(40).black.make(),
                const SizedBox(height: 30),

                // TODO Name TextFormField
                Field(hintText: "Enter Name", label: "Name", controller: nameController, prefixIcon: Icon(Icons.person),),
                const SizedBox(height: 25,),

                // TODO Email TextFormField
                Field(hintText: "Enter Email", label: "Email", controller: emailController, prefixIcon: Icon(Icons.email),),
                const SizedBox(height: 25,),

                // TODO Phone Number TextFormField
                Field(hintText: "Enter Phone Number", label: "Phone Number", controller: phoneNumberController, prefixIcon: Icon(Icons.call),),
                const SizedBox(height: 25,),

                // TODO City TextFormField
                Field(hintText: "Enter City", label: "City",controller: cityController, prefixIcon: Icon(Icons.location_city_outlined),),
                const SizedBox(height: 25,),

                // TODO Password TextFormField
                Field(hintText: "Enter Password", label: "Password",controller: passwordController, suffixIcon: Icon(Icons.visibility_off), obsecure: true, prefixIcon: Icon(Icons.lock) ,),
                const SizedBox(height: 25,),

                // TODO DropDownTextField
                DropDown(hinttext: "Blood Group", controller: bloodController,),
                const SizedBox(height: 40,),

                // TODO Sign Up Button
                RoundButton(
                    text: "Sign Up",
                    color: Colors.red,
                    textColor: Colors.white,
                    loading: loading,
                    onPress: () {
                      register();
                    }),
                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Already have an Account? ".text.bold.make(),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        child: "Login".text.bold.color(Colors.red).make())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
