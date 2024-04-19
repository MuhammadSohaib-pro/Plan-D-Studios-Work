// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:kiosk/helper/theme_helper.dart';
// import 'package:kiosk/screens/home/lock/home_lock_viewmodel.dart';
// import 'package:kiosk/screens/home/unlock/home_unlock_view.dart';
// import 'package:kiosk/widgets/custom_buttons.dart';
// import 'package:kiosk/widgets/custom_textfields.dart';
// import 'package:kiosk/widgets/custom_tile.dart';
// import 'package:kiosk/widgets/scrollable_column.dart';

// import '../../adult_process/adultprocess/adult_process_view.dart';

// class HomeLockView extends StatelessWidget {
//   HomeLockView({super.key});

//   final HomeLockViewModel viewModel = Get.put(HomeLockViewModel());

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) => Scaffold(
//         appBar: AppBar(
//           title: lockAndMenuRow(),
//           toolbarHeight: 80,
//           automaticallyImplyLeading: false,
//         ),
//         body: ScrollableColumn(
//           children: [
//             SizedBox(height: 20),
//             bulletImage(),
//             SizedBox(height: 20),
//             gunRangeTile(),
//             SizedBox(height: 15),
//             axeTile(),
//             SizedBox(height: 15),
//             archeryTile(),
//             Expanded(child: SizedBox()),
//             poweredByRow(),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget lockAndMenuRow() {
//     return Row(
//       children: [
//         GestureDetector(
//           onTap: () {
//             unLockDialog();
//           },
//           child: Container(
//             margin: EdgeInsets.all(10),
//             height: 55,
//             width: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: ThemeColors.primaryColor,
//             ),
//             child: Icon(
//               Icons.lock,
//               color: ThemeColors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<dynamic> unLockDialog() {
//     return showDialog(
//       context: Get.context!,
//       builder: (context) {
//         return Dialog(
//           shape: UnderlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Container(
//             height: 202,
//             width: 315,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   height: 39,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                     color: ThemeColors.primaryColor,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.lock,
//                         size: 20,
//                         color: ThemeColors.white,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         "TYPE IN 4 DIGIT CODE",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: ThemeColors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(width: 30),
//                     CustomTextField(
//                       isEnabledBorder: true,
//                       onChanged: (value) {
//                         if (value.length == 1) {
//                           FocusScope.of(context).nextFocus();
//                           viewModel.concatPassword(value);
//                         } else {
//                           viewModel.deletingLastValue();
//                         }
//                       },
//                     ),
//                     CustomTextField(
//                       isEnabledBorder: true,
//                       onChanged: (value) {
//                         if (value.length == 1) {
//                           FocusScope.of(context).nextFocus();
//                           viewModel.concatPassword(value);
//                         } else {
//                           FocusScope.of(context).previousFocus();
//                           viewModel.deletingLastValue();
//                         }
//                       },
//                     ),
//                     CustomTextField(
//                       isEnabledBorder: true,
//                       onChanged: (value) {
//                         if (value.length == 1) {
//                           FocusScope.of(context).nextFocus();
//                           viewModel.concatPassword(value);
//                         } else {
//                           FocusScope.of(context).previousFocus();
//                           viewModel.deletingLastValue();
//                         }
//                       },
//                     ),
//                     CustomTextField(
//                       isEnabledBorder: true,
//                       onChanged: (value) {
//                         if (value.length == 1) {
//                           viewModel.concatPassword(value);
//                         } else {
//                           FocusScope.of(context).previousFocus();
//                           viewModel.deletingLastValue();
//                         }
//                       },
//                     ),
//                     SizedBox(width: 30),
//                   ],
//                 ),
//                 SizedBox(height: 12),
//                 CustomElevatedBtn(
//                   height: 50,
//                   width: 225,
//                   foregroundColor: Colors.grey,
//                   backgroundColor: ThemeColors.primaryColor,
//                   onPressed: () {
//                     Get.back();
//                     Get.back();
//                     Get.to(() => HomeUnlockView());
//                   },
//                   child: const Text(
//                     'UNLOCK',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget bulletImage() {
//     return Image.asset(
//       "assets/images/bullet.png",
//       height: 110,
//       width: 110,
//     );
//   }

//   Widget gunRangeTile() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: Get.context!.isTablet && Get.context!.isPortrait
//               ? Get.width / 5.5
//               : 0),
//       child: CustomTile1(
//         imageUrl: 'assets/svg/GunRange.svg',
//         title: "Gun Range Waiver",
//         ontap: () {
//           Get.to(() => AdultProcessView());
//         },
//         enabled: true,
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
//       ),
//     );
//   }

//   Widget axeTile() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: Get.context!.isTablet && Get.context!.isPortrait
//               ? Get.width / 5.5
//               : 0),
//       child: CustomTile1(
//         imageUrl: 'assets/svg/Axe.svg',
//         ontap: () {
//           Get.to(() => AdultProcessView());
//         },
//         enabled: true,
//         title: "Axe Throwing Waiver",
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
//       ),
//     );
//   }

//   Widget archeryTile() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: Get.context!.isTablet && Get.context!.isPortrait
//               ? Get.width / 5.5
//               : 0),
//       child: CustomTile1(
//         imageUrl: 'assets/svg/Archery.svg',
//         title: "Archery Waiver",
//         ontap: () {
//           Get.to(() => AdultProcessView());
//         },
//         enabled: true,
//         padding: EdgeInsets.symmetric(
//             horizontal:
//                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
//       ),
//     );
//   }

//   Widget poweredByRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Powered By"),
//         SizedBox(width: 10),
//         SvgPicture.asset(
//           'assets/svg/logo1.svg',
//           height: 25,
//         ),
//       ],
//     );
//   }
// }
