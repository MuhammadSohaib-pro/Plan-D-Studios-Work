import '../../../libraries.dart';

class WetSuitRentalViewModel extends GetxController {
  RxString ownGroupValue = "".obs;
  RxString rentGroupValue = "".obs;
  RxBool checkboxvalue = false.obs;

  storewaivermodel() {
    Wetsuit wetsuit = Wetsuit(
        agree: checkboxvalue.value,
        answer1: rentGroupValue.value,
        answer2: ownGroupValue.value);

    StorewaiverModel.instance.updateData(wetsuit: wetsuit);
  }

  @override
  void onClose() {
    ownGroupValue.value = "";
    rentGroupValue.value = "";
    checkboxvalue.value;
    super.onClose();
  }
}
