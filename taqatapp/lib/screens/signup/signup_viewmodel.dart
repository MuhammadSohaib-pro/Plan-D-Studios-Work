import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxString getTokenValue = "".obs;

  @override
  void onClose() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  signUpBtn() {
    if (signUpKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text
      };
      ApiBaseHelper()
          .postMethod(url: Urls.register, body: param)
          .then((parsedJson) {
            print("Response : $parsedJson");
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.back();
          GetxHelper.showSnackBar(
              title: 'Success'.tr, message: parsedJson['message']);
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }
}
