import '../../../libraries.dart';

class RentalInsuranceViewModel extends GetxController {
  RxString groupValue = "".obs;
  storewaivermodel() {
    StorewaiverModel.instance.updateData(rentalinsurance: groupValue.value);
  }

  @override
  void onClose() {
    groupValue.value = "";
    super.onClose();
  }
}
