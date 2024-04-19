import 'package:geo_school/screens/form/dropdown_model.dart';
import 'package:get/get.dart';

class CommonFunctions {
  static String getIdFromDropDown(List<DropDownModel> list, RxString val) {
    return list.where((element) => element.name == val.value).first.id!;
  }

  static String getValueFromDropDown(List<DropDownModel> list, String val) {
    return list
        .where((element) => element.id!.toLowerCase() == val.toLowerCase())
        .first
        .name!;
  }

  static String? validateDefaultTextField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return 'fieldRequired'.tr;
    } else {
      return null;
    }
  }

  static String? validateDefaultDropDown(String? value) {
    if (value == 'pleaseSelect'.tr) {
      return 'pleaseSelectAValidValue'.tr;
    } else {
      return null;
    }
  }
}
