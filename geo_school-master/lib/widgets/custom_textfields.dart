import 'package:flutter/material.dart';

class CustomTextField13 extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final Color textColor;
  final bool? showCursor;
  final bool readOnly;
  final String? hintText;
  final Widget? prefixIcon;
  final Color fillColor;
  static const Color fillColorDefaultValue = Color(0xffF0F0F0);
  final ValueChanged<String>? onChanged;

  CustomTextField13(
      {this.validator,
      this.obscureText = false,
      this.autovalidateMode,
      this.title,
      this.controller,
      this.keyboardType,
      this.maxLines = 1,
      this.minLines,
      this.showCursor,
      this.readOnly = false,
      this.hintText,
      this.fillColor = fillColorDefaultValue,
      this.prefixIcon,
      this.textColor = Colors.black54,
      this.onChanged,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Container(
                margin: EdgeInsets.only(bottom: 3, left: 2),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins-Regularr',
                    color: Color(0xff999999),
                  ),
                ),
              ),
        TextFormField(
          focusNode: focusNode,
          onChanged: onChanged,
          showCursor: showCursor,
          readOnly: readOnly,
          minLines: minLines,
          maxLines: maxLines,
          autovalidateMode: autovalidateMode,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(
            fontFamily: 'Poppins-Regular',
            color: textColor,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins-Regular',
              color: Color(0xff999999),
              fontSize: 14,
            ),
            isDense: true,
            fillColor: fillColor,
            filled: true,
            contentPadding: EdgeInsets.fromLTRB(15, 17, 6.5, 17),
          ),
          controller: controller,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
