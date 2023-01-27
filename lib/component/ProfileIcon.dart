import 'package:flutter/material.dart';

class IconInfo extends StatelessWidget {
  const IconInfo({Key? key, required this.Update, required this.text}) : super(key: key);
  final String Update;
  final String text;
  @override
  Widget build(BuildContext context) {

   return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.17,
        height: MediaQuery.of(context).size.height*0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Update, style: TextStyle(fontSize: 22),),
            Text(text, style: TextStyle(color: Colors.grey, fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
