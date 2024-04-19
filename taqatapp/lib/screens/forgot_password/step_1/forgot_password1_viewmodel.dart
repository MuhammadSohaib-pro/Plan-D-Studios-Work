import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/forgot_password/step_2/forgot_password2_view.dart';

class ForgotPassword1ViewModel extends GetxController {
  GlobalKey<FormState> forgotPaswordKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  sendCode() {
    if (forgotPaswordKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'email': emailController.text,
      };
      ApiBaseHelper()
          .postMethod(url: Urls.forgetPassword, body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.to(() => ForgotPassword2View(),
              arguments: {'email': emailController.text});
          GetxHelper.showSnackBar(
              title: 'Success'.tr,
              message:
                  'Verification Code Sent Successfully. Check Your Email.'.tr);
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: 'This Email Doesn\'t Exist'.tr);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }
}
