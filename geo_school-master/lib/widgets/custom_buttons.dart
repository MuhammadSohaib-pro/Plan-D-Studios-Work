import 'package:flutter/material.dart';

class CustomButton8 extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  CustomButton8(
      {required this.text, this.backgroundColor, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey[300],
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Roboto-Regular',
            fontSize: 14,
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
