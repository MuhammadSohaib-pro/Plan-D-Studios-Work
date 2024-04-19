// import '../../../helper/check_navigation.dart';
// import '../../../libraries.dart';

// class YesNoRadioBtnView extends StatelessWidget {
//   YesNoRadioBtnView({super.key});

//   final YesNoRadioBtnViewModel viewModel = Get.put(YesNoRadioBtnViewModel());

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => Scaffold(
//         appBar: appBar(),
//         body: ScrollableColumn(
//           crossAxisAlignment: Get.context!.isTablet && Get.context!.isLandscape
//               ? CrossAxisAlignment.center
//               : Get.context!.isTablet && Get.context!.isPortrait
//                   ? CrossAxisAlignment.center
//                   : CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment:
//                   Get.context!.isTablet && Get.context!.isPortrait
//                       ? CrossAxisAlignment.center
//                       : Get.context!.isLandscape
//                           ? CrossAxisAlignment.center
//                           : CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 yesOrNoTxt(),
//                 SizedBox(height: 20),
//                 yesNoRadioBtn(),
//                 SizedBox(height: 20),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget appBar() {
//     return AppBar(
//       title: forwordBackBtnRow(),
//       toolbarHeight: 80,
//       automaticallyImplyLeading: false,
//     );
//   }

//   Widget forwordBackBtnRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: Container(
//             margin: EdgeInsets.all(10),
//             height: 55,
//             width: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: ThemeColors.grey2,
//             ),
//             child: Icon(
//               Icons.arrow_back,
//               color: ThemeColors.white,
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigation.checknavigation();
//           },
//           child: Container(
//             margin: EdgeInsets.all(10),
//             height: 55,
//             width: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: ThemeColors.grey2,
//             ),
//             child: Icon(
//               Icons.arrow_forward,
//               color: ThemeColors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget yesOrNoTxt() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal:
//               Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
//       child: Text(
//         "YES OR NO",
//         style: TextStyle(
//           fontSize: 18,
//           color: ThemeColors.primaryColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget yesNoRadioBtn() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal:
//               Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
//       child: SizedBox(
//         width: Get.context!.isTablet && Get.context!.isLandscape
//             ? Get.width / 3
//             : double.infinity,
//         child: Obx(
//           () => Row(
//             mainAxisAlignment: Get.context!.isTablet && Get.context!.isPortrait
//                 ? MainAxisAlignment.center
//                 : Get.context!.isLandscape
//                     ? MainAxisAlignment.center
//                     : MainAxisAlignment.start,
//             children: [
//               Radio(
//                 value: "YES",
//                 groupValue: viewModel.groupValue.value,
//                 onChanged: (value) {
//                   viewModel.groupValue.value = value!;
//                   Navigation.checknavigation();
//                 },
//               ),
//               SizedBox(width: 20),
//               Text(
//                 "YES",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(width: 20),
//               Radio(
//                 value: "NO",
//                 groupValue: viewModel.groupValue.value,
//                 onChanged: (value) {
//                   viewModel.groupValue.value = value!;
//                   Navigation.checknavigation();
//                 },
//               ),
//               SizedBox(width: 20),
//               Text(
//                 "NO",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
