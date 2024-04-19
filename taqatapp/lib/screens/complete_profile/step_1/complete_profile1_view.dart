import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/complete_profile/step_1/complete_profile1_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class CompleteProfile1View extends StatelessWidget {
  final CompleteProfile1ViewModel viewModel =
      Get.put(CompleteProfile1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: ScrollableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                progressBar(),
                completeYourProfileTxt(),
                Form(
                  key: viewModel.completeProfile1Key,
                  child: Column(
                    children: [
                      firstNameTxtField(),
                      lastNameTxtField(),
                    ],
                  ),
                ),
                genderTxtField(),
                dateOfBirthTxt(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: [
                      dayTxtField(),
                      SizedBox(width: 8),
                      monthTxtField(),
                      SizedBox(width: 8),
                      yearTxtField()
                    ],
                  ),
                ),
                ageTxtField(),
                Spacer(),
                continueBtn(),
              ],
            ),
          ),
        ),
        LoaderView(),
      ],
    );
  }

  Widget progressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
      child: Row(
        children: [
          linearProgressBar(),
          const SizedBox(width: 10),
          stepNoTxt(),
        ],
      ),
    );
  }

  Widget linearProgressBar() {
    return const Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          backgroundColor: Color(0xffC7D3EB),
          value: 0.33,
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xff0C8A7B),
          ),
          minHeight: 10,
          color: Color(0xffC7D3EB),
        ),
      ),
    );
  }

  Widget stepNoTxt() {
    return Text(
      'step 1 of 3'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Widget completeYourProfileTxt() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15, left: 24, right: 24),
      child: Text(
        "Complete Your Profile".tr,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Color(0xff1A1D1E),
        ),
      ),
    );
  }

  Widget firstNameTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.firstNameController,
        fillColor: Color(0xffFFFFFF),
        title: "First Name".tr,
        hintText: "First Name".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.text,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget lastNameTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: CustomTextField13(
        controller: viewModel.lastNameController,
        fillColor: Color(0xffFFFFFF),
        title: "Last Name".tr,
        hintText: "Last Name".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.text,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

Widget genderTxtField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: CustomTextField13(
        controller: viewModel.genderController,
        hintText: "Gender".tr,
        title: "Gender".tr,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          genderBottomSheet();
        },
      ),
    );
  }

  genderBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(1, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                    initialItem: viewModel.genderIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.genderIndex = index;
                    viewModel.genderController.text =
                        viewModel.genderList[index].tr;
                  },
                  children: List.generate(
                    viewModel.genderList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.genderList[index].tr,
                          style: TextStyle(
                            color: Color(0xff1A1D1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Done'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Widget dateOfBirthTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 5, top: 15, right: 24),
      child: Text(
        "Date Of Birth".tr,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff101817),
        ),
      ),
    );
  }

  Widget dayTxtField() {
    return Expanded(
      child: CustomTextField13(
        controller: viewModel.dayController,
        fillColor: const Color(0xffFFFFFF),
        hintText: "23",
        textColor: const Color(0xff828A89),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          daysBottomSheet();
        },
      ),
    );
  }

  daysBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text('Cancel'.tr),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                    initialItem: viewModel.daysIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.daysIndex = index;
                    viewModel.dayController.text =
                        viewModel.daysList[viewModel.daysIndex];
                    if (viewModel.yearController.text.isNotEmpty &&
                        viewModel.monthController.text.isNotEmpty) {
                      viewModel.calculateAge(
                          "${viewModel.yearController.text}-${viewModel.monthIndex + 1}-${viewModel.dayController.text}");
                    }
                  },
                  children: List.generate(
                    viewModel.daysList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.daysList[index],
                          style: TextStyle(
                            color: Get.theme.primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text('Done'.tr),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget monthTxtField() {
    return Expanded(
      child: CustomTextField13(
        controller: viewModel.monthController,
        fillColor: const Color(0xffFFFFFF),
        hintText: "Nov".tr,
        textColor: const Color(0xff828A89),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          monthsBottomSheet();
        },
      ),
    );
  }

  monthsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                    initialItem: viewModel.monthIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.monthIndex = index;
                    viewModel.monthController.text =
                        viewModel.monthsList[viewModel.monthIndex].tr;
                    if (viewModel.dayController.text.isNotEmpty &&
                        viewModel.yearController.text.isNotEmpty) {
                      viewModel.calculateAge(
                          "${viewModel.yearController.text}-${viewModel.monthIndex + 1}-${viewModel.dayController.text}");
                    }
                  },
                  children: List.generate(
                    viewModel.monthsList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.monthsList[index].tr,
                          style: TextStyle(
                            color: Color(0xff1A1D1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Done'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget yearTxtField() {
    return Expanded(
      child: CustomTextField13(
        controller: viewModel.yearController,
        fillColor: const Color(0xffFFFFFF),
        hintText: "1960",
        textColor: const Color(0xff828A89),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          yearsBottomSheet();
        },
      ),
    );
  }

  yearsBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(1, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                    initialItem: viewModel.yearIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.yearIndex = index;
                    viewModel.yearController.text =
                        viewModel.yearsList[viewModel.yearIndex];
                    if (viewModel.dayController.text.isNotEmpty &&
                        viewModel.monthController.text.isNotEmpty) {
                      viewModel.calculateAge(
                          "${viewModel.yearController.text}-${viewModel.monthIndex + 1}-${viewModel.dayController.text}");
                    }
                  },
                  children: List.generate(
                    viewModel.yearsList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.yearsList[index],
                          style: TextStyle(
                            color: Color(0xff1A1D1E),
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomTextBtn(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Done'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget ageTxtField() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 15, right: 24),
      child: CustomTextField13(
        controller: viewModel.ageController,
        fillColor: Color(0xffFFFFFF),
        title: "Age".tr,
        readOnly: true,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget continueBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Continue".tr,
        onPressed: () {
          viewModel.continueBtn();
        },
      ),
    );
  }
}
