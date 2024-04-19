import '../../../libraries.dart';

class ShootingExperienceViewModel extends GetxController {
  RxString handGunGroupValue = "".obs;
  RxString rifleGroupValue = "".obs;
  RxString shotgunGroupValue = "".obs;

  @override
  void onClose() {
    handGunGroupValue.value = "";
    rifleGroupValue.value = "";
    shotgunGroupValue.value = "";

    super.onClose();
  }
}
