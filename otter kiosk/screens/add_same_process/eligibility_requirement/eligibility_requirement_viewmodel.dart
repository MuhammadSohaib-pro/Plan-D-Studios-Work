import '../../../libraries.dart';

class EligiablityRequirementViewModel extends GetxController {
  RxString groupValue1 = "".obs;
  RxString groupValue2 = "".obs;
  RxString groupValue3 = "".obs;
  RxString groupValue4 = "".obs;
  RxString groupValue5 = "".obs;
  RxString groupValue6 = "".obs;
  RxString groupValue7 = "".obs;
  RxString groupValue8 = "".obs;
  RxString groupValue9 = "".obs;
  RxString groupValue10 = "".obs;

  @override
  void onClose() {
    groupValue1.value = '';
    groupValue2.value = '';
    groupValue3.value = '';
    groupValue4.value = '';
    groupValue5.value = '';
    groupValue6.value = '';
    groupValue7.value = '';
    groupValue8.value = '';
    groupValue9.value = '';
    groupValue10.value = '';
    super.onClose();
  }
}
