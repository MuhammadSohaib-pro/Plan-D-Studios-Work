
import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/search/search_model.dart';

class MyLaborsViewModel extends GetxController {
  List<SearchModel> mainList = <SearchModel>[].obs;

  @override
  void onReady() {
    getLaborsList();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  getLaborsList() {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> param = {};

    ApiBaseHelper()
        .postMethod(url: Urls.userApiController, body: param)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['labors'] as List;
        mainList.clear();
        mainList.addAll(data.map((e) => SearchModel.fromJson(e)));
      } else {
        mainList.clear();
        GetxHelper.showSnackBar(title: 'Error'.tr, message: parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
