import '../../../libraries.dart';

class CheckIn2ViewModel extends GetxController {
  String enteredValue = '';
  RxString countryCode = '+1'.obs;
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  TextEditingController txtFieldController = TextEditingController();

  void numberButton(String value) {
    enteredValue += value;
    txtFieldController.text = enteredValue;
  }

  void backButton() {
    if (enteredValue.isNotEmpty) {
      enteredValue = enteredValue.substring(0, enteredValue.length - 1);
      txtFieldController.text = enteredValue;
    }
  }

  void backButtonLongPress() {
    if (enteredValue.isNotEmpty) {
      enteredValue = "";
      txtFieldController.text = enteredValue;
    }
  }
}
