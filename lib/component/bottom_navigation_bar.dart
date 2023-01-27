// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// import 'app_color.dart';
//
// class BottomNaviagtionBar1 extends StatefulWidget {
//   const BottomNaviagtionBar1({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNaviagtionBar1> createState() => _BottomNaviagtionBar1State();
// }
//
// class _BottomNaviagtionBar1State extends State<BottomNaviagtionBar1> {
//
//   final controller= PersistentTabController(initialIndex: 0);
//
//   List<Widget> _buildScreen(){
//     return [
//       Text('Home'),
//       Text('2'),
//       Text('3'),
//       Text('4'),
//       Text('5')
//     ];
//   }
//
//   List<PersistentBottomNavBarItem>  _navBarItem(){
//     return [
//       PersistentBottomNavBarItem(icon: Icon(Icons.home)),
//       PersistentBottomNavBarItem(icon: Icon(Icons.home)),
//       PersistentBottomNavBarItem(icon: Icon(Icons.home)),
//       PersistentBottomNavBarItem(icon: Icon(Icons.home)),
//       PersistentBottomNavBarItem(icon: Icon(Icons.home)),
//
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       screens: _buildScreen(),
//       items: _navBarItem(),
//       backgroundColor: AppColor.bgColor,
//
//     );
//   }
// }
