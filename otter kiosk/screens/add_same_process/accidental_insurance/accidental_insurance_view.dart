import '../../../libraries.dart';

class AccidentalInsuranceView extends StatelessWidget {
  AccidentalInsuranceView({super.key});

  final AccidentalInsuranceViewModel viewModel =
      Get.put(AccidentalInsuranceViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: Get.context!.isLandscape
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Obx(
              () => Padding(
                padding:
                    //Get.context!.isLandscape && Get.context!.isPhone
                    //     ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                    //     :
                    EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    accidentInsuranceTxt(),
                    SizedBox(height: 20),
                    accidentTxt(),
                    SizedBox(height: 20),
                    accidentYesNoRadioBtn(),
                    SizedBox(height: 20),
                    purchaseInsurnaceTxt(),
                    SizedBox(height: 20),
                    purchaseInsurnaceYesNoRadioBtn(),
                    SizedBox(height: 20),
                  ],
                ),
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
            GlobalVariables.datamodel.accidentInsuranceRequired!
                ? viewModel.accidentGroupValue.value != '' &&
                        viewModel.purchaseInsuranceGroupValue.value != ''
                    ? GlobalVariables.datamodel.includeShootingExperience!
                        ? Get.to(() => ShootingExperienceView())
                        : GlobalVariables.datamodel.includeRulesOfFirearmSafety!
                            ? Get.to(() => FirearmSafetyView())
                            : adultviewModel.participatingTypeBtn.value ==
                                        "Adult" ||
                                    adultviewModel.participatingTypeBtn.value ==
                                        "Adult + Minor(s)"
                                ? GlobalVariables
                                        .datamodel.includeQuestions4473!
                                    ? Get.to(() => EligiablityRequirementView())
                                    : Get.to(() => WaiverView())
                                : Get.to(() => WaiverView())
                    : GetxHelper.showSnackBar(
                        title: 'Error', message: 'Select an option.')
                : GlobalVariables.datamodel.includeShootingExperience!
                    ? Get.to(() => ShootingExperienceView())
                    : GlobalVariables.datamodel.includeRulesOfFirearmSafety!
                        ? Get.to(() => FirearmSafetyView())
                        : adultviewModel.participatingTypeBtn.value ==
                                    "Adult" ||
                                adultviewModel.participatingTypeBtn.value ==
                                    "Adult + Minor(s)"
                            ? GlobalVariables.datamodel.includeQuestions4473!
                                ? Get.to(() => EligiablityRequirementView())
                                : Get.to(() => WaiverView())
                            : Get.to(() => WaiverView());
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.accidentGroupValue.value != '' &&
                          viewModel.purchaseInsuranceGroupValue.value != ''
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

  Widget accidentInsuranceTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 3.5
                  : 20),
      child: Text(
        "Accident Insurance".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accidentTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5
                  : 20),
      child: Text(
        "Would you like to be covered in case of an accident? *".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget accidentYesNoRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.7
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 2.8
            : double.infinity,
        child: Row(
          children: [
            Radio(
              value: "YES".tr,
              groupValue: viewModel.accidentGroupValue.value,
              onChanged: (value) {
                viewModel.accidentGroupValue.value = value!;
                checknavigation();
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
              groupValue: viewModel.accidentGroupValue.value,
              onChanged: (value) {
                viewModel.accidentGroupValue.value = value!;
                checknavigation();
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
      ),
    );
  }

  Widget purchaseInsurnaceTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5
                  : 20),
      child: Text(
        "Would you like to be covered in case of an accident? *",
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget purchaseInsurnaceYesNoRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 4.7
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 2.8
            : double.infinity,
        child: Row(
          children: [
            Radio(
              value: "YES".tr,
              groupValue: viewModel.purchaseInsuranceGroupValue.value,
              onChanged: (value) {
                viewModel.purchaseInsuranceGroupValue.value = value!;
                checknavigation();
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
              groupValue: viewModel.purchaseInsuranceGroupValue.value,
              onChanged: (value) {
                viewModel.purchaseInsuranceGroupValue.value = value!;
                checknavigation();
              },
            ),
            SizedBox(width: 20),
            Text("NO".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ],
        ),
      ),
    );
  }

  checknavigation() {
    if (viewModel.purchaseInsuranceGroupValue.value != '' &&
        viewModel.accidentGroupValue.value != '') {
      print('navigate');
      viewModel.storewaiverModel();
      GlobalVariables.datamodel.includeShootingExperience!
          ? Get.to(() => ShootingExperienceView())
          : GlobalVariables.datamodel.includeRulesOfFirearmSafety!
              ? Get.to(() => FirearmSafetyView())
              : adultviewModel.participatingTypeBtn.value == "Adult" ||
                      adultviewModel.participatingTypeBtn.value ==
                          "Adult + Minor(s)"
                  ? GlobalVariables.datamodel.includeQuestions4473!
                      ? Get.to(() => EligiablityRequirementView())
                      : Get.to(() => WaiverView())
                  : Get.to(() => WaiverView());
    } else {
      print('dont navigate');
    }
  }
}
