import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/screens/dashboard/dashboard_view.dart';
import 'package:taqat/screens/dashboard/user_model.dart';
import 'package:taqat/screens/signin/signin_view.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    ///Set Last Selected Language
    setLanguage();

    Timer(const Duration(seconds: 2), () {
      loadNextScreen();
    });
    super.onReady();
  }

  setLanguage() {
    String? language = GetStorage().read('language');
    if (language == 'english') {
      Get.updateLocale(Locale('en', 'US'));
    } else if (language == 'arabic') {
      GlobalVariables.isLanguageChanged = true;
      Get.updateLocale(Locale('ar', 'EG'));
    } else {
      Get.updateLocale(Get.deviceLocale!);
      if (Get.deviceLocale!.languageCode == 'ar') {
        GlobalVariables.isLanguageChanged = true;
      }
    }
  }

  loadNextScreen() {
    String token = GetStorage().read('token') ?? '';
    if (token != '') {
      GlobalVariables.token = token;
      GlobalVariables.userModel.value =
          UserModel.fromJson(GetStorage().read('user'));

      Get.off(() => DashboardView());
    } else {
      Get.off(() => SignInView());
    }
  }
}
