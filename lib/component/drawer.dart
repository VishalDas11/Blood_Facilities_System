import 'package:blood/utils/Routes/routes_name.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.red
              ),
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.all(0),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/person.png')
                ),
                accountName: Text("Vishal Das"),
                accountEmail: Text("vdas4088@gmail.com"),
            )
            ),

            Tile(title: 'Home', icon: 'assets/icon/home.png', onpress: (){
              Navigator.pushNamed(context, RoutesName.home);
            },),

            Tile(title: 'Blood Donated Form', icon: 'assets/icon/blood-drop.png', onpress: (){
              Navigator.pushNamed(context, RoutesName.bloodDonate);
            },),

            Tile(title: 'Add Request Form', icon: 'assets/icon/add-request.png', onpress: (){
              Navigator.pushNamed(context, RoutesName.bloodRequest);
            },),

            Tile(title: 'User Request List', icon: 'assets/icon/request.png', onpress: (){
              Navigator.pushNamed(context, RoutesName.bloodRequestList);
            },),

            Tile(title: 'Donor List', icon: 'assets/icon/reminder.png', onpress: (){
              Navigator.pushNamed(context, RoutesName.bloodDonaterList);
            },),

            Tile(title: 'Logout', icon: 'assets/icon/logout.png',onpress: (){
              Navigator.pushNamed(context,RoutesName.login);
            },),
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.title,
    this.onpress,  required this.icon,
  }) : super(key: key, );

  final String title;
  final VoidCallback? onpress;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(icon, width: 25, height: 25, color: Colors.red,  ) ,
      title: Text(title ,style: TextStyle( fontSize: 14, color: Colors.red),),
      onTap: onpress,
    );
  }
}
