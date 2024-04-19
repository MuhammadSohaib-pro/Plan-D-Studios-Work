import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/custom_buttons.dart';

class PaymentDoneView extends StatelessWidget {
  const PaymentDoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            imageAndTxtContainer(),
            doneBtn(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: Text(
        'Fee Slip'.tr,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Color(0xff1A1D1E),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget imageAndTxtContainer() {
    return Expanded(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image(),
            SizedBox(height: 15),
            paymentConfirmTxt(),
          ],
        ),
      ),
    );
  }

  Widget image() => Image.asset("assets/images/payment_confirm.png");

  Widget paymentConfirmTxt() {
    return Text(
      'Payment Confirmed'.tr,
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xff1A1D1E),
      ),
    );
  }

  Widget doneBtn() {
    return CustomButton8(
      text: "Done".tr,
      onPressed: () {},
      textColor: Colors.white,
      backgroundColor: Color(0xff0C8A7B),
    );
  }
}
