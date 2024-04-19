import '../../../libraries.dart';

class HelmetRentalViewModel extends GetxController {
  RxString ownGroupValue = "".obs;
  RxString rentGroupValue = "".obs;
  RxBool checkboxvalue = false.obs;
  storewaivermodel() {
    Protective protective = Protective(
        agree: checkboxvalue.value,
        answer1: rentGroupValue.value,
        answer2: ownGroupValue.value);

    StorewaiverModel.instance.updateData(protective: protective);
  }

  @override
  void onClose() {
    ownGroupValue.value = '';
    rentGroupValue.value = '';
    checkboxvalue.value;
    super.onClose();
  }
}
