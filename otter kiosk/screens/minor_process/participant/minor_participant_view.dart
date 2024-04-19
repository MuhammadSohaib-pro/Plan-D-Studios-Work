import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:kiosk/helper/constants.dart';

import '../../../libraries.dart';

class MinorParticipantView extends StatelessWidget {
  MinorParticipantView({super.key});

  final MinorParticipantViewModel viewModel =
      Get.put(MinorParticipantViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: Get.context!.isLandscape && Get.context!.isPhone
                ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                : EdgeInsets.zero,
            child: Form(
              key: viewModel.FnameandLnameformkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    itemCount: viewModel.totalMinors,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          MinorTxt(index),
                          SizedBox(height: 20),
                          fNameAndLnameTxtField(index),
                          SizedBox(height: 20),
                          genderAndBirthDateTxtField(index),
                          SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                  nextBtn(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: forwordBackBtnRow(),
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
    );
  }

  Widget forwordBackBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.grey2,
            ),
            child: Icon(
              Icons.arrow_back,
              color: ThemeColors.white,
            ),
          ),
        ),
        GlobalVariables.photocapture.value
            ? Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeColors.errorRedColor,
                    ),
                    child: Text(
                      'By using this kiosk you consent to have your picture taken.'
                          .tr,
                      maxLines: 4,
                      style: TextStyle(color: ThemeColors.white),
                    )),
              )
            : SizedBox(),
        GestureDetector(
          onTap: () {
            if (viewModel.FnameandLnameformkey.currentState!.validate()) {
              viewModel.storewaivermodel();
              Get.to(() => MinorParentView());
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.isFormValid.value
                      ? ThemeColors.fullLightPrimary
                      : ThemeColors.grey2,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        ),
      ],
    );
  }

  Widget MinorTxt(int index) {
    int indx = index;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 6.5),
      padding: EdgeInsets.only(
          left: Get.context!.isTablet && Get.context!.isLandscape ? 5 : 0),
      child: Text(
        "Minor #".tr + "${indx + 1}",
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget fNameAndLnameTxtField(int index) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : 0),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3
                : double.infinity,
            child: CustomTextField2(
              hint: 'First Name'.tr,
              title: "First Name".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.controllerList[index].fNameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                viewModel.validateForm();
                viewModel.fnamecheckfields.value = value;
              },
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3
                : double.infinity,
            child: CustomTextField2(
              hint: 'Last Name'.tr,
              title: "Last Name".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.controllerList[index].lNameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                viewModel.validateForm();

                viewModel.lnamecheckfields.value = value;
              },
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget genderAndBirthDateTxtField(int index) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isPortrait
                ? Get.width / 5.5
                : Get.context!.isPhone
                    ? 20
                    : Get.width / 6.5),
        padding: EdgeInsets.only(
            left: Get.context!.isTablet && Get.context!.isLandscape ? 5 : 0),
        child: Wrap(runSpacing: 20, spacing: 20, children: [
          SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 3
                  : Get.context!.isTablet && Get.context!.isPortrait
                      ? Get.width / 3.3
                      : Get.context!.isPhone && Get.context!.isPortrait
                          ? Get.width / 2.4
                          : Get.width / 2.42,
              child: CustomTextField2(
                controller: viewModel.controllerList[index].genderController,
                onChanged: (value) {
                  viewModel.validateForm();
                },
                title: "Gender".tr,
                asterisk: true,
                hint: "Select Gender".tr,
                // textColor: ThemeColors.primaryColor,
                fillColor: ThemeColors.grey2.withOpacity(.1),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: const Color(0xff828A89),
                ),
                readOnly: true,
                onTap: () async {
                  await genderModelSheet(index);
                },
                validator: (value) {
                  print(value);
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              )),
          SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 3
                  : Get.context!.isTablet && Get.context!.isPortrait
                      ? Get.width / 3.3
                      : Get.context!.isPhone && Get.context!.isPortrait
                          ? Get.width / 2.4
                          : Get.width / 2.42,
              child: CustomTextField2(
                fillColor: ThemeColors.white,
                // textColor: ThemeColors.primaryColor,
                controller: viewModel.controllerList[index].dateController,

                // showCursor: false,
                hint: "MM/DD/YYYY".tr,
                title: "Birthday".tr,
                asterisk: true,
                suffixIcon: Icon(Icons.arrow_drop_down),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                readOnly: true,
                onChanged: (value) {
                  // viewModel.validateForm();
                },
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(3000),
                  );
                  if (dateTime != null) {
                    var dt = DateFormat.yMd().format(dateTime);
                    viewModel.controllerList[index].dateController.text = dt;
                    viewModel.controllerList[index].dob =
                        dateTime.toIso8601String();
                    viewModel.validateForm();
                  }
                },
              ))
        ]));
  }

  Future<dynamic> genderModelSheet(int index) {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(1, 0, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBtn3(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
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
                    initialItem: viewModel.controllerList[index].genderIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int i) {
                    viewModel.controllerList[index].genderIndex = i;
                  },
                  children: List.generate(
                    viewModel.controllerList[index].genderList.length,
                    (int i) {
                      return Center(
                        child: Text(
                          viewModel.controllerList[index].genderList[i],
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
              CustomTextBtn3(
                radius: 4,
                height: 30,
                width: double.minPositive,
                child: Text(
                  'Done'.tr,
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {
                  viewModel.controllerList[index].genderController.text =
                      viewModel.controllerList[index].genderList[
                          viewModel.controllerList[index].genderIndex];
                  viewModel.validateForm();

                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 6.3
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.isFormValid.value
                ? ThemeColors.fullLightPrimary
                : ThemeColors.grey2,
            child: Text(
              "Next".tr,
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              if (viewModel.FnameandLnameformkey.currentState!.validate()) {
                viewModel.storewaivermodel();
                Get.to(() => MinorParentView());
              }
            },
          )),
    );
  }
}
