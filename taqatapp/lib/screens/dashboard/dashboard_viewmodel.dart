import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/add_labor/step_1/add_labor1_view.dart';
import 'package:taqat/screens/dashboard/user_model.dart';
import 'package:taqat/screens/signin/signin_view.dart';
import 'package:taqat/screens/upload_id/upload_id_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';

class DashboardViewModel extends GetxController with WidgetsBindingObserver {
  RxInt laborAdded = 0.obs;
  RxInt hireCount = 0.obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    GlobalVariables.showLoader.value = false;
    subscribeToTopic();
    getProfile();
    CommonFunctions.getNotificationCount();
    calculateProfilePercentage();
    super.onReady();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      CommonFunctions.getNotificationCount();
    }
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  subscribeToTopic() {
    FirebaseMessaging.instance
        .subscribeToTopic('client_${GlobalVariables.userModel.value.id}');
  }

  unsubscribeFromTopic() {
    FirebaseMessaging.instance
        .unsubscribeFromTopic('client_${GlobalVariables.userModel.value.id}');
  }

  logout() async {
    GetStorage().remove('token');
    GetStorage().remove('user');
    var result = await GoogleSignIn().signOut();
    print("$result");
    unsubscribeFromTopic();
    Get.offAll(() => SignInView());
  }

  void calculateProfilePercentage() {
    switch (GlobalVariables.userModel.value.profileStatus) {
      case 1:
        GlobalVariables.profileCompletion.value = 33;
        break;
      case 2:
        GlobalVariables.profileCompletion.value = 66;
        break;
      case 3:
        GlobalVariables.profileCompletion.value = 100;
        break;
      default:
        GlobalVariables.profileCompletion.value = 0;
        break;
    }
  }

  getProfile() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.dashboard).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        GlobalVariables.userModel.value =
            UserModel.fromJson(parsedJson['user']);
        laborAdded.value = parsedJson['labors_added'];
        hireCount.value = parsedJson['hire_count'];
        calculateProfilePercentage();
      } else {
        GetxHelper.showSnackBar(
            title: 'Error'.tr, message: 'Something went wrong'.tr);
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
    });
  }

  addLaborButton() {
    if (GlobalVariables.profileCompletion.value != 100) {
      GetxHelper.showSnackBar(
          title: 'Error'.tr, message: 'Please complete your profile first'.tr);

      return;
    }

    if (GlobalVariables.userModel.value.sponsorId == null) {
      sponsorIdDialog();
      return;
    }

    if (GlobalVariables.userModel.value.addLaborStatus != 1) {
      GetxHelper.showSnackBar(
          title: 'Error'.tr,
          message: 'Sponsor Labor ID is not approved by admin yet!'.tr);
      return;
    }

    Get.to(() => AddLabor1View(), arguments: {"isUpdate": false});
  }

  Future<dynamic> sponsorIdDialog() {
    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Document Alert'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: ThemeColors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    'Sponsor Labor ID is required.'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: "Cancel".tr,
                        backgroundColor: ThemeColors.mainColor,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomButton8(
                        text: "Upload".tr,
                        backgroundColor: ThemeColors.mainColor,
                        onPressed: () {
                          Get.back();
                          Get.to(() => UploadIDView());
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
