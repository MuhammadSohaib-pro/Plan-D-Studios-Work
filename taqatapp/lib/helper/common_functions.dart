import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/chat_list/chat_list_view.dart';
import 'package:taqat/screens/dashboard/dashboard_view.dart';
import 'package:taqat/screens/dashboard/dashboard_viewmodel.dart';
import 'package:taqat/screens/notification/notification_view.dart';

class CommonFunctions {
  static String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Field is required".tr;
    } else {
      return null;
    }
  }

  static String? validateDefaultTxtFieldWithCustomMessage(
      String? value, String? message) {
    if (GetUtils.isBlank(value)!) {
      return "${message} is required".tr;
    } else {
      return null;
    }
  }

  static String? passwordvalidation(String? value, String? message) {
    if (GetUtils.isBlank(value)!) {
      return "${message} is required".tr;
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return "${message} must be at least 8 charactors".tr;
      //return " The password must be at least 8 charactes";
    } else {
      return null;
    }
  }
  // static String? passwordvalidation(String value) {
  //   if (GetUtils.isBlank(value)!) {
  //     return "Password is required".tr;
  //   } else if (GetUtils.isLengthLessThan(value, 8)) {
  //     return " The password must be at least 8 charactes";
  //   } else {
  //     return null;
  //   }
  // }

  static String convertDateFormat(String stringDate) {
    String outputDate = "";
    try {
      DateTime inputDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(stringDate);
      outputDate = DateFormat('MMM dd, hh:mm a').format(inputDate);
    } catch (e) {
      outputDate = stringDate;
    }
    return outputDate;
  }

  static String convertDateFormat2(String stringDate) {
    String outputDate = "";
    try {
      DateTime inputDate =
          DateFormat("yyyy-MM-ddTHH:mm:ss.00000Z").parse(stringDate);
      outputDate = DateFormat('MMM dd, yyyy').format(inputDate);
    } catch (e) {
      outputDate = stringDate;
    }
    return outputDate;
  }

  static String convertDateFormat3(String stringDate) {
    String outputDate = "";
    try {
      DateTime inputDate = DateFormat("yyyy-MM-dd").parse(stringDate);
      outputDate = DateFormat('MMM dd').format(inputDate);
    } catch (e) {
      outputDate = stringDate;
    }
    return outputDate;
  }

  static String convertDateFormat4(String stringDate) {
    String outputDate = "";
    try {
      DateTime inputDate = DateFormat("yyyy-MM-dd").parse(stringDate);
      outputDate = DateFormat('MMM dd, yyyy').format(inputDate);
    } catch (e) {
      outputDate = stringDate;
    }
    return outputDate;
  }

  static void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static void changeStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //onlyForAndroid
        //statusBarIconBrightness: Brightness.dark, //onlyForAndroid
        //statusBarBrightness: Brightness.dark, //onlyForIOS
      ),
    );
  }

  static String? validateEmail(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Field is required".tr;
    } else if (!GetUtils.isEmail(value!)) {
      return "Invalid email".tr;
    } else {
      return null;
    }
  }

  static Future<File> downloadFileFromUrl({required String url}) async {
    File file = File('');
    var url1 = Uri.parse(url);
    final response = await http.get(url1);

    if (response.statusCode == 200) {
      final documentDirectory = await getApplicationDocumentsDirectory();
      file = File(join(documentDirectory.path, url.split('/').last));
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      return file = File('');
    }
  }

  static void getNotificationCount() {
    ApiBaseHelper().getMethod(url: Urls.unreadNotification).then((parsedJson) {
      if (parsedJson['success'] == "true") {
        GlobalVariables.badgeCount.value = parsedJson['count'];
      }
    });
  }
}

localNotificationOnTabAction(String? messageType) {
  try {
    DashboardViewModel model = Get.find();
    Get.back();
    Future.delayed(const Duration(milliseconds: 200), () {
      Get.until((route) => route != DashboardView());
      if (messageType == "chat") {
        Get.to(() => ChatListView());
      } else {
        Get.to(() => NotificationView());
      }
    });
  } catch (e) {
    if (messageType == "chat") {
      Get.to(() => ChatListView());
    } else {
      Get.to(() => NotificationView());
    }
  }
}
