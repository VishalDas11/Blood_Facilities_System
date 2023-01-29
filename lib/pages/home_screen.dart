import 'package:blood/component/app_color.dart';
import 'package:blood/utils/toastMassage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/bottomNavigationBar.dart';
import '../component/drawer.dart';
import '../utils/BoxICon.dart';
import '../utils/Routes/routes_name.dart';
import '../utils/carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return false;
      },
      child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(title: "Blood Facilities System".text.color(AppColor.blackColor).make(),
             elevation: 0,
             backgroundColor: AppColor.bgColor,
             leading: Builder(
               builder: (BuildContext context){
                 return InkWell(
                     onTap: (){
                       Scaffold.of(context).openDrawer();
                     },
                     child: Icon(Icons.view_headline_sharp, color: Colors.black,));

               },
             ),

             actions: [
               InkWell(
                   onTap: (){
                     _auth.signOut().then((value){
                       Utils().toastMassage("Logout Successfully");
                       Navigator.pushNamed(context, RoutesName.login);
                     }).onError((error, stackTrace){
                       Utils().toastMassage(error.toString());
                     });
                   },
                   child: Icon(Icons.exit_to_app,color: Colors.black,)),
                   SizedBox(width: 10,),
             ],
          ),
              // drawer: MyDrawer(),

              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // TODO Carousel slides Widget
                      const CarouselImage(),
                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TODO Blood Request Box
                          BoxIcon(onPress: () {
                            Navigator.pushNamed(context, RoutesName.bloodRequest);
                            },
                            image: Image.asset('assets/icon/order.png', width: 70, height: 70,),
                            text: 'Blood Request Form',),
                          SizedBox(width: 10,),

                          //    TODO Blood Donate Box
                          BoxIcon(onPress: () {
                            Navigator.pushNamed(context, RoutesName.bloodDonate);
                          },
                            image: Image.asset('assets/icon/donate.png', width: 60, height: 60),
                            text: 'Blood Donate  Form',)
                        ],
                      ),

                          const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // TODO   Blood Request List Box
                          BoxIcon(onPress: (){
                            Navigator.pushNamed(context, RoutesName.bloodRequestList);
                          },
                            image: Image.asset('assets/icon/donator.png', width: 60, height: 60),
                            text: 'Request'),

                          SizedBox(width: 10,),

                          // TODO  Blood Donated List Box
                          BoxIcon(onPress: (){
                            Navigator.pushNamed(context, RoutesName.bloodDonaterList);
                          }, image: Image.asset('assets/icon/donor.png', width: 60, height: 60),
                            text: 'Donater list',)
                        ],
                      ),
                      // const SizedBox(height: 20,),
                    ],

                  ),
                ),
              ),

              bottomNavigationBar: BottomNaviagtion(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   onPressed: (){}, child: Icon(Icons.water_drop, color: Colors.red,),
        // ),


      ),
    );
  }
}


