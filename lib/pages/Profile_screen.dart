
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../component/RoundButton.dart';
import '../utils/toastMassage.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firestore = FirebaseFirestore.instance.collection('Userdata').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('Userdata');

  final id = FirebaseAuth.instance.currentUser!.uid;

  late String name;
  late String email;
  late String city;

  final citycontroler = TextEditingController();
  final phoneNumcontroller = TextEditingController();
  final namecontroller  = TextEditingController();
  final emailcontroler = TextEditingController();

  final editController=  TextEditingController();

  // Future<void> showDialogBox(String controller)async{
  //   editController.text = controller;
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           title: Text("Update Value"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: [
  //                 TextFormField(
  //                   controller: emailcontroller,
  //                   decoration: InputDecoration(
  //                       hintText: "Enter New Name"
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(onPressed: (){
  //                   ref.doc(id).update({
  //                     'Name' : editController.text.toString()
  //                   }).then((value){
  //                     Utils().toastMassage("Update Successfully");
  //                     Navigator.pop(context);
  //                   }).onError((error, stackTrace){
  //                     Utils().toastMassage(error.toString());
  //                   });
  //             }, child: Text("Save")),
  //             TextButton(onPressed: (){
  //               Navigator.pop(context);
  //             }, child: Text("Cancel"))
  //           ],
  //         );
  //       });
  // }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/person.png'),

                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 2,),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5
                        )
                      ]

                  ),
                  child: Icon(Icons.edit),
                ).positioned(left: 260, top: 110),
              ],
            ),
            SizedBox(height: 30,),
            "Vishal Das".text.size(32).fontWeight(FontWeight.w500).make(),
            SizedBox(height: 10,),
            "Mirpurkhas".text.size(20).fontWeight(FontWeight.w500).make(),

           StreamBuilder<DocumentSnapshot>(
             stream: ref.doc(id).snapshots(),
               builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                 return Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: [
                       // Container(
                       //   width: MediaQuery.of(context).size.width,
                       //   height: 50,
                       //   decoration: BoxDecoration(
                       //     border: Border.all(color: Colors.black)
                       //   ),
                       //
                       //   child: Text(snapshot.data!['Name'].toString()),
                       // ),
                       // SizedBox(height: 50,),
                       // Container(
                       //   width: MediaQuery.of(context).size.width,
                       //   height: 50,
                       //   decoration: BoxDecoration(
                       //       border: Border.all(color: Colors.black)
                       //   ),
                       //   child: Text(snapshot.data!['Email'].toString()),
                       // ),
                       // SizedBox(height: 50,),
                       // Container(
                       //   width: MediaQuery.of(context).size.width,
                       //   height: 50,
                       //   decoration: BoxDecoration(
                       //       border: Border.all(color: Colors.black)
                       //   ),
                       //   child: Text(snapshot.data!['City'].toString()),
                       // ),

                       TextFormField(
                         controller: namecontroller,
                         decoration: InputDecoration(
                             hintText: "${snapshot.data!['Name'].toString()}",
                             hintStyle: TextStyle(color: Colors.red)
                         ),
                       ),
                       SizedBox(height: 20,),
                       TextFormField(
                         controller: emailcontroler,
                         decoration: InputDecoration(
                             hintText: snapshot.data!['Email'].toString(),
                             hintStyle: TextStyle(color: Colors.red)
                         ),
                       ),
                       SizedBox(height: 20,),
                       TextFormField(
                         controller: citycontroler,
                         initialValue: snapshot.data!['City'].toString(),
                         decoration: InputDecoration(
                             // hintText: snapshot.data!['City'].toString(),
                             // hintStyle: TextStyle(color: Colors.red)
                         ),
                       ),
                       SizedBox(height: 20,),
                       TextFormField(
                         controller: phoneNumcontroller,
                         decoration: InputDecoration(
                             hintText: snapshot.data!['PhoneNumber'].toString(),
                             hintStyle: TextStyle(color: Colors.red)
                         ),
                       ),
                       SizedBox(height: 80,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           ElevatedButton(onPressed: (){
                             ref.doc(id).update({
                               // 'Name' : namecontroller.text,
                               // 'Email' : emailcontroller.text,
                               'City' : citycontroler.text,
                               'PhoneNumber' : phoneNumcontroller.text
                             }).then((value){
                               Utils().toastMassage('Update Successfully');
                             }).onError((error, stackTrace){
                               Utils().toastMassage(error.toString());
                             });
                           }, child: Text('Save')),
                           ElevatedButton(
                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
                             onPressed: (){}, child: Text('close'),
                           
                           )
                           // RoundButton(text: 'Save', onPress: () {  }, color: Colors.blue,),
                           // RoundButton(text: "Cancel", onPress: (){},)
                         ],
                       ),
                     ],
                   ),
                 );
           })

          ],
        ),
      )
    );
  }

}


