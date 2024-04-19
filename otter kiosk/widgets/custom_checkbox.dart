import 'package:flutter/material.dart';
import 'package:kiosk/helper/theme_helper.dart';

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
          fillColor: MaterialStatePropertyAll(ThemeColors.primaryColor),
          activeColor: Colors.white,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(
          title,
          maxLines: 3,
          style: const TextStyle(
              fontSize: 16,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class SimpleCheckBox2 extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged onChanged;

  const SimpleCheckBox2(
      {super.key, required this.title, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          value: value,
          onChanged: onChanged,
          fillColor: MaterialStatePropertyAll(ThemeColors.primaryColor),
          activeColor: Colors.white,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: Text(
            title,
            maxLines: 5,
            style: const TextStyle(
                fontSize: 14,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
