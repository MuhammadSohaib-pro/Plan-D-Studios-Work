import 'package:kiosk/helper/constants.dart';

import '../../../libraries.dart';

class FirearmSafetyView extends StatelessWidget {
  FirearmSafetyView({super.key});

  final FirearmSafetyViewModel viewModel = Get.put(FirearmSafetyViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment:
              // Get.context!.isTablet && Get.context!.isLandscape
              //     ? CrossAxisAlignment.center
              //     :
              CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Get.context!.isLandscape && Get.context!.isPhone
                  ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  primaryRuleTxt(),
                  SizedBox(height: 30),
                  allCheckBoxes(),
                  SizedBox(height: 20),
                  if (GlobalVariables
                      .datamodel.rulesOfFirearmSafetyRequired!) ...[
                    checkboxerror(),
                    SizedBox(height: 20),
                  ]
                ],
              ),
            ),
          ],
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
            if (GlobalVariables.datamodel.rulesOfFirearmSafetyRequired!) {
              if (viewModel.safeDirectionCheckBox.value &&
                  viewModel.fingerOffTheTriggerCheckBox.value &&
                  viewModel.gunLoadedCheckBox.value &&
                  viewModel.beSureOfYourTargetCheckBox.value) {
                if (adultviewModel.participatingTypeBtn.value == "Adult" ||
                        adultviewModel.participatingTypeBtn.value ==
                            "Adult + Minor(s)"
                    // processViewModel.participatingTypeBtn.value == "Adult" ||
                    //   processViewModel.participatingTypeBtn.value ==
                    //       "Adult + Minor(s)"
                    ) {
                  GlobalVariables.datamodel.includeQuestions4473!
                      ? Get.to(() => EligiablityRequirementView())
                      : Get.to(() => WaiverView());
                } else {
                  Get.to(() => WaiverView());
                }
              }
            } else {
              if (adultviewModel.participatingTypeBtn.value == "Adult" ||
                  adultviewModel.participatingTypeBtn.value ==
                      "Adult + Minor(s)") {
                GlobalVariables.datamodel.includeQuestions4473!
                    ? Get.to(() => EligiablityRequirementView())
                    : Get.to(() => WaiverView());
              } else {
                Get.to(() => WaiverView());
              }
            }
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.fullLightPrimary,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget primaryRuleTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5
                  : 20),
      child: Text(
        "4 Primary Rules of Firearm Safety".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget allCheckBoxes() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 1
            : double.infinity,
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Always keep firearm pointed in a safe direction".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SimpleCheckBox(
                    title: "I agree".tr,
                    value: viewModel.safeDirectionCheckBox.value,
                    onChanged: (value) {
                      viewModel.safeDirectionCheckBox.value = value;
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2. Treat all guns as though they are loaded".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SimpleCheckBox(
                    title: "I agree".tr,
                    value: viewModel.gunLoadedCheckBox.value,
                    onChanged: (value) {
                      viewModel.gunLoadedCheckBox.value = value;
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3. Keep your finger off the trigger until you are ready to shoot"
                        .tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SimpleCheckBox(
                    title: "I agree".tr,
                    value: viewModel.fingerOffTheTriggerCheckBox.value,
                    onChanged: (value) {
                      viewModel.fingerOffTheTriggerCheckBox.value = value;
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4. Always be sure of your target and what’s beyond It".tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  SimpleCheckBox(
                    title: "I agree".tr,
                    value: viewModel.beSureOfYourTargetCheckBox.value,
                    onChanged: (value) {
                      viewModel.beSureOfYourTargetCheckBox.value = value;
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkboxerror() {
    return Obx(() => viewModel.safeDirectionCheckBox.value &&
            viewModel.gunLoadedCheckBox.value &&
            viewModel.fingerOffTheTriggerCheckBox.value &&
            viewModel.beSureOfYourTargetCheckBox.value
        ? SizedBox()
        : Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: Get.context!.isTablet && Get.context!.isLandscape
                    ? 150
                    : Get.context!.isTablet && Get.context!.isPortrait
                        ? Get.width / 5
                        : 20),
            child: Text(
              'You must agree all before proceeding *'.tr,
              style: TextStyle(color: ThemeColors.errorRedColor),
            )));
  }
}
