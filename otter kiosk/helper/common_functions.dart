import '../libraries.dart';

class CommonFunctions {
  static String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Field is required".tr;
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty
        ? 'Field is required'.tr
        : !regex.hasMatch(value)
            ? 'Enter a valid email address'.tr
            : null;
  }

  static String? validateState(String? value) {
    const pattern = r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$";
    ;
    final regex = RegExp(pattern);

    return value!.isEmpty
        ? 'Field is required'.tr
        : !regex.hasMatch(value)
            ? 'Invalid ZipCode'.tr
            : null;
  }

  static void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static bool isTablet() {
    Get.context!;
    MediaQuery.of(Get.context!).size;
    // Get.context!.isTablet
    // return Get.width > 800 ? true : false;
    return Get.context!.isTablet && Get.context!.isLandscape ? true : false;
  }

  static termserviceurl() async {
    Uri _url = Uri.parse('https://app.otterwaiver.com/terms');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
