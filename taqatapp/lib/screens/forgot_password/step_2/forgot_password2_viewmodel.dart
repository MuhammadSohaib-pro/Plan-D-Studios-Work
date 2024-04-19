import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/forgot_password/step_1/forgot_password1_viewmodel.dart';
import 'package:taqat/screens/forgot_password/step_3/forgot_password3_view.dart';

class ForgotPassword2ViewModel extends GetxController {
  GlobalKey<FormState> verificationKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  String email = "";

  @override
  void onReady() {
    email = Get.arguments['email'].toString();
    super.onReady();
  }
  
  @override
  void onClose() {
    pinController.clear();
    pinController.dispose();
    super.onClose();
  }

  verify() {
    if (verificationKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {'email': email, 'code': pinController.text};
      ApiBaseHelper()
          .postMethod(url: Urls.verifyCode, body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.to(() => ForgotPassword3View(), arguments: {
            'email': email,
          });
          GetxHelper.showSnackBar(
              title: 'Success'.tr, message: 'Verification Successfully'.tr);
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: 'Verification Code Is Incorrect'.tr);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }

  resendCode() {
    final ForgotPassword1ViewModel model = Get.find();
    model.sendCode();
  }
}
