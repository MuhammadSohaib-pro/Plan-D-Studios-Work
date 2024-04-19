import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/dashboard_viewmodel.dart';
import 'package:taqat/screens/notification/notification_model.dart';

class NotificationViewModel extends GetxController {
  List<NotificationModel> newNotificationList = <NotificationModel>[].obs;
  List<NotificationModel> oldNotificationList = <NotificationModel>[].obs;

  @override
  void onReady() {
    getNotificationsList();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    CommonFunctions.getNotificationCount();
    // DashboardViewModel model = Get.find();
    // model.getProfile();
    super.onClose();
  }

  getNotificationsList() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.notificationList).then((parsedJson) {
      var data = parsedJson['notification'] as List;
      newNotificationList.clear();
      oldNotificationList.clear();
      for (var item in data) {
        if (item['seen'] == 'no') {
          newNotificationList.add(NotificationModel.fromJson(item));
        } else {
          oldNotificationList.add(NotificationModel.fromJson(item));
        }
      }
      final DashboardViewModel model = Get.find();
      model.getProfile();
      GlobalVariables.showLoader.value = false;
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  clearNotificationsList() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.clearNotification).then((parsedJson) {
      if (parsedJson['status'] == "true") {
        newNotificationList.clear();
        oldNotificationList.clear();
        GlobalVariables.badgeCount.value = 0;
      }
      GlobalVariables.showLoader.value = false;
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  updateNotifications(int? id) {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> params = {
      "id": id,
    };
    ApiBaseHelper()
        .postMethod(url: Urls.updateNotification, body: params)
        .then((parsedJson) {
      if (parsedJson['status'] == "true") {
        getNotificationsList();
        CommonFunctions.getNotificationCount();
      }

      GlobalVariables.showLoader.value = false;
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  deleteNotifications(int? id) {
    GlobalVariables.showLoader.value = true;
    Map<String, dynamic> params = {
      "id": id,
    };
    ApiBaseHelper()
        .postMethod(url: Urls.deleteNotification, body: params)
        .then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['status'] == "true") {
        getNotificationsList();
        CommonFunctions.getNotificationCount();
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  String getNotificationText(NotificationModel model) {
    switch (model.type) {
      case 'accept':
        return '${'Your request to hire'.tr} ${model.fullname} ${'as'.tr} ${model.title} ${'is accepted'.tr}.';
      case 'cancel':
        return '${'Your request to hire'.tr} ${model.fullname} ${'as'.tr} ${model.title} ${'is rejected'.tr}.';
      case 'hiring':
        return '${model.fromName} ${'requested to hire'.tr} ${model.fullname} ${'as'.tr} ${model.title}.';
      case 'profile':
        return "${'Profile Approved Successfully'.tr}";
      case 'invoice':
        return '${'Your Invoice is Pending from sanad'.tr}.';
      case 'release':
        return '${'Do you want to realease your labor'.tr} ${model.fullname}';
      default:
        return '${'You got new hiring update. Please check it'.tr}.';
    }
  }

  acceptRequest(NotificationModel model) {
    Map<String, dynamic> params = {
      'sponsor_id': model.sponsorId,
      'hiring_sponsor_id': model.hiringSponsorId,
      'labor_id': model.laborId,
    };

    ApiBaseHelper()
        .postMethod(url: Urls.releaseFromFirstKafeel, body: params)
        .then((parsedJson) {
      getNotificationsList();
    }).catchError((e) {});
  }

  cancelRequest(NotificationModel model) {}
}
