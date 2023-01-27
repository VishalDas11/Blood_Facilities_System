
import 'package:blood/GoogleMap/current_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/Routes/routes_name.dart';

class BloodDonaterList extends StatefulWidget {
  const BloodDonaterList({Key? key,}) : super(key: key,);

  @override
  State<BloodDonaterList> createState() => _BloodDonaterListState();
}

class _BloodDonaterListState extends State<BloodDonaterList> {

  final firestore = FirebaseFirestore.instance.collection('BloodDonateForm').snapshots();

  // final uid = FirebaseFirestore.instance.collection('Userdata').doc().collection('BloodRequestForm')

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Blood Donar Users".text.color(Colors.black).make().centered(),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black54,)),
      ),

      body: Column(
        children: [
          SizedBox(height: 10,),
          StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: Colors.black26,),);
                }
                if(snapshot.hasError){
                  return const Text("Error");
                }
                if(!snapshot.hasData){
                  return const Center(child: Text("No Data"),);
                }
                return  Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              minVerticalPadding: 15,

                              leading: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/person.png'),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white30, width: 2)
                                    ),
                                    child: "${snapshot.data!.docs[index]['Blood Group'].toString()} ".text.red500.bold.size(6).make().centered(),
                                  ).positioned(left: 40, top: 30),
                                ],
                              ),

                              title: snapshot.data!.docs[index]['Name'].toString().text.size(18).make().pOnly(left: 10),

                              subtitle: Row(
                                children: [
                                  Icon(Icons.location_on_outlined, color: Colors.red, size: 20,),
                                  SizedBox(width: 5,),
                                  // userdata['Address']
                                  // snapshot.data!.docs[index]['Address'].toString().text.make()

                                ],
                              ).centered().pOnly(left: 10,top: 5),

                              trailing:Column(
                                children: [
                                  // Container(
                                  //   width: 50,
                                  //   height: 50,
                                  //   decoration: BoxDecoration(
                                  //       color:  Colors.green[300],
                                  //       shape: BoxShape.circle,
                                  //       border: Border.all(color: Colors.green, width: 3)
                                  //   ),
                                  //   child: Center(child: Icon(Icons.call, color: Colors.black,)),
                                  // ),
                                  // SizedBox(height: 5,),
                                  Container(
                                    width: 80,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color:  Colors.green,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.greenAccent)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.call),
                                        const SizedBox(width: 5,),
                                        "Call".text.make()
                                      ],
                                    ).pSymmetric(h: 5),
                                  ),
                                  SizedBox(height: 5,),

                                  Container(
                                    width: 80,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color:  Colors.pink,
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.pink)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.location_on_outlined),
                                        const SizedBox(width: 5,),
                                        "Map".text.make().onInkTap(() {
                                          var a = double.parse(snapshot.data!.docs[index]['latitude']);
                                          var b = double.parse(snapshot.data!.docs[index]['longitude']);
                                          print(a);
                                          print(b);

                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GetLocation(latitude: a, longitude: b)));
                                        })
                                      ],
                                    ).pSymmetric(h: 5),
                                  ),

                                ],
                              ),
                              isThreeLine: true,

                            ),
                          ),
                        );

                      }),
                );

              }),
        ],
      ),
    );
  }
}
