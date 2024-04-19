import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/screens/dashboard/dashboard_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';



class CompleteProfile5View extends StatelessWidget {
  const CompleteProfile5View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: successContainer(),
      ),
    );
  }

  Widget successContainer() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 35, bottom: 25),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              completeIcon(),
              // successTxt(),
              SizedBox(height: 20),
              congratulationTxt(),
              SizedBox(height: 20),
              backToDashboardBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget completeIcon() {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xff0C8A7B),
      ),
      child: const Icon(
        Icons.done_rounded,
        color: Color(0xffFFFFFF),
        size: 50,
      ),
    );
  }

  Widget successTxt() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Text(
        "Thank you !".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xff1A1D1E),
        ),
      ),
    );
  }

  Widget congratulationTxt() {
    return Text(
      '${"Profile completed. You are all set".tr}.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xff828A89),
      ),
    );
  }

  Widget backToDashboardBtn() {
    return CustomButton8(
      backgroundColor: const Color(0xff0C8A7B),
      text: "Go to Dashboard".tr,
      onPressed: () {
        Get.offAll(() => DashboardView());
      },
    );
  }
}
