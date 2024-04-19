import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/add_labor/step_4/add_labor4_view.dart';
import 'package:taqat/screens/filter/occupation_model.dart';
import 'package:taqat/screens/search/search_model.dart';

class AddLabor3ViewModel extends GetxController {
  GlobalKey<FormState> addLabor3Key = GlobalKey<FormState>();
  TextEditingController salaryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController martialStatusController = TextEditingController();
  String laborId = "";
  int locationIndex = 0;
  int occupationIndex = 0;
  int martialStatusIndex = 0;
  List<String> locationList = [
    "Muscat",
    "Musandam",
    "Dhofar",
    "Al Buraimi",
    "Al Batinah",
    "Al Sharqiyah",
    "Al Wusta",
    "Al Dhahirah"
  ];

  List<OccupationModel> occupationList = <OccupationModel>[].obs;
  List<String> martialStatusList = ["Married", "Unmarried"];
  SearchModel laborDetail = SearchModel();
  bool isUpdate = false;

  @override
  void onInit() {
    isUpdate = Get.arguments['isUpdate'];
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    laborId = Get.arguments['laborId'];
    await getOccupations();
    locationController.text = 'Muscat'.tr;
    martialStatusController.text = 'Unmarried'.tr;
    martialStatusIndex = 1;

    if (isUpdate) {
      laborDetail = Get.arguments["data"];
      setInitialValues();
    }

    super.onReady();
  }

  @override
  void onClose() {
    salaryController.dispose();
    locationController.dispose();
    occupationController.dispose();
    martialStatusController.dispose();
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  setInitialValues() {
    try {
      print('updating values');
      salaryController.text = '${laborDetail.monthlySalary ?? ''}';

      if (laborDetail.location != null) {
        locationIndex = locationList.indexOf(laborDetail.location!);
        locationController.text = locationList[locationIndex].tr;
      }
      if (laborDetail.occupation != null) {
        occupationIndex = occupationList
            .indexWhere((element) => '${element.id}' == laborDetail.occupation);
        if (occupationIndex != -1) {
          occupationController.text =
              occupationList[occupationIndex].title ?? '';
        } else {
          occupationIndex = 0;
        }
      }
      if (laborDetail.maritalStatus != null) {
        martialStatusIndex = martialStatusList
            .indexOf(laborDetail.maritalStatus!.capitalizeFirst!);
        if (martialStatusIndex != -1) {
          martialStatusController.text =
              martialStatusList[martialStatusIndex].tr;
        } else {
          martialStatusIndex = 0;
        }
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  getOccupations() async {
    GlobalVariables.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.services).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['services'] as List;
        occupationList.addAll(data.map((e) => OccupationModel.fromJson(e)));
        if (occupationList.isNotEmpty) {
          occupationController.text = occupationList[0].title ?? '';
        }
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  continueBtn() {
    if (addLabor3Key.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'monthly_salary': int.parse(salaryController.text),
        'location': locationList[locationIndex],
        'occupation': occupationList[occupationIndex].id,
        'marital_status': martialStatusList[martialStatusIndex],
      };
      ApiBaseHelper()
          .postMethod(url: "${Urls.add_labor_3}$laborId", body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.to(() => AddLabor4View(), arguments: {
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
}
