import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/screens/forgot_password/step_2/forgot_password2_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class ForgotPassword2View extends StatelessWidget {
  ForgotPassword2View({super.key});

  final ForgotPassword2ViewModel viewModel =
      Get.put(ForgotPassword2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: appBar(),
          body: SafeArea(
            child: ScrollableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                otpVerificationTxt(),
                enterTheVerificationTxt(),
                pinInputTxtFields(),
                verifyBtn(),
                Spacer(),
                didntReceiveAndResendRow(),
              ],
            ),
          ),
        ),
        LoaderView()
      ],
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0.0,
      toolbarHeight: 100,
    );
  }

  Widget otpVerificationTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 5),
      child: Text(
        'OTP Verification',
        style: TextStyle(
          color: Color(0xFF101817),
          fontSize: 32,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
      ),
    );
  }

  Widget enterTheVerificationTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Text(
        'Enter the verification code we just sent on your email address.',
        style: TextStyle(
          color: Color(0xFF8390A1),
          fontSize: 16,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget pinInputTxtFields() {
    return Form(
      key: viewModel.verificationKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Align(
          alignment: Alignment.center,
          child: Pinput(
            length: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            controller: viewModel.pinController,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ThemeColors.black1,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: ThemeColors.mainColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ThemeColors.black1,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeColors.mainColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            submittedPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: ThemeColors.black1,
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                color: Color.fromRGBO(234, 239, 243, 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            // validator: (s) {
            //   return s == '222222' ? null : 'Pin is incorrect';
            // },
            scrollPadding: EdgeInsets.only(bottom: 60),
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: false,
            pinContentAlignment: Alignment.center,
            onCompleted: (pin) => print(pin),
          ),
        ),
      ),
    );
  }

  Widget verifyBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Verify".tr,
        onPressed: () async {
          viewModel.verify();
        },
      ),
    );
  }

  Widget didntReceiveAndResendRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          didntReceiveTxt(),
          resendBtn(),
        ],
      ),
    );
  }

  Widget didntReceiveTxt() {
    return Text(
      "Didn’t Received Code?  ",
      style: TextStyle(
        color: Color(0xFF1E232C),
        fontSize: 15,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget resendBtn() {
    return GestureDetector(
      onTap: () {
        viewModel.resendCode();
      },
      child: Text(
        "Resend",
        style: TextStyle(
          color: const Color(0xff0C8A7B),
          fontSize: 15,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
