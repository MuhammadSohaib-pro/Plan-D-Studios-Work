import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/add_labor/step_5/add_labor5_view.dart';
import 'package:taqat/screens/search/search_model.dart';

class AddLabor4ViewModel extends GetxController {
  GlobalKey<FormState> addLabor4Key = GlobalKey<FormState>();
  TextEditingController educationController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController applicationTypeController = TextEditingController();
  RxBool coupleWorkerBtn = false.obs;
  RxBool forLaborHireBtn = false.obs;
  RxString jobTypeBtn = "Full time".obs;
  String laborId = "";
  int applicationTypeIndex = 0;
  List<String> applicationTypeList = [
    "New",
    "Sponsorship transfer",
    "Ready in Office"
  ];
  int educationIndex = 0;
  List<String> educationList = [
    'No formal education',
    'Primary education',
    'Secondary education or high school',
    'GED',
    'Vocational qualification',
    'Bachelors degree',
    'Masters degree',
    'Doctorate or higher'
  ];
  SearchModel laborDetail = SearchModel();
  bool isUpdate = false;

  @override
  void onInit() {
    isUpdate = Get.arguments['isUpdate'];
    super.onInit();
  }

  @override
  void onReady() {
    laborId = Get.arguments['laborId'];
    applicationTypeController.text = 'New'.tr;
    educationController.text = 'No formal education'.tr;
    if (isUpdate) {
      laborDetail = Get.arguments["data"];
      setInitialValues();
    }
    super.onReady();
  }

  @override
  void onClose() {
    feeController.dispose();
    educationController.dispose();
    applicationTypeController.dispose();
    super.onClose();
  }

  setInitialValues() {
    try {
      coupleWorkerBtn.value = laborDetail.coupleWorker == 1 ? true : false;
      forLaborHireBtn.value = laborDetail.laborStatus == 1 ? true : false;

      feeController.text = '${laborDetail.laborSponsorshipTransferFee ?? ''}';

      applicationTypeIndex =
          applicationTypeList.indexOf(laborDetail.applicationType!);
      if (applicationTypeIndex != -1) {
        applicationTypeController.text =
            applicationTypeList[applicationTypeIndex].tr;
      } else {
        applicationTypeIndex = 0;
      }

      if (laborDetail.education != null) {
        educationIndex = educationList.indexOf(laborDetail.education!);
        if (educationIndex != -1) {
          educationController.text = educationList[educationIndex].tr;
        } else {
          educationIndex = 0;
        }
      }

      if (laborDetail.jobType != null) {
        jobTypeBtn.value = laborDetail.jobType!;
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  completeBtn() {
    if (addLabor4Key.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'labor_status':forLaborHireBtn.value?1:0,
        'couple_worker': coupleWorkerBtn.value,
        'app_type': applicationTypeList[applicationTypeIndex],
        'education': educationList[educationIndex],
        'job_type': jobTypeBtn.value,
        'labor_sponsor_transfer_fee': feeController.text,
      };
      ApiBaseHelper()
          .postMethod(url: "${Urls.add_labor_4}$laborId", body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          Get.to(() => AddLabor5View());
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
