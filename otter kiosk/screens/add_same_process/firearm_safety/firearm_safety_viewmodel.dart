import '../../../libraries.dart';

class FirearmSafetyViewModel extends GetxController {
  RxBool safeDirectionCheckBox = false.obs;
  RxBool gunLoadedCheckBox = false.obs;
  RxBool fingerOffTheTriggerCheckBox = false.obs;
  RxBool beSureOfYourTargetCheckBox = false.obs;

  @override
  void onClose() {
    safeDirectionCheckBox.value = false;
    gunLoadedCheckBox.value = false;
    fingerOffTheTriggerCheckBox.value = false;
    beSureOfYourTargetCheckBox.value = false;
    super.onClose();
  }
}
