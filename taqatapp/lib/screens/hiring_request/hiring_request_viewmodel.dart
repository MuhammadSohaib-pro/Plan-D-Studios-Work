import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/hiring_request/hiring_request_model.dart';

class HiringRequestViewModel extends GetxController {
  RxString hiringRequestBtn = "Received".obs;

  List<HiringRequestModel> receivedRequestsList = <HiringRequestModel>[].obs;
  List<HiringRequestModel> sentRequestsList = <HiringRequestModel>[].obs;

  @override
  void onReady() {
    getReceivedRequest();
    getSentRequest();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  getReceivedRequest() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.receivedRequest).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      var data = parsedJson['notification'] as List;
      receivedRequestsList.clear();
      receivedRequestsList
          .addAll(data.map((e) => HiringRequestModel.fromJson(e)));
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  getSentRequest() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.sentRequest).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      var data = parsedJson['notification'] as List;
      sentRequestsList.addAll(data.map((e) => HiringRequestModel.fromJson(e)));
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  updateRequest({required int index, required String status}) {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> param = {
      "id": receivedRequestsList[index].id,
      "status": status
    };
    print(param);
    ApiBaseHelper()
        .postMethod(url: Urls.updateRequest, body: param)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['status'] == "true") {
        GetxHelper.showSnackBar(
            title: 'Success'.tr, message: parsedJson['message']);

        getReceivedRequest();
      }
      print(parsedJson);
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
