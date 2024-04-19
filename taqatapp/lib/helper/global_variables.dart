import 'package:get/get.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class GlobalVariables {
  static RxBool showLoader = false.obs;
  static String token = '';
  static Rx<UserModel> userModel = UserModel().obs;
  static RxInt profileCompletion = 0.obs;
  static RxInt badgeCount = 0.obs;
  static bool isLanguageChanged = false;
}
