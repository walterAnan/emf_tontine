
import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final double verticalPadding;
  final double horizontalPadding;
  final double horizontalMargin;
  final String text;
  final FontWeight? fontWeight;
  final Color? shadowColor;
  final Function onTap;

  const Button({
    Key? key,
    this.verticalPadding = 20,
    this.horizontalPadding = 80,
    this.horizontalMargin = 50,
    required this.text,
    this.fontWeight,
    this.shadowColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(
            vertical: verticalPadding * 0.8,
            horizontal: horizontalPadding * 0.9,
          )
        ),
        elevation: MaterialStateProperty.all(8),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        shadowColor: MaterialStateProperty.all(shadowColor),
      ),

      child: Text(
        text,
      ),
      onPressed: () {
        onTap();
      },
    );
  }
}

