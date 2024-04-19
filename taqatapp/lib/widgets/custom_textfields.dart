import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taqat/helper/global_variables.dart';

class CustomTextField13 extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final Color textColor;
  final bool? showCursor;
  final bool readOnly;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Color fillColor;
  final List<TextInputFormatter> inputFormatter;
  static const Color fillColorDefaultValue = Color(0xffF0F0F0);
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const CustomTextField13(
      {super.key,
      this.onTap,
      this.validator,
      this.obscureText = false,
      this.autoValidateMode,
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
      this.sufixIcon,
      this.textColor = Colors.black54,
      this.onChanged,
      this.focusNode,
      this.inputFormatter = const <TextInputFormatter>[]});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Container(
                margin: EdgeInsets.only(
                    bottom: 3,
                    left: (GlobalVariables.isLanguageChanged) ? 0 : 2,
                    right: (GlobalVariables.isLanguageChanged) ? 2 : 0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff101817),
                  ),
                ),
              ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: focusNode,
          onChanged: onChanged,
          showCursor: showCursor,
          readOnly: readOnly,
          minLines: minLines,
          maxLines: maxLines,
          onTap: onTap,
          autovalidateMode: autoValidateMode,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: inputFormatter,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Color(0xff999999),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            isDense: true,
            fillColor: fillColor,
            filled: true,
            suffixIcon: sufixIcon,
            contentPadding: EdgeInsets.fromLTRB(
                GlobalVariables.isLanguageChanged ? 0 : 13,
                17,
                GlobalVariables.isLanguageChanged ? 13 : 0,
                17),
          ),
          controller: controller,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

class countryFlagNumberTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialvalue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<CountryCode>? onChanged;
  final bool? showCursor;
  final bool readOnly;
  final bool enabled;

  countryFlagNumberTextField(
      {this.validator,
      this.autovalidateMode,
      this.controller,
      this.initialvalue,
      this.keyboardType,
      this.onChanged,
      this.showCursor,
      this.readOnly = false,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: showCursor,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'\d')),
      ],
      style: TextStyle(
          fontFamily: 'Montserrat-Regular',
          color: Color(0xff272727),
          fontSize: 14,
          fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        fillColor: Colors.white,
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(1, 1, 10, 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    (GlobalVariables.isLanguageChanged) ? 0 : 10),
                bottomLeft: Radius.circular(
                    (GlobalVariables.isLanguageChanged) ? 0 : 10),
                topRight: Radius.circular(
                    (GlobalVariables.isLanguageChanged) ? 10 : 0),
                bottomRight: Radius.circular(
                    (GlobalVariables.isLanguageChanged) ? 10 : 0),
              ),
            ),
            child: CountryCodePicker(
              enabled: enabled,
              onChanged: onChanged,
              flagWidth: 25,
              initialSelection: initialvalue,
              showFlagDialog: true,
              showDropDownButton: true,
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
          ),
        ),
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(
            (GlobalVariables.isLanguageChanged) ? 6.5 : 0,
            12,
            (GlobalVariables.isLanguageChanged) ? 0 : 6.5,
            12),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}

class countryFlagTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final ValueChanged<CountryCode>? onChanged;
  final bool asterisk;
  final String? title;

  countryFlagTextField(
      {this.validator,
      this.autoValidateMode,
      this.controller,
      this.initialValue,
      this.keyboardType,
      this.onChanged,
      this.title,
      this.asterisk = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff101817),
                  ),
                  children: [
                    (asterisk)
                        ? TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red, fontSize: 16.0),
                          )
                        : TextSpan(text: '')
                  ],
                ),
              ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xffFFFFFF),
          ),
          child: CountryCodePicker(
            onChanged: onChanged,
            initialSelection: initialValue,
            textStyle: TextStyle(
              color: const Color(0xff828A89),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            showCountryOnly: true,
            showOnlyCountryWhenClosed: true,
            alignLeft: true,
            flagWidth: 32,
            showDropDownButton: true,
          ),
        ),
      ],
    );
  }
}
