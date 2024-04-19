import '../../../libraries.dart';

class LocalAddressViewModel extends GetxController {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  // RxString countryCode = '+1'.obs;
  final formkey = GlobalKey<FormState>();
  RxBool chkvalidate = false.obs;
  checkvalidate() {
    if (formkey.currentState!.validate()) {
      chkvalidate.value = true;
    } else {
      chkvalidate.value = false;
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    // countryCode.value = '+1';
    super.onClose();
  }

  void storewaivermodel() {
    StorewaiverModel.instance.updateData(
        localcity: cityController.text,
        localcountry: countryController.text,
        localstreet: addressController.text,
        localstate: stateController.text,
        localzipcode: zipCodeController.text);
  }
}
