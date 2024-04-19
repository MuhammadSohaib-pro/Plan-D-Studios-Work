import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/widgets/widget_models/dropdown_model.dart';

class CustomDropDownList1 extends StatelessWidget {
  final String? title;
  final bool asterisk;
  final RxString value;
  final ValueChanged? onChanged;
  final List<DropDownModel> list;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;

  CustomDropDownList1({
    this.title,
    required this.value,
    required this.onChanged,
    required this.list,
    this.asterisk = false,
    this.validator,
    this.autoValidateMode,
    this.labelText,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 8.5, 10, 8.5),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 1),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.blueGrey
                          : const Color(0xff101817),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,

                    ),
                    children: [
                      (asterisk)
                          ? TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            )
                          : TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        Obx(
          () => DropdownButtonFormField(
            dropdownColor:
                context.isDarkMode ? Colors.blueGrey : const Color(0xffFFFFFF),
            decoration: InputDecoration(
              contentPadding: contentPadding,
            ),
            autovalidateMode: autoValidateMode,
            focusColor: Color(0xffFFFFFF),
            iconEnabledColor: Color(0xffB0B6B6),
            borderRadius: BorderRadius.circular(10.0),
            style: const TextStyle(

              color: Color(0xff828A89),
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
            validator: validator,
            iconSize: 20,
            value: value.value,
            isExpanded: true,
            onChanged: onChanged,
            items: list.map(
              (DropDownModel dropDownItem) {
                return DropdownMenuItem<String>(
                  value: dropDownItem.name,
                  child: Text(dropDownItem.name!),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
