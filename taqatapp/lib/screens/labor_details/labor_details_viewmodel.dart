import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/dashboard_viewmodel.dart';
import 'package:taqat/screens/filter/occupation_model.dart';
import 'package:taqat/screens/search/search_model.dart';

class LaborDetailsViewModel extends GetxController {
  Rx<SearchModel> laborDetail = SearchModel().obs;
  List<OccupationModel> occupationList = <OccupationModel>[].obs;
  RxString age = "".obs;
  RxBool minSalaryFlag = false.obs;
  RxBool hireBtnFlag = false.obs;
  RxInt minSalary = 0.obs;

  @override
  void onInit() {
    laborDetail.value = Get.arguments["data"];
    hireBtnFlag.value=Get.arguments["hireBtnFalg"];

    print(laborDetail.value.toJson());
    super.onInit();
  }

  @override
  void onReady() {
    minimumSalary();
    super.onReady();
  }

  hireBtn() {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> param = {
      "labor_id": laborDetail.value.id,
      "hiring_sponsor_id": GlobalVariables.userModel.value.id
    };

    print(param);
    ApiBaseHelper()
        .postMethod(url: Urls.laborHiring, body: param)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      GetxHelper.showSnackBar(
          title: parsedJson['success'] == true ? 'Success'.tr : 'Error'.tr,
          message: parsedJson['message']);
      final DashboardViewModel dashboard = Get.find();
      dashboard.getProfile();
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  minimumSalary() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.minSalary).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        minSalary.value = parsedJson['min_salary'];
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
