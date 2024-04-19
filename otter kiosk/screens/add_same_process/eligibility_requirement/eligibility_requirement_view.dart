import 'package:kiosk/helper/constants.dart';

import '../../../libraries.dart';

class EligiablityRequirementView extends StatelessWidget {
  EligiablityRequirementView({super.key});

  final EligiablityRequirementViewModel viewModel =
      Get.put(EligiablityRequirementViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: Get.context!.isLandscape && Get.context!.isPhone
                  ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment:
                    Get.context!.isTablet && Get.context!.isLandscape
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      eligibilityRequirementsTxt(),
                      SizedBox(height: 20),
                      allRadioBtns(),
                      SizedBox(height: 20),
                      nextBtn(),
                      SizedBox(height: 20),
                    ],
                  ),
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
            if (GlobalVariables.datamodel.questions4473Required! == true) {
              viewModel.groupValue1.value != '' &&
                      viewModel.groupValue2.value != '' &&
                      viewModel.groupValue3.value != '' &&
                      viewModel.groupValue4.value != '' &&
                      viewModel.groupValue5.value != '' &&
                      viewModel.groupValue6.value != '' &&
                      viewModel.groupValue7.value != '' &&
                      viewModel.groupValue8.value != '' &&
                      viewModel.groupValue9.value != '' &&
                      viewModel.groupValue10.value != ''
                  ? Get.to(() => WaiverView())
                  : GetxHelper.showSnackBar(
                      title: 'Error', message: 'Fields are required');
            } else {
              Get.to(() => WaiverView());
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.groupValue1.value != '' &&
                          viewModel.groupValue2.value != '' &&
                          viewModel.groupValue3.value != '' &&
                          viewModel.groupValue4.value != '' &&
                          viewModel.groupValue5.value != '' &&
                          viewModel.groupValue6.value != '' &&
                          viewModel.groupValue7.value != '' &&
                          viewModel.groupValue8.value != '' &&
                          viewModel.groupValue9.value != '' &&
                          viewModel.groupValue10.value != ''
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

  Widget eligibilityRequirementsTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Eligibility Requirements".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget allRadioBtns() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 10
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 2
            : double.infinity,
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Are you under indictment or information in any court for a felony, or any other crime, for which the judge could imprison you for more than a year? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue1.value,
                        onChanged: (value) {
                          viewModel.groupValue1.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue1.value,
                        onChanged: (value) {
                          viewModel.groupValue1.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2. Have you ever been convicted in any court of a felony, or any other crime, for which the judge could have imprisoned you for more than one year, even if you received a shorter sentence including probation? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue2.value,
                        onChanged: (value) {
                          viewModel.groupValue2.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue2.value,
                        onChanged: (value) {
                          viewModel.groupValue2.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3. Have you ever been adjudicated mentally defective or committed to a mental institution? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue3.value,
                        onChanged: (value) {
                          viewModel.groupValue3.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue3.value,
                        onChanged: (value) {
                          viewModel.groupValue3.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4. Are you an unlawful user of, or addicted to, marijuana or any depressant, stimulant, narcotic drug, or any other controlled substance?*"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue4.value,
                        onChanged: (value) {
                          viewModel.groupValue4.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue4.value,
                        onChanged: (value) {
                          viewModel.groupValue4.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "5. Are you a fugitive from justice? *".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue5.value,
                        onChanged: (value) {
                          viewModel.groupValue5.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue5.value,
                        onChanged: (value) {
                          viewModel.groupValue5.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "6. Have you ever been discharged from the Armed Forces under dishonorable conditions? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue6.value,
                        onChanged: (value) {
                          viewModel.groupValue6.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue6.value,
                        onChanged: (value) {
                          viewModel.groupValue6.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "7. Have you ever been convicted in court of a misdemeanor crime of domestic violence? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue7.value,
                        onChanged: (value) {
                          viewModel.groupValue7.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue7.value,
                        onChanged: (value) {
                          viewModel.groupValue7.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "8. Are you subject to a court order restraining you from harassing, stalking or threatening your child, intimate partner or child of such a partner? *"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue8.value,
                        onChanged: (value) {
                          viewModel.groupValue8.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue8.value,
                        onChanged: (value) {
                          viewModel.groupValue8.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "9. Are you a untited states citizen?".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue9.value,
                        onChanged: (value) {
                          viewModel.groupValue9.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "YES".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 20),
                      Radio(
                        value: "NO".tr,
                        groupValue: viewModel.groupValue9.value,
                        onChanged: (value) {
                          viewModel.groupValue9.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        "NO".tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10. Are you sure all the answers above are correct? *".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Radio(
                        value: "YES".tr,
                        groupValue: viewModel.groupValue10.value,
                        onChanged: (value) {
                          viewModel.groupValue10.value = value!;
                        },
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          "YES,everything's correct".tr,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 250
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.groupValue1.value != '' &&
                    viewModel.groupValue2.value != '' &&
                    viewModel.groupValue3.value != '' &&
                    viewModel.groupValue4.value != '' &&
                    viewModel.groupValue5.value != '' &&
                    viewModel.groupValue6.value != '' &&
                    viewModel.groupValue7.value != '' &&
                    viewModel.groupValue8.value != '' &&
                    viewModel.groupValue9.value != '' &&
                    viewModel.groupValue10.value != ''
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
              if (GlobalVariables.datamodel.questions4473Required! == true) {
                viewModel.groupValue1.value != '' &&
                        viewModel.groupValue2.value != '' &&
                        viewModel.groupValue3.value != '' &&
                        viewModel.groupValue4.value != '' &&
                        viewModel.groupValue5.value != '' &&
                        viewModel.groupValue6.value != '' &&
                        viewModel.groupValue7.value != '' &&
                        viewModel.groupValue8.value != '' &&
                        viewModel.groupValue9.value != '' &&
                        viewModel.groupValue10.value != ''
                    ? Get.to(() => WaiverView())
                    : GetxHelper.showSnackBar(
                        title: 'Error', message: 'Fields are required');
              } else {
                Get.to(() => WaiverView());
              }
            },
          )),
    );
  }
}
