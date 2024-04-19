import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:http/http.dart' as http;
import 'package:taqat/screens/add_labor/step_2/add_labor2_view.dart';
import 'package:taqat/screens/my_labors/my_labors_viewmodel.dart';
import 'package:taqat/screens/search/search_model.dart';

class AddLabor1ViewModel extends GetxController {
  GlobalKey<FormState> addLabor1Key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passportNoController = TextEditingController();

  String laborId = "";
  Rx<File> profileImage = File('').obs;
  Rx<File> passportCopy = File('').obs;
  int type = 4;
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
  SearchModel laborDetail = SearchModel();
  bool isUpdate = false;

  @override
  void onInit() {
    super.onInit();

    isUpdate = Get.arguments['isUpdate'];
    createYearsList();
    createDaysList();
    if (isUpdate) {
      laborDetail = Get.arguments["data"];
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      print(laborDetail.toJson());
      print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
      setInitialValues();
    } else {
      setDOB(date: DateTime.now());
    }
  }

  @override
  void onClose() {
    if (isUpdate) {
      MyLaborsViewModel viewModel = Get.find();
      viewModel.getLaborsList();
    }
    nameController.dispose();
    passportNoController.dispose();
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    ageController.dispose();
    GlobalVariables.showLoader.value = false;
    CommonFunctions.closeKeyboard();
    super.onClose();
  }

  setInitialValues() async {
    try {
      laborId = '${laborDetail.id ?? 0}';
      nameController.text = laborDetail.fullname ?? "";
      passportNoController.text = laborDetail.passportNo ?? "";
      if (laborDetail.dob != null) {
        calculateAge(laborDetail.dob!);
        DateTime inputDate = DateFormat("yyyy-MM-dd").parse(laborDetail.dob!);
        setDOB(date: inputDate);
      } else {
        setDOB(date: DateTime.now());
      }

      //setProfileImage
      if (laborDetail.laborPhoto != null) {
        await CommonFunctions.downloadFileFromUrl(
                url: Urls.imageUrl + laborDetail.laborPhoto!)
            .then((value) {
          profileImage.value = value;
        });
      }
      //setPassportCopy
      if (laborDetail.passportCopy != null) {
        await CommonFunctions.downloadFileFromUrl(
                url: Urls.imageUrl + laborDetail.passportCopy!)
            .then((value) {
          passportCopy.value = value;
        });
      }
    } catch (e) {
      GlobalVariables.showLoader.value = false;
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

  continueBtn() async {
    if (ageInYears < 21) {
      GetxHelper.showSnackBar(
          title: 'Error'.tr, message: 'Labors under 21 are not allowed'.tr);
      return;
    }
    if (addLabor1Key.currentState!.validate() &&
        profileImage.value.path != '' && passportCopy.value.path != '') {
      CommonFunctions.closeKeyboard();
      GlobalVariables.showLoader.value = true;
      String fName = "";
      String lName = "";
      if (nameController.text.contains(' ')) {
        fName = nameController.text.split(' ')[0];
        lName = nameController.text.split(' ')[1];
      } else {
        fName = nameController.text;
        lName = "";
      }
      List<http.MultipartFile> fileList = [];
      if (passportCopy.value.path != '') {
        fileList.add(await http.MultipartFile.fromPath(
          'passport_photo',
          passportCopy.value.path,
        ));
      }
      if (profileImage.value.path != '') {
        fileList.add(await http.MultipartFile.fromPath(
          'labor_photo',
          profileImage.value.path,
        ));
      }

      Map<String, String> param = {
        'first_name': fName,
        'last_name': lName,
        'passport_no': passportNoController.text,
        'dob': "${yearController.text}-${monthIndex + 1}-${dayController.text}",
      };

      String url = Urls.add_labor_1;
      if (laborId != "") {
        url += "/$laborId";
      }

      ApiBaseHelper()
          .postMethodImagesFormData(
              url: url, fields: param, filesList: fileList)
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          laborId = parsedJson['labor']['id'].toString();
          Get.to(() => AddLabor2View(), arguments: {
            'laborId': '$laborId',
            'isUpdate': isUpdate,
            "data": laborDetail,
          });
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    } else {
      if (profileImage.value.path == '') {
        GetxHelper.showSnackBar(
            title: 'Error'.tr, message: 'Please select profile image'.tr);
      }
    }
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if (type == 1) {
        profileImage.value = File(image.path);
      } else if (type == 2) {
        passportCopy.value = File(image.path);
      }
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 1) {
        profileImage.value = File(image.path);
      } else if (type == 2) {
        passportCopy.value = File(image.path);
      }
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
