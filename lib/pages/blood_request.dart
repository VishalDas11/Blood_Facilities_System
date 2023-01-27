import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/DropDownTextField.dart';
import '../component/RoundButton.dart';
import '../component/TextField.dart';
import '../utils/toastMassage.dart';

class BloodRequest extends StatefulWidget {
  const BloodRequest({Key? key}) : super(key: key);

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {

  final namecontroller = TextEditingController();
  final phonenumbercontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final bgcontroller = SingleValueDropDownController();
  bool loading = false;

  final _formkey = GlobalKey<FormState>();

  final _firestore = FirebaseFirestore.instance.collection('BloodRequestForm');

  final _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    namecontroller;
    phonenumbercontroller;
    addresscontroller;
    bgcontroller;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Blood Request"),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black,)),
        backgroundColor: Colors.white,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          //     TODO Blood Request Form
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                "Blood Request".text.bold.align(TextAlign.start).size(30).color(Colors.black).make(),

                // TODO Name Field
                const SizedBox(height: 40,),
                Field(hintText: "Enter Name", label: "NAME",  controller: namecontroller,),

                // TODO Phone Number
                const SizedBox(height: 20,),
                Field(hintText: "Enter Phone Number", label: "PHONE NUMBER", controller: phonenumbercontroller,),

                // TODO  Address
                const SizedBox(height: 20,),
                Field(hintText: "Enter Address", label: "ADDRESS",  controller: addresscontroller,),

                const SizedBox(height: 20,),
                DropDown(hinttext: "Blood Group",controller: bgcontroller),

                const SizedBox(height: 40,),
                RoundButton(text: "Submit", color: Colors.red, loading: loading,textColor: Colors.white,onPress: () {
                  if(_formkey.currentState!.validate()){
                    setState(() {
                      loading= true;
                    });

                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    String id= DateTime.now().microsecondsSinceEpoch.toString();
                    _firestore.doc(id).set({
                      'Name' : namecontroller.text,
                      "Phone Number" : phonenumbercontroller.text,
                      "Address" : addresscontroller.text,
                      'Blood Group' : bgcontroller.dropDownValue!.name
                    }).then((value){
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMassage("Request Add Successfully");

                      namecontroller.clear();
                      phonenumbercontroller.clear();
                      addresscontroller.clear();
                      bgcontroller.clearDropDown();

                    }).onError((error, stackTrace){
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMassage(error.toString());
                    });
                  }
                }, ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

