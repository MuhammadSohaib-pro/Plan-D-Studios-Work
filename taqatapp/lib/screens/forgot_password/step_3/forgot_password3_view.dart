import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/forgot_password/step_3/forgot_password3_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class ForgotPassword3View extends StatelessWidget {
  ForgotPassword3View({super.key});

  final ForgotPassword3ViewModel viewModel =
      Get.put(ForgotPassword3ViewModel());

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
                createNewPasswordTxt(),
                newPasswordTxt(),
                Form(
                  key: viewModel.resetKey,
                  child: Column(
                    children: [
                      passwordTxtField(),
                      confirmPasswordTxtField(),
                    ],
                  ),
                ),
                resetPasswordtBtn(),
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

  Widget createNewPasswordTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 5),
      child: Text(
        'Create New Password',
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

  Widget newPasswordTxt() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Text(
        'Your new password must be unique from those previously used.',
        style: TextStyle(
          color: Color(0xFF8390A1),
          fontSize: 16,
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget passwordTxtField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        child: CustomTextField13(
          controller: viewModel.passwordController,
          fillColor: Color(0xffFFFFFF),
          textColor: Color(0xff828A89),
          title: "New Password".tr,
          hintText: "New Password".tr,
          obscureText: viewModel.obscurePassword.value,
          keyboardType: TextInputType.text,
          sufixIcon: InkWell(
            onTap: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
            child: Icon(
              (viewModel.obscurePassword.value)
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Color(0xff828A89),
            ),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget confirmPasswordTxtField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        child: CustomTextField13(
          controller: viewModel.confirmPasswordController,
          fillColor: Color(0xffFFFFFF),
          textColor: Color(0xff828A89),
          title: "Confirm Password".tr,
          hintText: "Confirm Password".tr,
          obscureText: viewModel.obscureConfirmPassword.value,
          keyboardType: TextInputType.text,
          sufixIcon: InkWell(
            onTap: () {
              viewModel.obscureConfirmPassword.value =
                  !viewModel.obscureConfirmPassword.value;
            },
            child: Icon(
              (viewModel.obscureConfirmPassword.value)
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Color(0xff828A89),
            ),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
      ),
    );
  }

  Widget resetPasswordtBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Reset Password".tr,
        onPressed: () async {
          viewModel.resetPassword();
        },
      ),
    );
  }
}
