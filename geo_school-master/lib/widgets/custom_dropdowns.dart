import 'package:flutter/material.dart';
import 'package:geo_school/screens/form/dropdown_model.dart';
import 'package:get/get.dart';

class CustomDropDownList1 extends StatelessWidget {
  final String title;
  final String? value;
  final ValueChanged onChanged;
  final List<DropDownModel> list;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;

  CustomDropDownList1(
      {required this.title,
      this.value,
      required this.onChanged,
      required this.list,
      this.validator,
      this.autovalidateMode,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins-Regularr',
              color: Color(0xff999999),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 2),
          child: Obx(
            () => DropdownButtonFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.8, color: Color(0xff023330)),
                ),
              ),
              autovalidateMode: autovalidateMode,
              validator: validator,
              iconSize: 30.0,
              isExpanded: true,
              value: value,
              style: TextStyle(
                  fontSize: 16, color: Colors.black, fontFamily: 'Mulish6'),
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
        ),
      ],
    );
  }
}

// class CustomDropDownList2 extends StatelessWidget {
//   final String title;
//   final String value;
//   final ValueChanged onChanged;
//   final List<String> list;
//   final FormFieldValidator<String> validator;
//   final AutovalidateMode autovalidateMode;
//
//   CustomDropDownList2(
//       {this.title,
//       this.value,
//       this.onChanged,
//       this.list,
//       this.validator,
//       this.autovalidateMode});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 20.0),
//           child: Text(
//             title,
//             style: TextStyle(
//                 fontFamily: 'Mulish3', fontSize: 14, color: Colors.black),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 5),
//           child: DropdownButtonFormField(
//             decoration: InputDecoration(
//               contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
//               border: OutlineInputBorder(
//                 borderSide: BorderSide(width: 0.8),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 0.8, color: Color(0xff023330)),
//               ),
//             ),
//             autovalidateMode: autovalidateMode,
//             validator: validator,
//             iconSize: 30.0,
//             isExpanded: true,
//             value: value,
//             style: TextStyle(
//                 fontSize: 16, color: Colors.black, fontFamily: 'Mulish6'),
//             onChanged: onChanged,
//             items: list.map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
