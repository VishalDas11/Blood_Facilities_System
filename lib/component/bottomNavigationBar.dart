import 'package:blood/utils/Routes/routes_name.dart';
import 'package:flutter/material.dart';

import '../pages/Profile_screen.dart';


class BottomNaviagtion extends StatefulWidget {
  const BottomNaviagtion({Key? key}) : super(key: key);

  @override
  State<BottomNaviagtion> createState() => _BottomNaviagtionState();
}

class _BottomNaviagtionState extends State<BottomNaviagtion> {
  int _currenIndex =0 ;

  List<int> list = [0,1,2,3];

  void Tap(list){
    setState(() {
      _currenIndex = list;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.home);
              },
                child: Image.asset('assets/icon/home.png', width: 25, height: 25, color: Colors.red,)
            ),
            ),

          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.bloodRequestList);
                },
                child: Image.asset('assets/icon/reminder.png', width: 25, height: 25,color: Colors.red,)),
            label: "Add", ),


          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.bloodDonaterList);
                },
                child: Image.asset('assets/icon/bell.png', width: 25, height: 25,color: Colors.red,)),
                label: "Star", ),


          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
              },
              child: Image.asset('assets/icon/profile.png', width: 25, height: 25, color: Colors.red,)),
              label: "Profile",
          ),
        ],
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _currenIndex,
        onTap: Tap,

      ),
    );
  }
}
