import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({Key? key,
    required this.text,
    this.color,
    required this.onPress,
    this.textColor,
    this.borderSide,
    this.loading = false,
    }) : super(key: key);

  final String text;
  final Color? textColor;
  final Color? color;
  final VoidCallback onPress;
  final BorderSide? borderSide;
  final bool loading;


  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          maximumSize: MaterialStateProperty.all(Size.fromHeight(45)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          side: MaterialStateProperty.all(borderSide)
      ),
      onPressed: onPress,
      child: Center(child: loading? CircularProgressIndicator(color: Colors.grey): Text(text, style: TextStyle( color: textColor,fontSize: 18),))
    );
  }
}
