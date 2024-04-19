import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class UploadDocumentViewModel extends GetxController {
  Rx<File> salaryCertificateFile = File('').obs;
  Rx<File> marriageCertificateFile = File('').obs;
  int type = 3;

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  setData() async {
    GlobalVariables.showLoader.value = true;
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
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if (type == 1) {
        salaryCertificateFile.value = File(image.path);
      } else if (type == 2) {
        marriageCertificateFile.value = File(image.path);
      }
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 1) {
        salaryCertificateFile.value = File(image.path);
      } else if (type == 2) {
        marriageCertificateFile.value = File(image.path);
      }
    }
  }

  uploadBtn() async {
    if (salaryCertificateFile.value.path != '' &&
        marriageCertificateFile.value.path != '') {
      GlobalVariables.showLoader.value = true;
      List<http.MultipartFile> fileList = [
        await http.MultipartFile.fromPath(
          'salary_certificate',
          salaryCertificateFile.value.path,
        ),
        await http.MultipartFile.fromPath(
          'marriage_certificate',
          marriageCertificateFile.value.path,
        ),
      ];

      ApiBaseHelper()
          .postMethodImagesFormData(
        url: Urls.uploadDocument,
        filesList: fileList,
      )
          .then((parsedJson) {
        GlobalVariables.showLoader.value = false;
        if (parsedJson['success'] == true) {
          GlobalVariables.userModel.value =
              UserModel.fromJson(parsedJson['user']);
          GetStorage().write('user', parsedJson['user']);
          Get.back();
          GetxHelper.showSnackBar(
              title: 'Congratulations'.tr, message: "Documents uploaded successfully".tr);
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: Errors.generalApiError.tr);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    } else {
      GetxHelper.showSnackBar(
          title: 'Error'.tr, message: 'Please select both document'.tr);
    }
  }
}
