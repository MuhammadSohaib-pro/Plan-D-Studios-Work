import '../../../libraries.dart';

class AccidentalInsuranceViewModel extends GetxController {
  RxString accidentGroupValue = "".obs;
  RxString purchaseInsuranceGroupValue = "".obs;

  storewaiverModel() {
    AccidentInsurance accidentInsurance = AccidentInsurance(
      answer1: accidentGroupValue.value,
      answer2: purchaseInsuranceGroupValue.value,
    );
    StorewaiverModel.instance.updateData(accidentInsurance: accidentInsurance);
  }

  @override
  void onClose() {
    accidentGroupValue.value = '';
    purchaseInsuranceGroupValue.value = '';
    super.onClose();
  }
}
