import '../../libraries.dart';

class SplashViewModel extends GetxController {
  @override
  void onReady() {
    loadNextScreen();
    super.onReady();
  }

  bool login = false;
  loadNextScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    login = prefs.getBool('checklogin') ?? false;
    Timer(const Duration(milliseconds: 1000), () {
      print('******* height ******    ${Get.height}   ****');
      print('******* width ******    ${Get.width}   ****');
      print('******* Get.IsTablet ******    ${Get.context!.isTablet}   ****');
      print(
          '******* Get.IsTablet + IsPortrait ******    ${Get.context!.isTablet && Get.context!.isPortrait}   ****');
      print(
          '******* Get.IsTablet + IsLandScape ******    ${Get.context!.isTablet && Get.context!.isLandscape}   ****');
      login ? Get.off(() => HomeUnlockView()) : Get.off(() => LoginView());
    });
  }
}
