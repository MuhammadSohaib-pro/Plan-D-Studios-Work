import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/Widgets/custom_buttons.dart';
import 'package:taqat/Widgets/custom_checkbox.dart';
import 'package:taqat/Widgets/custom_social_buttons.dart';
import 'package:taqat/Widgets/custom_textfields.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/signin/signin_viewmodel.dart';
import 'package:taqat/screens/signup/signup_view.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

import '../forgot_password/step_1/forgot_password1_view.dart';

class SignInView extends StatelessWidget {
  final SignInViewModel viewModel = Get.put(SignInViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: ScrollableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                welcomeText(),
                welcomeBackDescription(),
                Form(
                  key: viewModel.signInKey,
                  child: Column(
                    children: [
                      emailTxtField(),
                      passwordTxtField(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rememberMe(),
                      forgotPassword(),
                    ],
                  ),
                ),
                signInBtn(),
                signInWithGoogle(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 15, 24, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      doNotHaveAccount(),
                      SizedBox(width: 15),
                      signUpForFree(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        LoaderView()
      ],
    );
  }

  Widget welcomeText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 10),
      child: Text(
        "Welcome Back".tr,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Color(0xff101817),
        ),
      ),
    );
  }

  Widget welcomeBackDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      child: Text(
        "Welcome Back! Please Enter Your Details.".tr,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff828A89),
        ),
      ),
    );
  }

  Widget emailTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.emailController,
        fillColor: Color(0xffFFFFFF),
        title: "Email or Username".tr,
        hintText: "Email or Username".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.emailAddress,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateEmail(value);
          // return CommonFunctions.validateDefaultTxtFieldWithCustomMessage(
          //value, "Email or Username");
        },
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
          title: "Password".tr,
          hintText: "Password".tr,
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
            return CommonFunctions.passwordvalidation(value!, "password");
            // return CommonFunctions.validateDefaultTxtFieldWithCustomMessage(value,"Password");
          },
        ),
      ),
    );
  }

  Widget rememberMe() {
    return Obx(
      () => SizedBox(
        height: 40,
        width: 150,
        child: SimpleCheckBox(
          title: "Remember Me".tr,
          value: viewModel.rememberMe.value,
          onChanged: (value) {
            viewModel.rememberMe.value = value;
          },
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: GestureDetector(
        onTap: () => Get.to(() => ForgotPassword1View()),
        child: Text(
          "Forgot password".tr,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xff101817),
          ),
        ),
      ),
    );
  }

  Widget signInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Sign In".tr,
        onPressed: () async {
          viewModel.login();
        },
      ),
    );
  }

  Widget signInWithGoogle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSocialButton(
        imgPath: "assets/images/google.png",
        text: "Sign In With Google".tr,
        onPressed: () {
          viewModel.signInWithGoogle();
        },
      ),
    );
  }

  Widget doNotHaveAccount() {
    return Text(
      "Don’t Have An Account?".tr,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xff828A89),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget signUpForFree() {
    return InkWell(
      onTap: () {
        Get.to(() => SignUpView());
      },
      child: Text(
        "Sign Up for free".tr,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff0C8A7B),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
