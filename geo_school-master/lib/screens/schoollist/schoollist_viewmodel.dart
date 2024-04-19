import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/screens/bottom_navigation/bottomnavigation_viewmodel.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:get/get.dart';
import 'package:geo_school/screens/edit_form/editform_view.dart';
import 'package:get_storage/get_storage.dart';

class SchoolListViewModel extends GetxController {
  List<SchoolListModel> dataList = <SchoolListModel>[].obs;
  DBHelper db = DBHelper();
  @override
  void onReady() {
    super.onReady();
    loadOfflineData();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
  }

  loadOfflineData() async {
    dataList.clear();
    BottomNavigationViewModel model = Get.find();
    model.submitData();
    db.getAllSchools().then((value) => dataList.addAll(value));
  }


  editSchool(String id) {
    GetStorage().write('id', id);
    Get.to(() => EditFormView());
  }
}
