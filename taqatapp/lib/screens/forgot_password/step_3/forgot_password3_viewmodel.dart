import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/forgot_password/step_4/forgot_password4_view.dart';

class ForgotPassword3ViewModel extends GetxController {
  GlobalKey<FormState> resetKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  String email = "";

  @override
  void onReady() {
    email = Get.arguments['email'].toString();
    super.onReady();
  }

  resetPassword() {
    if (resetKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        CommonFunctions.closeKeyboard();
        GlobalVariables.showLoader.value = true;
        Map<String, dynamic> param = {
          'email': email,
          'pass': passwordController.text
        };
        ApiBaseHelper()
            .postMethod(url: Urls.changePassword, body: param)
            .then((parsedJson) {
          GlobalVariables.showLoader.value = false;
          if (parsedJson['success'] == true) {
            Get.to(() => ForgotPassword4View());
            GetxHelper.showSnackBar(
                title: 'Success'.tr,
                message: 'Password Change Successfully'.tr);
          } else {
            GetxHelper.showSnackBar(
                title: 'Error'.tr, message: Errors.generalApiError.tr);
          }
        }).catchError((e) {
          GlobalVariables.showLoader.value = false;
          print(e);
        });
      } else {
        GetxHelper.showSnackBar(
            title: 'Error'.tr, message: "Both Password Didn\'t Match".tr);
      }
    }
  }
}
