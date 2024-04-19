import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/helper/ApiBaseHelper.dart';
import 'package:geo_school/helper/errors.dart';
import 'package:geo_school/helper/urls.dart';
import 'package:geo_school/screens/bottom_navigation/bottomnavigation_view.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/getx_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginViewModel extends GetxController {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  RxBool rememberMeCb = false.obs;
  DBHelper db = DBHelper();

  @override
  void onReady() {
    super.onReady();
    DBHelper.initDatabase();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
  }

  Future<bool> onBackPressed(BuildContext context) async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Do you want to exit?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });

    return value == true;
  }

  loginButton() async {
    if (loginKey.currentState!.validate()) {
      Loader.loader.value = true;

      Map<String, dynamic> _param = {
        'code': codeController.text,
      };

      ApiBaseHelper()
          .post(url: Urls.login, body: _param, isFormData: true)
          .then((responseJson) async {
        Loader.loader.value = false;
        try {
          Map<String, dynamic> parsedJSON = jsonDecode(responseJson);
          log(parsedJSON.toString());

          if (parsedJSON['result']['status'] == 'true') {
            if (parsedJSON['result']['data']['status'] == 'active') {
              String id = parsedJSON['result']['data']['id'];
              await GetStorage().write('remember_me', 'true');
              await GetStorage().write('code', id);
              await GetStorage().write('loginDate', DateTime.now().toString());
              loadSchoolListData(id);

              Get.offAll(() => BottomNavigationView());
            } else {
              GetxHelper.showSnackBar1(
                  title: 'error'.tr, message: 'inactiveAccount'.tr);
            }
          } else {
            GetxHelper.showSnackBar1(
                title: 'error'.tr,
                message: parsedJSON['result']['description']);
          }
        } on FormatException {
          GetxHelper.showSnackBar1(
              title: 'error'.tr, message: Errors.formatError);
        }
      });
    }
  }

  loadSchoolListData(String id) async {
    Map<String, dynamic> _params = {'user_id': id};

    ApiBaseHelper()
        .post(url: Urls.listSchools, body: _params, isFormData: true)
        .then((responseJson) async {
      try {
        List<SchoolListModel> dataList = <SchoolListModel>[].obs;
        Map<String, dynamic> parsedJSON = jsonDecode(responseJson);
        var data = parsedJSON['result']['data'] as List;

        dataList.addAll(data
            .map<SchoolListModel>((json) => SchoolListModel.fromJson(json))
            .toList());

        for (int i = 0; i < data.length; i++) {
          SchoolListModel model = SchoolListModel.fromJson(data[i]);
          model.recordUploaded = 'true';
          db.insertSchool(model.toJson());

          // for (int i = 0; i < model.images.length; i++) {
          //   File image = CommonFunctions.convertBase64ToImage(model.images[i]);
          //   String filePath =
          //       await CommonFunctions.copyImageToAppDirectory(image);
          //   DbImageModel dbImageModel =
          //       DbImageModel(schoolId: model.schoolId, imagePath: filePath);
          //   db.insertImage(dbImageModel.toJson());
          // }
        }
      } catch (e) {
        GetxHelper.showSnackBar1(
            title: 'Error', message: 'Something went wrong');
        await GetStorage().remove('remember_me');
        await GetStorage().remove('code');
      }
    });
  }
}
