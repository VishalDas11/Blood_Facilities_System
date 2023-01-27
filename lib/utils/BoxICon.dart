import 'package:flutter/material.dart';

class BoxIcon extends StatefulWidget {
  const BoxIcon(

      {Key? key,
        required this.onPress,
        required this.text,
        required this.image})
      : super(key: key);

  final Image image;
  final VoidCallback onPress;
  final String text;

  @override
  State<BoxIcon> createState() => _BoxIconState();
}

class _BoxIconState extends State<BoxIcon> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1 / 3.4,
        height: MediaQuery.of(context).size.height * 1 / 6,
        child: InkWell(
            onTap: widget.onPress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                widget.image,

                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            )),
      ),
    );
  }
}
