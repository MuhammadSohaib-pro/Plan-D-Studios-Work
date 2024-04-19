import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/country_codes.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/add_labor/step_3/add_labor3_view.dart';
import 'package:taqat/screens/search/search_model.dart';

class AddLabor2ViewModel extends GetxController {
  GlobalKey<FormState> addLabor2Key = GlobalKey<FormState>();
  TextEditingController experienceController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  int genderIndex = 0;
  List<String> genderList = ["Male", "Female", "Other"];
  RxString countryCode = '+968'.obs;
  String laborId = "";
  List<String> religionList = [
    "Islam",
    "Christianity",
    "Hinduism",
    "Buddhism",
    "Sikhism",
    "Other"
  ];
  Rx<File> passportCopy = File('').obs;
  int religionIndex = 0;
  SearchModel laborDetail = SearchModel();
  bool isUpdate = false;

  @override
  void onInit() {
    super.onInit();
    religionController.text = religionList[religionIndex];
    nationalityController.text = "Oman";
    countryCode.value = "+968";
    laborId=Get.arguments['laborId'];
    isUpdate = Get.arguments['isUpdate'];
    if (isUpdate) {
      laborDetail = Get.arguments["data"];
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      print(laborDetail.toJson());
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      setInitialValues();
    }
  }

  @override
  void onClose() {
    experienceController.dispose();
    genderController.dispose();
    nationalityController.dispose();
    religionController.dispose();
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  setInitialValues() async {
    try {
      laborId = '${laborDetail.id ?? 0}';
      if (laborDetail.gender != null) {
        genderIndex = genderList.indexOf(laborDetail.gender!);
        genderController.text = genderList[genderIndex].tr;
      }
      religionController.text = laborDetail.religion?.tr ?? "";
      nationalityController.text = laborDetail.nationality ?? '';
      experienceController.text = '${laborDetail.experience ?? ''}';
      //set Country
      int indexValue = countryCodes
          .indexWhere((e) => e['name'] == (laborDetail.nationality ?? ''));

      for (int i = 0; i < countryCodes.length; i++) {
        print(countryCodes[i]);
      }
      print(')))))))))))))))))))))))))))))))))');
      print(countryCodes.length);
      print(indexValue);
      if (indexValue != -1) {
        countryCode.value = countryCodes[indexValue]['dial_code'] ?? '+968';
      } else {
        nationalityController.text = 'Oman';
      }

      //set Religion
      indexValue = religionList.indexWhere((e) =>
          e.toLowerCase() == (laborDetail.religion?.toLowerCase() ?? ''));

      if (indexValue != -1) {
        religionIndex = indexValue;
      } else {
        religionList.add(laborDetail.religion ?? '');
        religionIndex = (religionList.length - 1);
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  continueBtn() async {
    if (addLabor2Key.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;

      Map<String, String> param = {
        'gender': genderList[genderIndex],
        'nationality': nationalityController.text,
        'religion': religionList[religionIndex],
        'experience': experienceController.text,
      };
      ApiBaseHelper()
          .postMethod(url: "${Urls.add_labor_2}$laborId", body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.to(() => AddLabor3View(), arguments: {
            'laborId': '$laborId',
            'isUpdate': isUpdate,
            "data": laborDetail,
          });
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: Errors.generalApiError);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      passportCopy.value = File(image.path);
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      passportCopy.value = File(image.path);
    }
  }
}
