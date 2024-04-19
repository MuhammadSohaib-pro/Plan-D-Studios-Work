import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/add_labor/step_3/add_labor3_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class AddLabor3View extends StatelessWidget {
  final AddLabor3ViewModel viewModel = Get.put(AddLabor3ViewModel());

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
                Form(
                  key: viewModel.addLabor3Key,
                  child: salaryTxtField(),
                ),
                locationTxtField(),
                occupationTxtField(),
                martialStatusTxtField(),
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
          value: 0.75,
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
      'step 3 of 4'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Widget salaryTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.salaryController,
        fillColor: Color(0xffFFFFFF),
        title: "Monthly Salary (OMR)".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.number,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'\d')),
        ],
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget locationTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.locationController,
        fillColor: Color(0xffFFFFFF),
        title: "Location".tr,
        hintText: "Current Location".tr,
        textColor: Color(0xff828A89),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          locationBottomSheet();
        },
      ),
    );
  }

  locationBottomSheet() {
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
                    initialItem: viewModel.locationIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.locationIndex = index;
                    viewModel.locationController.text =
                        viewModel.locationList[index].tr;
                  },
                  children: List.generate(
                    viewModel.locationList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.locationList[index].tr,
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

  Widget occupationTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.occupationController,
        hintText: "Select".tr,
        title: "Occupation".tr,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          occupationBottomSheet();
        },
      ),
    );
  }

  occupationBottomSheet() {
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
                    initialItem: viewModel.occupationIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.occupationIndex = index;
                    viewModel.occupationController.text =
                        viewModel.occupationList[index].title ?? '';
                  },
                  children: List.generate(
                    viewModel.occupationList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.occupationList[index].title ?? '',
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

  Widget martialStatusTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.martialStatusController,
        hintText: "Select".tr,
        title: "Martial Status".tr,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          martialStatusBottomSheet();
        },
      ),
    );
  }

  martialStatusBottomSheet() {
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
                    initialItem: viewModel.martialStatusIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.martialStatusIndex = index;
                    viewModel.martialStatusController.text =
                        viewModel.martialStatusList[index].tr;
                  },
                  children: List.generate(
                    viewModel.martialStatusList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.martialStatusList[index].tr,
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

  Widget continueBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
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
