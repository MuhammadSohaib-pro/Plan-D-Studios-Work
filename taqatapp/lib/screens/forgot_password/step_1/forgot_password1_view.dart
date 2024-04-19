import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/forgot_password/step_1/forgot_password1_viewmodel.dart';
import 'package:taqat/screens/signin/signin_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class ForgotPassword1View extends StatelessWidget {
  ForgotPassword1View({super.key});

  final ForgotPassword1ViewModel viewModel =
      Get.put(ForgotPassword1ViewModel());

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
                forgotPasswordTxt(),
                dontWorryTxt(),
                emailTxtField(),
                sendCodeBtn(),
                Spacer(),
                rememberAndLoginRow(),
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

  Widget forgotPasswordTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 5),
      child: Text(
        'Forgot Password?',
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

  Widget dontWorryTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Text(
        'Don\'t worry! It occurs. Please enter the email address linked with your account.',
        style: TextStyle(
          color: Color(0xFF8390A1),
          fontSize: 16,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget emailTxtField() {
    return Form(
      key: viewModel.forgotPaswordKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        child: CustomTextField13(
          controller: viewModel.emailController,
          fillColor: Color(0xffFFFFFF),
          title: "Email".tr,
          hintText: "Email Your Email".tr,
          textColor: Color(0xff828A89),
          keyboardType: TextInputType.emailAddress,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget sendCodeBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Send Code".tr,
        onPressed: () async {
          viewModel.sendCode();
        },
      ),
    );
  }

  Widget rememberAndLoginRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          rememberPasswordTxt(),
          loginbtn(),
        ],
      ),
    );
  }

  Widget rememberPasswordTxt() {
    return Text(
      "Remember Password? ",
      style: TextStyle(
        color: Color(0xFF1E232C),
        fontSize: 15,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget loginbtn() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Text(
        "Login",
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
