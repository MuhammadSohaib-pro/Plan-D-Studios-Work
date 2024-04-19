import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/screens/filter/gender_model.dart';
import 'package:taqat/screens/filter/occupation_model.dart';
import 'package:taqat/screens/search/search_viewmodel.dart';

class FilterViewModel extends GetxController {
  GlobalKey<FormState> completeProfile4Key = GlobalKey<FormState>();
  TextEditingController nationalityController = TextEditingController();
  String selectedGender = '';
  List<GenderModel> genderList = <GenderModel>[
    GenderModel(title: '   Male   '.tr, isSelected: true, id: 'male'),
    GenderModel(title: 'Female'.tr, isSelected: false, id: 'female'),
    GenderModel(title: '  Other  '.tr, isSelected: false, id: 'other'),
  ].obs;

  List<OccupationModelSelection> occupationList =
      <OccupationModelSelection>[].obs;
  RxBool experiencedBtn = true.obs;
  RxInt minFee = 0.obs;
  RxInt maxFee = 1.obs;

  final SearchViewModel searchViewModel = Get.find();
  Rx<RangeValues> rangeValues = RangeValues(0, 0).obs;

  @override
  void onInit() {
    rangeValues.value = RangeValues(
        searchViewModel.min.toDouble(), searchViewModel.max.toDouble());

    minFee.value = searchViewModel.min;
    maxFee.value = searchViewModel.max;
    super.onInit();
  }

  @override
  void onReady() {
    filOccupationList();
    super.onReady();
  }

  @override
  void onClose() {
    nationalityController.dispose();
    super.onClose();
  }

  filOccupationList() {
    SearchViewModel model = Get.find();
    for (int i = 0; i < model.occupationList.length; i++) {
      occupationList.add(OccupationModelSelection(
          isSelected: false, occupationModel: model.occupationList[i]));
    }
  }

  applyFilterBtn() {
    int indexValue = occupationList.indexWhere((e) => e.isSelected == true);

    Map<String, dynamic> params = {
      "fullname": "",
      "occupation": indexValue != -1
          ? occupationList[indexValue].occupationModel?.id.toString()
          : "",
      "gender": selectedGender,
      "labor_hiring_fees": "",
      "nationality": nationalityController.text,
      "recent": "asc",
      "min": minFee.value,
      "max": maxFee.value,
      "end":10
    };

    print(params);
    Get.back(result: params);
  }
}
