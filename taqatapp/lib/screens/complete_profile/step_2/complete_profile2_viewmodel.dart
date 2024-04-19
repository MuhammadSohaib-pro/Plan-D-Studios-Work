import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/complete_profile/step_3/complete_profile3_view.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class CompleteProfile2ViewModel extends GetxController {
  GlobalKey<FormState> completeProfile2Key = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString countryCode = '+968'.obs;

  @override
  void onInit() {
    setInitialData();
    super.onInit();
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    idNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  setInitialData() {
    try {
      if ((GlobalVariables.userModel.value.idNo?.length ?? 0) > 1) {
        idNumberController.text = GlobalVariables.userModel.value.idNo ?? '';
      }
      if (GlobalVariables.userModel.value.countrycode!.isEmpty) {
        countryCode.value = '+968';
      } else {
        countryCode.value =
            GlobalVariables.userModel.value.countrycode ?? '+968';
      }

      phoneNumberController.text = GlobalVariables.userModel.value.gsmNo ?? '';
      addressController.text = GlobalVariables.userModel.value.address ?? '';
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  continueBtn() {
    if (completeProfile2Key.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'country_code': countryCode.value,
        'phone_number': phoneNumberController.text,
        'id_number': idNumberController.text,
        'address': addressController.text
      };
      ApiBaseHelper()
          .postMethod(url: Urls.complete_profile_2, body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['user']);
          GetStorage().write('user', parsedJson['user']);
          if (GlobalVariables.profileCompletion < 50) {
            GlobalVariables.profileCompletion.value = 50;
          }
          Get.to(() => CompleteProfile3View());
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: Errors.generalApiError);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }
}
