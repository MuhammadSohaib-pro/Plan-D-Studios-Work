
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/add_labor/step_2/add_labor2_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class AddLabor2View extends StatelessWidget {
  final AddLabor2ViewModel viewModel = Get.put(AddLabor2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            ScrollableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                progressBar(),
                genderTxtField(),
                nationalityTxtField(),
                religionTxtField(context),
                Form(
                  key: viewModel.addLabor2Key,
                  child: Column(
                    children: [
                      experienceTxtField(),
                    ],
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
          value: 0.5,
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
      'step 2 of 4'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Widget experienceTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: CustomTextField13(
        controller: viewModel.experienceController,
        fillColor: Color(0xffFFFFFF),
        title: "Year Of Experience".tr,
        hintText: "",
        textColor: Color(0xff828A89),
        inputFormatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType:
            TextInputType.numberWithOptions(decimal: false, signed: false),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget genderTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.genderController,
        hintText: viewModel.genderList[viewModel.genderIndex].tr,
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

  Widget nationalityTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: countryFlagTextField(
        title: 'Country'.tr,
        keyboardType: TextInputType.text,
        initialValue: viewModel.countryCode.value,
        controller: viewModel.nationalityController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value!);
        },
        onChanged: (val) {
          viewModel.nationalityController.text = val.toCountryStringOnly();
        },
      ),
    );
  }

  Widget religionTxtField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.religionController,
        hintText: "Religion".tr,
        title: "Select Religion".tr,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon: const Icon(
          Icons.arrow_drop_down,
          color: const Color(0xff828A89),
        ),
        readOnly: true,
        onTap: () {
          religionBottomSheet();
        },
      ),
    );
  }

  religionBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: new FixedExtentScrollController(
                      initialItem: viewModel.religionIndex),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.religionIndex = index;
                    viewModel.religionController.text =
                        viewModel.religionList[index].tr;
                  },
                  children: List.generate(
                    viewModel.religionList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.religionList[index].tr,
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
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Done'.tr,
                  style: TextStyle(
                    color: const Color(0xff0C8A7B),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
