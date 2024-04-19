import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/user_model.dart';

class UploadIDViewModel extends GetxController {
  Rx<File> sponsorLaborID = File('').obs;

  @override
  void onReady() {
    super.onReady();
  }

  imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      sponsorLaborID.value = File(image.path);
    }
  }

  imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      sponsorLaborID.value = File(image.path);
    }
  }

  uploadBtn() async {
    if (sponsorLaborID.value.path != '') {
      GlobalVariables.showLoader.value = true;
      List<http.MultipartFile> fileList = [
        await http.MultipartFile.fromPath(
          'sponsor_id',
          sponsorLaborID.value.path,
        )
      ];

      ApiBaseHelper()
          .postMethodImagesFormData(
        url: Urls.onlySponsorId,
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
              title: 'Success'.tr,
              message: "Documents uploaded successfully".tr);
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr, message: Errors.generalApiError);
        }
      }).catchError((e) {
        GlobalVariables.showLoader.value = false;
        print(e);
      });
    } else {
      GetxHelper.showSnackBar(
          title: 'Error'.tr, message: 'Please Select ID'.tr);
    }
  }
}
