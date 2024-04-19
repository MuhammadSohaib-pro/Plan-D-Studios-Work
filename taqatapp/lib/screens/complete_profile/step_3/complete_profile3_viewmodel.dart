import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:http/http.dart' as http;
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/complete_profile/complete_profile_5.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class CompleteProfile3ViewModel extends GetxController {
  GlobalKey<FormState> completeProfile4Key = GlobalKey<FormState>();
  Rx<File> sponsorIDFile = File('').obs;
  Rx<File> salaryCertificateFile = File('').obs;
  Rx<File> marriageCertificateFile = File('').obs;
  int type = 4;

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  setData() async {
    try {
      GlobalVariables.showLoader.value = true;
      if (GlobalVariables.userModel.value.sponsorId != null) {
        await CommonFunctions.downloadFileFromUrl(
                url: Urls.userSponsorId +
                    GlobalVariables.userModel.value.sponsorId!)
            .then((value) {
          sponsorIDFile.value = value;
        });

        print(Urls.userSponsorId + GlobalVariables.userModel.value.sponsorId!);
      }

      if (GlobalVariables.userModel.value.salaryCertificate != null) {
        await CommonFunctions.downloadFileFromUrl(
                url: Urls.userSalaryCertificate +
                    GlobalVariables.userModel.value.salaryCertificate!)
            .then((value) {
          salaryCertificateFile.value = value;
        });
        print(Urls.userSalaryCertificate +
            GlobalVariables.userModel.value.salaryCertificate!);
      }

      if (GlobalVariables.userModel.value.marriageCertificate != null) {
        await CommonFunctions.downloadFileFromUrl(
                url: Urls.userMarriageCertificate +
                    GlobalVariables.userModel.value.marriageCertificate!)
            .then((value) {
          marriageCertificateFile.value = value;
        });
        print(Urls.userMarriageCertificate +
            GlobalVariables.userModel.value.marriageCertificate!);
      }

      GlobalVariables.showLoader.value = false;
    } catch (e) {
      GlobalVariables.showLoader.value = false;
    }
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if (type == 1) {
        sponsorIDFile.value = File(image.path);
      } else if (type == 2) {
        salaryCertificateFile.value = File(image.path);
      } else if (type == 3) {
        marriageCertificateFile.value = File(image.path);
      }
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 1) {
        sponsorIDFile.value = File(image.path);
      } else if (type == 2) {
        salaryCertificateFile.value = File(image.path);
      } else if (type == 3) {
        marriageCertificateFile.value = File(image.path);
      }
    }
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  completeBtn() async {
    if (sponsorIDFile.value.path == '' &&
        salaryCertificateFile.value.path == '' &&
        marriageCertificateFile.value.path == '') {
      GlobalVariables.showLoader.value = true;
      Get.to(() => CompleteProfile5View());
      GlobalVariables.showLoader.value = false;
    } else {
      GlobalVariables.showLoader.value = true;
      List<http.MultipartFile> fileList = [];
      if (sponsorIDFile.value.path != '') {
        fileList.add(await http.MultipartFile.fromPath(
          'sponsor_id',
          sponsorIDFile.value.path,
        ));
      }
      if (salaryCertificateFile.value.path != '') {
        fileList.add(await http.MultipartFile.fromPath(
          'salary_certificate',
          salaryCertificateFile.value.path,
        ));
      }

      if (marriageCertificateFile.value.path != '') {
        fileList.add(await http.MultipartFile.fromPath(
          'marriage_certificate',
          marriageCertificateFile.value.path,
        ));
      }

      ApiBaseHelper()
          .postMethodImagesFormData(
        url: Urls.complete_profile_4,
        filesList: fileList,
      )
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['user']);
          GetStorage().write('user', parsedJson['user']);
          GlobalVariables.profileCompletion.value = 100;
          Get.to(() => CompleteProfile5View());
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: Errors.generalApiError.tr);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    }
  }
}
