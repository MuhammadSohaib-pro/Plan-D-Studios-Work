import '../../../helper/constants.dart';
import '../../../libraries.dart';

class HearAboutUsView extends StatelessWidget {
  HearAboutUsView({super.key});

  final HearAboutUsViewModel viewModel = Get.put(HearAboutUsViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: Get.context!.isTablet && Get.context!.isLandscape
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Get.context!.isLandscape && Get.context!.isPhone
                  ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  hearAboutUsTxt(),
                  SizedBox(height: 20),
                  allCheckBoxes(),
                  SizedBox(height: 20),
                  nextBtn(),
                  SizedBox(height: 20),
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
            viewModel.storewaiverModel();
            GlobalVariables.datamodel.hearAboutUsRequired!
                ? viewModel.searchSEngineheckBox.value ||
                        viewModel.familyCheckBox.value ||
                        viewModel.socialMediaCheckBox.value ||
                        viewModel.blogCheckBox.value ||
                        viewModel.radioCheckBox.value ||
                        viewModel.televisionCheckBox.value ||
                        viewModel.streamingCheckBox.value ||
                        viewModel.billBoardCheckBox.value ||
                        viewModel.emailCheckBox.value ||
                        viewModel.otherCheckBox.value
                    ? GlobalVariables.datamodel.includeWetsuitRental!
                        ? Get.to(() => WetSuitRentalView())
                        : GlobalVariables.datamodel.includeHelmetRental!
                            ? Get.to(() => HelmetRentalView())
                            : GlobalVariables
                                    .datamodel.includeAccidentInsurance!
                                ? Get.to(() => AccidentalInsuranceView())
                                : GlobalVariables
                                        .datamodel.includeShootingExperience!
                                    ? Get.to(() => ShootingExperienceView())
                                    : GlobalVariables.datamodel
                                            .includeRulesOfFirearmSafety!
                                        ? Get.to(() => FirearmSafetyView())
                                        : adultviewModel.participatingTypeBtn
                                                        .value ==
                                                    "Adult" ||
                                                adultviewModel
                                                        .participatingTypeBtn
                                                        .value ==
                                                    "Adult + Minor(s)"
                                            ? Get.to(() =>
                                                EligiablityRequirementView())
                                            : Get.to(() => WaiverView())
                    : GetxHelper.showSnackBar(
                        title: 'Error'.tr,
                        message: 'Select atleast one option'.tr)
                : GlobalVariables.datamodel.includeWetsuitRental!
                    ? Get.to(() => WetSuitRentalView())
                    : GlobalVariables.datamodel.includeHelmetRental!
                        ? Get.to(() => HelmetRentalView())
                        : GlobalVariables.datamodel.includeAccidentInsurance!
                            ? Get.to(() => AccidentalInsuranceView())
                            : GlobalVariables
                                    .datamodel.includeShootingExperience!
                                ? Get.to(() => ShootingExperienceView())
                                : GlobalVariables
                                        .datamodel.includeRulesOfFirearmSafety!
                                    ? Get.to(() => FirearmSafetyView())
                                    : adultviewModel.participatingTypeBtn.value ==
                                                "Adult" ||
                                            adultviewModel.participatingTypeBtn
                                                    .value ==
                                                "Adult + Minor(s)"
                                        ? GlobalVariables
                                                .datamodel.includeQuestions4473!
                                            ? Get.to(() =>
                                                EligiablityRequirementView())
                                            : Get.to(() => WaiverView())
                                        : Get.to(() => WaiverView());
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.searchSEngineheckBox.value ||
                          viewModel.familyCheckBox.value ||
                          viewModel.socialMediaCheckBox.value ||
                          viewModel.blogCheckBox.value ||
                          viewModel.radioCheckBox.value ||
                          viewModel.televisionCheckBox.value ||
                          viewModel.streamingCheckBox.value ||
                          viewModel.billBoardCheckBox.value ||
                          viewModel.emailCheckBox.value ||
                          viewModel.otherCheckBox.value
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

  Widget hearAboutUsTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "How did you hear about us?".tr,
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
                  ? Get.width / 5.5
                  : 20),
      child: Container(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? 40.w
            : double.infinity,
        child: Obx(
          () => Column(
            children: [
              SimpleCheckBox2(
                title: "Search Engine (Google, Bing, etc)".tr,
                onChanged: (value) {
                  viewModel.searchSEngineheckBox.value = value;
                },
                value: viewModel.searchSEngineheckBox.value,
              ),
              // SizedBox(height: 5),
              SimpleCheckBox2(
                title: "Family / Friend / Coworker".tr,
                onChanged: (value) {
                  viewModel.familyCheckBox.value = value;
                },
                value: viewModel.familyCheckBox.value,
              ),
              SimpleCheckBox2(
                title: "Social Media".tr,
                onChanged: (value) {
                  viewModel.socialMediaCheckBox.value = value;
                },
                value: viewModel.socialMediaCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Blog or publication".tr,
                onChanged: (value) {
                  viewModel.blogCheckBox.value = value;
                },
                value: viewModel.blogCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Radio".tr,
                onChanged: (value) {
                  viewModel.radioCheckBox.value = value;
                },
                value: viewModel.radioCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Television".tr,
                onChanged: (value) {
                  viewModel.televisionCheckBox.value = value;
                },
                value: viewModel.televisionCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Streaming Service Ad".tr,
                onChanged: (value) {
                  viewModel.streamingCheckBox.value = value;
                },
                value: viewModel.streamingCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Billboard".tr,
                onChanged: (value) {
                  viewModel.billBoardCheckBox.value = value;
                },
                value: viewModel.billBoardCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Email".tr,
                onChanged: (value) {
                  viewModel.emailCheckBox.value = value;
                },
                value: viewModel.emailCheckBox.value,
              ),

              SimpleCheckBox2(
                title: "Other".tr,
                onChanged: (value) {
                  viewModel.otherCheckBox.value = value;
                },
                value: viewModel.otherCheckBox.value,
              ),
              SizedBox(height: 15),
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
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.searchSEngineheckBox.value ||
                    viewModel.familyCheckBox.value ||
                    viewModel.socialMediaCheckBox.value ||
                    viewModel.blogCheckBox.value ||
                    viewModel.radioCheckBox.value ||
                    viewModel.televisionCheckBox.value ||
                    viewModel.streamingCheckBox.value ||
                    viewModel.billBoardCheckBox.value ||
                    viewModel.emailCheckBox.value ||
                    viewModel.otherCheckBox.value
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
              viewModel.storewaiverModel();
              GlobalVariables.datamodel.hearAboutUsRequired!
                  ? viewModel.searchSEngineheckBox.value ||
                          viewModel.familyCheckBox.value ||
                          viewModel.socialMediaCheckBox.value ||
                          viewModel.blogCheckBox.value ||
                          viewModel.radioCheckBox.value ||
                          viewModel.televisionCheckBox.value ||
                          viewModel.streamingCheckBox.value ||
                          viewModel.billBoardCheckBox.value ||
                          viewModel.emailCheckBox.value ||
                          viewModel.otherCheckBox.value
                      ? GlobalVariables.datamodel.includeWetsuitRental!
                          ? Get.to(() => WetSuitRentalView())
                          : GlobalVariables.datamodel.includeHelmetRental!
                              ? Get.to(() => HelmetRentalView())
                              : GlobalVariables
                                      .datamodel.includeAccidentInsurance!
                                  ? Get.to(() => AccidentalInsuranceView())
                                  : GlobalVariables
                                          .datamodel.includeShootingExperience!
                                      ? Get.to(() => ShootingExperienceView())
                                      : GlobalVariables.datamodel
                                              .includeRulesOfFirearmSafety!
                                          ? Get.to(() => FirearmSafetyView())
                                          : adultviewModel.participatingTypeBtn
                                                          .value ==
                                                      "Adult" ||
                                                  adultviewModel
                                                          .participatingTypeBtn
                                                          .value ==
                                                      "Adult + Minor(s)"
                                              ? Get.to(() =>
                                                  EligiablityRequirementView())
                                              : Get.to(() => WaiverView())
                      : GetxHelper.showSnackBar(
                          title: 'Error'.tr,
                          message: 'Select atleast one option'.tr)
                  : GlobalVariables.datamodel.includeWetsuitRental!
                      ? Get.to(() => WetSuitRentalView())
                      : GlobalVariables.datamodel.includeHelmetRental!
                          ? Get.to(() => HelmetRentalView())
                          : GlobalVariables.datamodel.includeAccidentInsurance!
                              ? Get.to(() => AccidentalInsuranceView())
                              : GlobalVariables
                                      .datamodel.includeShootingExperience!
                                  ? Get.to(() => ShootingExperienceView())
                                  : GlobalVariables.datamodel
                                          .includeRulesOfFirearmSafety!
                                      ? Get.to(() => FirearmSafetyView())
                                      : adultviewModel.participatingTypeBtn
                                                      .value ==
                                                  "Adult" ||
                                              adultviewModel
                                                      .participatingTypeBtn
                                                      .value ==
                                                  "Adult + Minor(s)"
                                          ? Get.to(() =>
                                              EligiablityRequirementView())
                                          : Get.to(() => WaiverView());
            },
          )),
    );
  }
}
