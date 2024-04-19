import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/screens/add_labor/step_1/add_labor1_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class AddLabor1View extends StatelessWidget {
  final AddLabor1ViewModel viewModel = Get.put(AddLabor1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            ScrollableColumn(
              children: [
                progressBar(),
                profileImage(),
                Form(
                  key: viewModel.addLabor1Key,
                  child: Column(
                    children: [
                      nameTxtField(),
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
                      passportNoTxtField(),
                    ],
                  ),
                ),
                Obx(
                  () => documentSelectionItem(
                    title: 'Passport Photo'.tr,
                    file: viewModel.passportCopy.value,
                    onTap: () {
                      viewModel.type = 2;
                      selectImageBottomSheet();
                    },
                  ),
                ),
                Spacer(),
                continueBtn(),
              ],
            ),
            LoaderView()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(viewModel.isUpdate ? 'Update Labor'.tr : 'Add Labor'.tr),
    );
  }

  Widget progressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
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
          value: 0.25,
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
      'step 1 of 4'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Stack(
        children: [
          Obx(
            () => Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: const Color(0xffFFFFFF),
                borderRadius: BorderRadius.circular(50),
              ),
              child: viewModel.profileImage.value.path.isEmpty
                  ? Icon(
                      Icons.person,
                      size: 80,
                      color: Color(0xffB3B3B3),
                    )
                  : CircleAvatar(
                      backgroundColor: const Color(0xffFFFFFF),
                      backgroundImage: FileImage(
                        viewModel.profileImage.value,
                      ),
                    ),
            ),
          ),
          Positioned(
            left: 80,
            top: 70,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: cameraBtn(),
            ),
          )
        ],
      ),
    );
  }

  Widget cameraBtn() {
    return InkWell(
      onTap: () {
        viewModel.type = 1;
        selectImageBottomSheet();
      },
      child: Container(
        height: 27,
        width: 27,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          Icons.camera_alt,
          size: 20,
          color: Color(0xffB3B3B3),
        ),
      ),
    );
  }

  selectImageBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Image'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.5,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              BottomSheetItemRow(
                title: 'Photo Library'.tr,
                icon: CupertinoIcons.photo_on_rectangle,
                onTap: () {
                  viewModel.imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera'.tr,
                icon: CupertinoIcons.photo_camera,
                onTap: () {
                  viewModel.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nameTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.nameController,
        fillColor: Color(0xffFFFFFF),
        title: "Name".tr,
        hintText: "Full Name".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.emailAddress,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget passportNoTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.passportNoController,
        fillColor: Color(0xffFFFFFF),
        title: "Passport Number".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.number,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget dateOfBirthTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 5, top: 15, right: 24),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Date Of Birth".tr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xff101817),
          ),
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
      padding: const EdgeInsets.only(left: 24, top: 15, right: 24, bottom: 15),
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

  Widget documentSelectionItem(
      {required GestureTapCallback? onTap,
      required String title,
      required File file,
      String? asterick}) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.mainColor,
          width: 0.5,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1D1E),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        asterick != null
                            ? Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Icon(
                      Icons.add,
                      color: ThemeColors.mainColor,
                    ),
                  ],
                ),
                file.path != ''
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 140,
                        color: Colors.grey.shade300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : SizedBox(height: 0),
              ],
            ),
          ),
        ),
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
