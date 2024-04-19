import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/complete_profile/step_2/complete_profile2_view.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class CompleteProfile1ViewModel extends GetxController {
  GlobalKey<FormState> completeProfile1Key = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  int genderIndex = 0;
  int yearIndex = 0;
  int monthIndex = 0;
  int daysIndex = 0;
  int ageInYears = 0;
  List<String> genderList = ["Male", "Female", "Other"];
  List<String> yearsList = [];
  List<String> daysList = [];
  List<String> monthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void onReady() {
    setInitialData();
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    genderController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    ageController.dispose();
    super.onClose();
  }

  setInitialData() {
    try {
      print(GlobalVariables.userModel.value.firstName);
      firstNameController.text =
          GlobalVariables.userModel.value.firstName ?? '';
      lastNameController.text = GlobalVariables.userModel.value.lastName ?? '';
      createYearsList();
      createDaysList();
      if (GlobalVariables.userModel.value.gender != null) {
        genderIndex =
            genderList.indexOf(GlobalVariables.userModel.value.gender!);
        genderController.text = genderList[genderIndex].tr;
      }
      if (GlobalVariables.userModel.value.dob != null) {
        calculateAge(GlobalVariables.userModel.value.dob!);
        DateTime inputDate = DateFormat("yyyy-MM-dd")
            .parse(GlobalVariables.userModel.value.dob!);
        setDOB(date: inputDate);
      } else {
        setDOB(date: DateTime.now());
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  createDaysList() {
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month);
    int totalDays = daysInMonth(now);

    daysList = new List<String>.generate(totalDays, (i) => (i + 1).toString());
    print(daysList);
  }

  int daysInMonth(DateTime date) {
    DateTime firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    DateTime firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  createYearsList() {
    for (int i = DateTime.now().year; i >= 1900; i--) {
      yearsList.add('$i');
    }
  }

  setDOB({required DateTime date}) {
    monthIndex = date.month - 1;
    daysIndex = date.day - 1;
    yearIndex = yearsList.indexWhere((e) => e == '${date.year}');

    dayController.text = '${daysList[daysIndex]}';
    monthController.text = '${monthsList[monthIndex].tr}';
    if (yearIndex != -1) {
      yearController.text = '${yearsList[yearIndex]}';
    } else {
      yearController.text = '${yearsList[0]}';
    }
  }

  continueBtn() {
    if (ageInYears < 21) {
      GetxHelper.showSnackBar(
          title: 'Error'.tr, message: 'Age must be greater than 20'.tr);
      return;
    }

    if (completeProfile1Key.currentState!.validate()) {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      Map<String, dynamic> param = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'gender': genderList[genderIndex],
        'dob': "${yearController.text}-${monthIndex + 1}-${dayController.text}",
      };
      ApiBaseHelper()
          .postMethod(url: Urls.complete_profile_1, body: param)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['user']);
          GetStorage().write('user', parsedJson['user']);
          if (GlobalVariables.profileCompletion < 25) {
            GlobalVariables.profileCompletion.value = 25;
          }
          Get.to(() => CompleteProfile2View());
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

  calculateAge(String dateOfBirth) {
    DateTime dob = DateFormat('yyyy-MM-dd').parse(dateOfBirth);
    DateTime today = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());

    Duration diff = today.difference(dob);

    ageInYears = (diff.inDays / 365).floor();
    ageController.text = '$ageInYears ${'Years Old'.tr}';
  }
}
