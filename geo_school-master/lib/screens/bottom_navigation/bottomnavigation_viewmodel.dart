import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/helper/ApiBaseHelper.dart';
import 'package:geo_school/helper/urls.dart';
import 'package:geo_school/screens/location/location_view.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/screens/map/map_view.dart';
import 'package:geo_school/screens/schoollist/schoollist_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BottomNavigationViewModel extends GetxController {
  RxInt selectedIndex = 0.obs;
  DBHelper db = DBHelper();



  @override
  void onInit() async {
    super.onInit();
    db = DBHelper();
    DBHelper.initDatabase();
  }


  Future<bool> onBackPressed(BuildContext context) async {
    if (selectedIndex.value != 0) {
      selectedIndex.value = 0;
      return true;
    } else {
      final value = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('areYouSureYou'.tr),
              actions: <Widget>[
                TextButton(
                  child: Text('no'.tr),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('yes'.tr),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });

      return value == true;
    }
  }

  Widget selectView(int index) {
    switch (index) {
      case 0:
        submitData();
        return LocationView();
      case 1:
        submitData();
        return MapView();
      case 2:
        submitData();
        return SchoolListView();
      default:
        return Container(
          height: 300.0,
          width: Get.width,
          color: Colors.red,
        );
    }
  }

  exitApplicationDialog(BuildContext context) {}

  @override
  void onReady() async {
    super.onReady();
    // await submitData();
  }

  submitData() async {
    db = DBHelper();
    String userId = GetStorage().read('code');

    List<SchoolListModel> allSchoolsList = [];
    List<SchoolListModel> schoolsToUpdateList = [];

    allSchoolsList.addAll(await db.getAllSchools());
    schoolsToUpdateList
        .addAll(allSchoolsList.where((s) => s.recordUploaded == 'false'));

    for (int i = 0; i < schoolsToUpdateList.length; i++) {
      Map<String, dynamic> param = {
        'user_id': userId,
        'name': schoolsToUpdateList[i].name,
        'altitude': schoolsToUpdateList[i].altitude,
        'region_id': schoolsToUpdateList[i].regionId,
        'township_id': schoolsToUpdateList[i].townshipId,
        'department_id': schoolsToUpdateList[i].departmentId,
        'electricity': schoolsToUpdateList[i].electricity,
        'water': schoolsToUpdateList[i].water,
        'internet': schoolsToUpdateList[i].internet,
        'toilet': schoolsToUpdateList[i].toilet,
        'building_material': schoolsToUpdateList[i].buildingMaterial,
        'description': schoolsToUpdateList[i].description,
        'accuracy': schoolsToUpdateList[i].accuracy,
        'lat': schoolsToUpdateList[i].lat,
        'lng': schoolsToUpdateList[i].lng,
        'school_id': schoolsToUpdateList[i].schoolId
      };

      ApiBaseHelper()
          .post(url: Urls.saveSchool, body: param, isFormData: false)
          .then((responseJson) {
        Map<String, dynamic> parsedJSON = jsonDecode(responseJson);
        print(parsedJSON);
        if (parsedJSON['result']['status'] == 'true') {
          schoolsToUpdateList[i].recordUploaded = 'true';
          db.updateSchool(schoolsToUpdateList[i]);
        }
      });
    }
  }
}
