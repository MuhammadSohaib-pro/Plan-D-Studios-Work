import 'package:flutter/material.dart';
import 'package:taqat/helper/theme_helper.dart';

class SimpleCheckBox extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged onChanged;

  const SimpleCheckBox(
      {super.key, required this.title, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onChanged,
          fillColor: MaterialStatePropertyAll(ThemeColors.mainColor),
          activeColor: Colors.white,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 2,
            style: const TextStyle(
                fontSize: 13,
                color: Color(0xff828A89),
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
