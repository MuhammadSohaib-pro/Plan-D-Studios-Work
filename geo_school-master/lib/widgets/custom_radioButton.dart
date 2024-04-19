import 'package:flutter/material.dart';

class CustomRadioButton1 extends StatelessWidget {
  final String title;
  final String value;
  final ValueChanged onChanged;
  final String? groupValue;

  CustomRadioButton1(
      {required this.title,
      required this.value,
      required this.onChanged,
      this.groupValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: Color(0xff023330),
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Regularr',
            color: Color(0xff999999),
          ),
        ),
      ],
    );
  }
}
