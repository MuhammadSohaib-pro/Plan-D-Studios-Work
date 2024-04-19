import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/add_labor/step_4/add_labor4_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class AddLabor4View extends StatelessWidget {
  final AddLabor4ViewModel viewModel = Get.put(AddLabor4ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      appBar: appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            ScrollableColumn(
              children: [
                progressBar(),
                forLaborHireSwitch(),
                coupleWorkerSwitch(),
                applicationTypeTxtField(),
                Form(
                  key: viewModel.addLabor4Key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      educationTxtField(),
                      jobTypeTxt(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            partTimeBtn(),
                            const SizedBox(width: 10),
                            fullTimeBtn(),
                            const SizedBox(width: 10),
                            contractBtn(),
                          ],
                        ),
                      ),
                      laborSponsorFeeTxtField(),
                    ],
                  ),
                ),
                Spacer(),
                completeBtn(),
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
          value: 1.0,
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
      'step 4 of 4'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Widget forLaborHireSwitch() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Open for Hire".tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff101817),
            ),
          ),
          Obx(
            () => CupertinoSwitch(
              activeColor: const Color(0xff0C8A7B),
              value: viewModel.forLaborHireBtn.value,
              onChanged: (newvalue) {
                viewModel.forLaborHireBtn.value = newvalue;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget coupleWorkerSwitch() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'We Are Couples Workers'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xff101817),
            ),
          ),
          Obx(
            () => CupertinoSwitch(
              activeColor: const Color(0xff0C8A7B),
              value: viewModel.coupleWorkerBtn.value,
              onChanged: (newvalue) {
                viewModel.coupleWorkerBtn.value = newvalue;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget applicationTypeTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.applicationTypeController,
        hintText: "Select".tr,
        title: "Application Type".tr,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        onTap: () {
          applicationTypeBottomSheet();
        },
      ),
    );
  }

  applicationTypeBottomSheet() {
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
                    initialItem: viewModel.applicationTypeIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.applicationTypeIndex = index;
                    viewModel.applicationTypeController.text =
                        viewModel.applicationTypeList[index].tr;
                  },
                  children: List.generate(
                    viewModel.applicationTypeList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.applicationTypeList[index].tr,
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

  Widget educationTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: CustomTextField13(
        controller: viewModel.educationController,
        title: "Education".tr,
        hintText: "Education".tr,
        keyboardType: TextInputType.text,
        textColor: const Color(0xff828A89),
        fillColor: const Color(0xffFFFFFF),
        sufixIcon:
            const Icon(Icons.arrow_drop_down, color: const Color(0xff828A89)),
        readOnly: true,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
        onTap: () {
          educationBottomSheet();
        },
      ),
    );
  }

  educationBottomSheet() {
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
                    initialItem: viewModel.educationIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.educationIndex = index;
                    viewModel.educationController.text =
                        viewModel.educationList[index].tr;
                  },
                  children: List.generate(
                    viewModel.educationList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.educationList[index].tr,
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

  Widget jobTypeTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 10, right: 24),
      child: Text(
        "Job Type".tr,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xff101817),
        ),
      ),
    );
  }

  Widget partTimeBtn() {
    return Obx(
      () => Expanded(
        child: CustomButton8(
          backgroundColor: viewModel.jobTypeBtn.value == "Part time"
              ? const Color(0xff0C8A7B)
              : const Color(0xffEFF2F1),
          textColor: viewModel.jobTypeBtn.value == "Part time"
              ? const Color(0xffEFF2F1)
              : const Color(0xff828A89),
          text: "Part Time".tr,
          onPressed: viewModel.jobTypeBtn.value == "Part time"
              ? () {}
              : () {
                  viewModel.jobTypeBtn.value = "Part time";
                },
        ),
      ),
    );
  }

  Widget fullTimeBtn() {
    return Obx(() => Expanded(
          child: CustomButton8(
            backgroundColor: viewModel.jobTypeBtn.value == "Full time"
                ? const Color(0xff0C8A7B)
                : const Color(0xffEFF2F1),
            textColor: viewModel.jobTypeBtn.value == "Full time"
                ? const Color(0xffEFF2F1)
                : const Color(0xff828A89),
            text: "Full Time".tr,
            onPressed: viewModel.jobTypeBtn.value == "Full time"
                ? () {}
                : () {
                    viewModel.jobTypeBtn.value = "Full time";
                  },
          ),
        ));
  }

  Widget contractBtn() {
    return Obx(() => Expanded(
          child: CustomButton8(
            backgroundColor: viewModel.jobTypeBtn.value == "Contract"
                ? const Color(0xff0C8A7B)
                : const Color(0xffEFF2F1),
            textColor: viewModel.jobTypeBtn.value == "Contract"
                ? const Color(0xffEFF2F1)
                : const Color(0xff828A89),
            text: "Contract".tr,
            onPressed: viewModel.jobTypeBtn.value == "Contract"
                ? () {}
                : () {
                    viewModel.jobTypeBtn.value = "Contract";
                  },
          ),
        ));
  }

  Widget laborSponsorFeeTxtField() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 15, bottom: 10, right: 24),
      child: CustomTextField13(
        controller: viewModel.feeController,
        fillColor: Color(0xffFFFFFF),
        title: "Labor Sponsor Transfer Fee (OMR)".tr,
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'\d')),
        ],
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.number,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget completeBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Complete".tr,
        onPressed: () {
          viewModel.completeBtn();
        },
      ),
    );
  }
}
