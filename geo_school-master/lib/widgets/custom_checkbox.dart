
import 'package:flutter/material.dart';

class SimpleCheckBox extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged onChanged;

  SimpleCheckBox({required this.title, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onChanged,
          fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
          activeColor: Colors.white,
          checkColor: Color(0xff021110),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 11, fontFamily: 'Poppins-Regular', color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

