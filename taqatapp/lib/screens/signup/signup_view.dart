import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/Widgets/custom_buttons.dart';
import 'package:taqat/Widgets/custom_social_buttons.dart';
import 'package:taqat/Widgets/custom_textfields.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/signup/signup_viewmodel.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                ScrollableColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    createAccountText(),
                    createAccountDescription(),
                    Form(
                      key: viewModel.signUpKey,
                      child: Column(
                        children: [
                          usernameTxtField(),
                          emailTxtField(),
                          passwordTxtField(),
                        ],
                      ),
                    ),
                    signUpBtn(),
                    // signUpWithGoogle(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 15, 24, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAnAccount(),
                          signInForFree(),
                        ],
                      ),
                    )
                  ],
                ),
                BackButton(),
              ],
            ),
          ),
        ),
        LoaderView()
      ],
    );
  }

  Widget createAccountText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 10),
      child: Text(
        "Create Account".tr,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Color(0xff101817),
        ),
      ),
    );
  }

  Widget createAccountDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: Text(
        "Let’s create Your account".tr,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xff828A89),
        ),
      ),
    );
  }

  Widget usernameTxtField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      child: CustomTextField13(
        controller: viewModel.usernameController,
        fillColor: Color(0xffFFFFFF),
        title: "Username".tr,
        hintText: "Username".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.emailAddress,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtFieldWithCustomMessage(
              value, "Username");
        },
      ),
    );
  }

  Widget emailTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.emailController,
        fillColor: Color(0xffFFFFFF),
        title: "Email".tr,
        hintText: "Email".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.emailAddress,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtFieldWithCustomMessage(
              value, "Email");
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
          },
        ),
      ),
    );
  }

  Widget signUpBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Sign Up".tr,
        onPressed: () async {
          //Get.to(() => const DashboardView());
          viewModel.signUpBtn();
        },
      ),
    );
  }

  Widget signUpWithGoogle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSocialButton(
        imgPath: "assets/images/google.png",
        text: "Sign Up With Google".tr,
        onPressed: () {},
      ),
    );
  }

  Widget alreadyHaveAnAccount() {
    return Text(
      "Already, Have An Account?".tr,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xff828A89),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget signInForFree() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Text(
        "Sign In".tr,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff0C8A7B),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
