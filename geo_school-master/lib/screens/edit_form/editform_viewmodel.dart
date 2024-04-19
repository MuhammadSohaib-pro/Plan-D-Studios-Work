import 'package:geo_school/database/database_helper.dart';
import 'package:geo_school/database/image_model.dart';
import 'package:geo_school/helper/CommonFunctions.dart';
import 'package:geo_school/helper/global_variables.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/screens/schoollist/schoollist_viewmodel.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:geo_school/screens/form/dropdown_model.dart';
import 'package:geo_school/screens/thankyou/thankyou_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditFormViewModel extends GetxController {

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
  RxString buildingMaterial = 'brick'.tr.obs;
  SchoolListModel schoolListModel = SchoolListModel();
  String recordId = "0";
  DBHelper db = DBHelper();
  List<SchoolListModel> schools = [];
  List<SchoolListModel> schoolSuggestion = <SchoolListModel>[].obs;
  FocusNode dropDownFocus = FocusNode();
  List<DropDownModel> buildingMaterialList = [
    DropDownModel(id: "Please Select", name: 'pleaseSelect'.tr),
    DropDownModel(id: "brick", name: 'brick'.tr),
    DropDownModel(id: "straw", name: 'straw'.tr),
    DropDownModel(id: "mix", name: 'mix'.tr),
  ].obs;
  List<DbImageModel> images = <DbImageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    setData();
  }

  @override
  void onClose() {
    super.onClose();
    Loader.loader.value = false;
    dropDownFocus.dispose();
  }

  setData() async {
    recordId = GetStorage().read('id');
    schoolListModel = await db.getSchool(recordId);

    if(GlobalVariables.currentLocation != null){
      latitudeController.text = GlobalVariables.currentLocation.latitude.toString();
      longitudeController.text = GlobalVariables.currentLocation.longitude.toString();
    }

    if (schoolListModel.buildingMaterial == 'N/A' || schoolListModel.buildingMaterial == null) {
      buildingMaterial.value = buildingMaterialList[0].name ?? '';
    } else {
      buildingMaterial.value = CommonFunctions.getValueFromDropDown(buildingMaterialList, schoolListModel.buildingMaterial ?? '');
    }

    electricityCbValue.value =
        (schoolListModel.electricity == '1') ? 'Yes' : 'No';
    waterCbValue.value = (schoolListModel.water == '1') ? 'Yes' : 'No';
    internetCbValue.value = (schoolListModel.internet == '1') ? 'Yes' : 'No';
    toiletCbValue.value = (schoolListModel.toilet == '1') ? 'Yes' : 'No';
    schoolNameController.text = schoolListModel.name?.capitalizeFirst ?? '';
    descriptionController.text = schoolListModel.description ?? '';
    regionController.text = schoolListModel.regionName?.capitalizeFirst ?? '';
    townController.text = schoolListModel.townshipName?.capitalizeFirst ?? '';
    departmentController.text = schoolListModel.departmentName?.capitalizeFirst ?? '';
    latitudeController.text = schoolListModel.lat ?? '';
    longitudeController.text = schoolListModel.lng ?? '';
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
      schoolListModel.lat = latitudeController.text;
      schoolListModel.lng = longitudeController.text;
      schoolListModel.recordUploaded = "false";
      schoolListModel.modified = "1";
      int res = await db.updateSchool(schoolListModel);
      if (res == 1) {
        Get.off(() => ThankYouView());
        SchoolListViewModel model = Get.find();
        model.loadOfflineData();
      }
    }
  }

}

