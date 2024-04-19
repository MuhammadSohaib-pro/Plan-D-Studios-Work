import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/helper/CommonFunctions.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/screens/schoollist/schoollist_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:geo_school/screens/form/dropdown_model.dart';
import 'package:geo_school/screens/thankyou/thankyou_view.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormViewModel extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController scrollController = ScrollController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController connectionSpeedController = TextEditingController();
  TextEditingController totalStudentsController = TextEditingController();
  TextEditingController girlsController = TextEditingController();
  TextEditingController boysController = TextEditingController();
  TextEditingController teachingStaffController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  RxString electricityCbValue = 'Yes'.obs;
  RxString waterCbValue = 'Yes'.obs;
  RxString internetCbValue = 'Yes'.obs;
  RxString toiletCbValue = 'Yes'.obs;
  RxString mobileNetworkValue = 'Yes'.obs;
  RxString fencingValue = 'Yes'.obs;
  RxString libraryValue = 'Yes'.obs;
  RxString computerRoomValue = 'Yes'.obs;
  String accuracy = '';
  double latitude = 0.0;
  double longitude = 0.0;
  double altitude = 0.0;
  List<SchoolListModel> schools = [];
  List<SchoolListModel> schoolSuggestion = <SchoolListModel>[].obs;
  SchoolListModel schoolListModel = SchoolListModel();
  DBHelper db = DBHelper();
  FocusNode  dropDownFocus = FocusNode();
  RxString selectedSchool = ''.obs;
  RxString buildingMaterial = 'brick'.tr.obs;
  List<DropDownModel> buildingMaterialList = [
    DropDownModel(id: "Please Select", name: 'pleaseSelect'.tr),
    DropDownModel(id: "brick", name: 'brick'.tr),
    DropDownModel(id: "straw", name: 'straw'.tr),
    DropDownModel(id: "mix", name: 'mix'.tr),
  ].obs;

  FormViewModel({required LatLng latLng, required double altitude, required String accuracy}) {
    this.latitude = latLng.latitude;
    this.longitude = latLng.longitude;
    this.altitude = altitude;
  }

  @override
  void onReady() {
    latitudeController.text = latitude.toString();
    longitudeController.text = longitude.toString();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
    dropDownFocus.dispose();
  }

  loadSchoolData(int index) async {
    schoolListModel = schoolSuggestion[index];
    schoolNameController.text = schoolListModel.name ?? '';
    selectedSchool.value = schoolNameController.text;
    schoolNameController.selection = TextSelection.collapsed(offset: schoolNameController.text.length);
    schoolSuggestion.clear();
    regionController.text = schoolListModel.regionName?.capitalizeFirst ?? '';
    townController.text =  schoolListModel.townshipName?.capitalizeFirst ?? '';
    departmentController.text = schoolListModel.departmentName?.capitalizeFirst ?? '';
    dropDownFocus.requestFocus();

  }

  getSchoolSuggestions(String name) async {
    if (schools.length < 1) {
      try {
        List<SchoolListModel> mySchools = [];

        mySchools.addAll(await db.getAllSchools());
        schools.addAll(await db.getAllSchools());

      } catch (ex) {}
    }

    if (name.length > 0 && schools.length > 0) {
      schoolSuggestion.clear();
      schoolSuggestion.addAll(schools.where((element) => element.name!.toLowerCase().startsWith(name.toLowerCase())).take(7));

      for (int i = 0; i < schoolSuggestion.length; i++) {
        schoolSuggestion[i].name = schoolSuggestion[i].name?.capitalizeFirst ?? '';
      }
    } else {
      schoolSuggestion.clear();
      regionController.text = '';
      townController.text = '';
      departmentController.text = '';
    }
    selectedSchool.value = '';
  }

  updateOfflineData() async {
    if (formKey.currentState!.validate()) {
      schoolListModel.buildingMaterial = CommonFunctions.getIdFromDropDown(
          buildingMaterialList, buildingMaterial);
      schoolListModel.electricity =
          (electricityCbValue.value == 'Yes') ? '1' : '0';
      schoolListModel.water = (waterCbValue.value == 'Yes') ? '1' : '0';
      schoolListModel.internet = (internetCbValue.value == 'Yes') ? '1' : '0';
      schoolListModel.toilet = (toiletCbValue.value == 'Yes') ? '1' : '0';
      schoolListModel.description = descriptionController.text;
      schoolListModel.accuracy = accuracy;
      schoolListModel.altitude = altitude.toString();
      schoolListModel.lat = latitudeController.text;
      schoolListModel.lng = longitudeController.text;
      schoolListModel.modified = "1";
      schoolListModel.recordUploaded = "false";
      int res = await db.updateSchool(schoolListModel);
      if (res == 1) {
        Get.off(() => ThankYouView());
        try {
          SchoolListViewModel model = Get.find();
          model.loadOfflineData();
        } catch (e) {}
      }
    }
  }


  getALLSchools() async {
    List<SchoolListModel> schools = await db.getAllSchools();
  }
}
