import '../../../libraries.dart';

class YesNoRadioBtnViewModel extends GetxController {
  RxString groupValue = "".obs;
  @override
  void onClose() {
    groupValue.value = "";
    super.onClose();
  }
}
