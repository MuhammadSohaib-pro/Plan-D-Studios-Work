import 'dart:async';
import 'package:geo_school/screens/bottom_navigation/bottomnavigation_view.dart';
import 'package:geo_school/screens/login/login_view.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashViewModel extends GetxController {
  late String rememberMe;

  @override
  void onReady() async {
    Timer(Duration(seconds: 3), loadNextScreen);
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
  }

  loadNextScreen() async {
    rememberMe = await GetStorage().read('remember_me') ?? '';

    if (rememberMe == 'true') {

      String loginDate = await GetStorage().read('loginDate');
      DateTime expiryDate = DateTime.parse(loginDate).add(Duration(days: 20));
      DateTime currentDate = DateTime.now();

      //logout after 20 days
      if (currentDate.compareTo(expiryDate) <= 0) {
        Get.offAll(() => BottomNavigationView());
      } else {
        GetStorage().remove('remember_me');
        Get.offAll(() => LoginView());
      }
    } else {
      Get.offAll(() => LoginView());
    }
  }
}
