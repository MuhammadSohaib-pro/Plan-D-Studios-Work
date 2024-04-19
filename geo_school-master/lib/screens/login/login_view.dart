import 'package:flutter/material.dart';
import 'package:geo_school/helper/CommonFunctions.dart';
import 'package:geo_school/screens/login/login_viewmodel.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/custom_buttons.dart';
import 'package:geo_school/widgets/custom_checkbox.dart';
import 'package:geo_school/widgets/custom_textfields.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel loginViewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return loginViewModel.onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor: Color(0xff023330),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Get.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/loginbackground.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(Get.width * 0.06, 0,
                        Get.width * 0.06, Get.width * 0.09),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 3),
                          child: Text(
                            'agentCode'.tr,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Form(
                          key: loginViewModel.loginKey,
                          child: codeAgentTextField(),
                        ),
// rememberMeCheckBox(),
                        loginButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Loader()
          ],
        ),
      ),
    );
  }

  Widget codeAgentTextField() {
    return CustomTextField13(
      fillColor: Color(0xff021110),
      hintText: 'agentCode'.tr,
      textColor: Colors.white,
      maxLines: 1,
      prefixIcon: Icon(
        Icons.email,
        size: 15,
        color: Colors.white,
      ),
      controller: loginViewModel.codeController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return CommonFunctions.validateDefaultTextField(value);
      },
    );
  }

  Widget rememberMeCheckBox() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 40),
        child: SimpleCheckBox(
          title: 'rememberMe'.tr,
          value: loginViewModel.rememberMeCb.value,
          onChanged: (value) {
            loginViewModel.rememberMeCb.value = value;
          },
        ),
      ),
    );
  }

  Widget loginButton() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      height: 50,
      child: CustomButton8(
        onPressed: () {
          loginViewModel.loginButton();
        },
        backgroundColor: Color(0xffFE9900),
        text: 'login'.tr,
      ),
    );
  }
}
