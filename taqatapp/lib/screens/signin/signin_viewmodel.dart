import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/dashboard_view.dart';
import 'package:taqat/screens/dashboard/dashboard_viewmodel.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class SignInViewModel extends GetxController {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  login() {
    if (signInKey.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'in': emailController.text,
        'password': passwordController.text
      };
      ApiBaseHelper()
          .postMethod(url: Urls.login, body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          GlobalVariables.token = parsedJson['token'];
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['user']);
          if (rememberMe.value) {
            GetStorage().write('token', parsedJson['token']);
            GetStorage().write('user', parsedJson['user']);
          }
          try {
            DashboardViewModel model = Get.find();
            model.calculateProfilePercentage();
          } catch (e) {}
          Get.offAll(() => DashboardView());
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: 'Incorrect Username or Password'.tr);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }


  signInWithGoogle() async {
    try {
      GlobalVariables.showLoader.value = true;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser != null) {
        //selected  account
        final GoogleSignInAuthentication gAuth = await gUser.authentication;
        final String? name = gUser.displayName;
        final String email = gUser.email;
        final String? photoUrl = gUser.photoUrl;
        await loginWithGoogle(gUser);
      } else {
        GlobalVariables.showLoader.value = false;
        //not selected any account
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
      print("error ${e.toString()}");
    }
  }

  loginWithGoogle(gUser) async {
    Map<String, dynamic> param = {
      'googleid': gUser.id,
      'googleemail': gUser.email,
      'username': gUser.displayName,
      'email_type': 'gmail'
    };

    ApiBaseHelper()
        .postMethod(url: Urls.googleLogin, body: param)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        GlobalVariables.token = parsedJson['access_token'];
        GlobalVariables.userModel.value =
            UserModel.fromJson(parsedJson['user']);
        GetStorage().write('token', parsedJson['access_token']);
        GetStorage().write('user', parsedJson['user']);
        try {
          DashboardViewModel model = Get.find();
          model.calculateProfilePercentage();
        } catch (e) {}
        Get.offAll(() => DashboardView());
      } else {
        GetxHelper.showSnackBar(
            title: 'Error'.tr, message: "${parsedJson['message']}".tr);
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
