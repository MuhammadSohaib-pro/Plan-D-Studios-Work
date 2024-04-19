import '../../../libraries.dart';

class EmergencyContactViewModel extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxString name = ''.obs;
  RxBool phone = false.obs;
  RxString countryCode = '+1'.obs;
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    countryCode.value = '+1';
    super.onClose();
  }

  storeviewmodel() {
    StorewaiverModel.instance.updateData(
        emergencyname: fullNameController.text,
        emergencycode: countryCode.value,
        emergencyphone: phoneController.text);
  }
}
