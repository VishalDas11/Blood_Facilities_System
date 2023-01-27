import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/DropDownTextField.dart';
import '../component/RoundButton.dart';
import '../component/TextField.dart';
import '../utils/toastMassage.dart';

class BloodDonate extends StatefulWidget {
  const BloodDonate({Key? key}) : super(key: key);

  @override
  State<BloodDonate> createState() => _BloodDonateState();
}

class _BloodDonateState extends State<BloodDonate> {
  final namecontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final bloodController = SingleValueDropDownController();
  final citycontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var lati;
  var longi;
  String address = '';
  bool loading = false;

  final _firestore = FirebaseFirestore.instance.collection('BloodDonateForm');


// TODO  Get Current Location
  Future<Position> getUserCurrentLocation () async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      if (kDebugMode) {
        print('Error $error');
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Blood Donate"),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black,)),
        elevation: 0,),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              "Donate Blood".text.bold.size(30).make(),
              "Add Request For Blood Donate".text.make(),
              const SizedBox(height: 30,),
              Form(
                key: _formkey,
                child: Center(
                  child: Column(

                    children: [
                      // TODO  Name Field
                      Field(hintText: "Enter Name", label:"NAME", controller: namecontroller,),
                      const SizedBox(height: 20,),

                      // TODO Phone Number Field
                      Field(hintText: "Enter Phone Number", label: "PHONE NUMBER", controller: phoneNumbercontroller),
                      const SizedBox(height: 20,),

                      Field(hintText: "Mirpurkhas", label: "CITY", controller: citycontroller),
                      const SizedBox(height: 20,),

                      DropDown(hinttext: "Blood Group", controller: bloodController,),
                      const SizedBox(height: 20,),

                      // TODO  Get Current Location

                      InkWell(
                        onTap: ()async{
                          await getUserCurrentLocation().then((value) async {
                            lati = value.latitude;
                            longi = value.longitude;
                            print(lati.toString());
                            print(longi.toString());

                            // List<Placemark> placemark = await placemarkFromCoordinates(value.latitude, value.longitude);
                            // address = "${placemark.reversed.last.street}, \n"
                            //     " ${placemark.reversed.last.locality}";
                            // " ${placemark.reversed.last.administrativeArea}";

                          });
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black38, width: 1)
                          ),
                          child: Text("Set Location", style: TextStyle(color: Colors.black87, fontSize: 16),),
                        ),
                      ),
                      const SizedBox(height: 80,),

                      // TODO  Submit Form
                      RoundButton(text: "Submit",loading: loading, textColor: Colors.white, color: Colors.red, onPress: (){

                        if(_formkey.currentState!.validate()){
                            setState(() {
                              loading = true;
                            });
                            String uid = DateTime.now().microsecondsSinceEpoch.toString();
                           _firestore.doc(uid).set({
                             'Name' : namecontroller.text,
                             'Phone Number' : phoneNumbercontroller.text,
                             'City' : citycontroller.text,
                             "Blood Group": bloodController.dropDownValue!.name,
                             'latitude' : lati.toString(),
                             'longitude' : longi.toString()
                           }).then((value){
                             setState(() {
                               loading = false;
                             });
                             Utils().toastMassage("Submit Successfully");
                              namecontroller.clear();
                              phoneNumbercontroller.clear();
                              citycontroller.clear();
                              bloodController.clearDropDown();
                           }).onError((error, stackTrace){
                             setState(() {
                               loading = false;
                             });
                             Utils().toastMassage(error.toString());
                           });
                        }
                      })
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
