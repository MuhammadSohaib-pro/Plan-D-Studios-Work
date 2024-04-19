import '../../../libraries.dart';

class EmergencyContactView extends StatelessWidget {
  EmergencyContactView({super.key});

  final EmergencyContactViewModel viewModel =
      Get.put(EmergencyContactViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: Get.context!.isLandscape && Get.context!.isPhone
                ? EdgeInsets.symmetric(horizontal: 10.w)
                : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                emergencyContactTxt(),
                SizedBox(height: 30),
                fullNameAndPhoneTxtField(),
                SizedBox(height: 20),
                nextBtn(),
                SizedBox(height: 20),
              ],
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
            viewModel.storeviewmodel();
            GlobalVariables.datamodel.includeLocalAddress!
                ? Get.to(() => LocalAddressView())
                : GlobalVariables.includeshortanswer
                    ? Get.to(() => SingleLineQuestionView())
                    : GlobalVariables.includeradiobutton
                        ? Get.to(() => SingleChoiceRadioBtnView())
                        : GlobalVariables.includecheckbox
                            ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                            : GlobalVariables.includeparagraph
                                ? Get.to(() => ParagraphQuestionView())
                                : checknavigation();
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: viewModel.name.value != '' && viewModel.phone.value
                        ? ThemeColors.fullLightPrimary
                        : ThemeColors.grey2),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        ),
      ],
    );
  }

  Widget emergencyContactTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 6.5
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Emergency Contact".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget fullNameAndPhoneTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 6.4
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3
                : double.infinity,
            child: CustomTextField2(
              hint: 'Full Name'.tr,
              title: "Full Name".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.fullNameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              onChanged: (value) {
                viewModel.name.value = value;
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
            child: countryFlagNumberTextField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: viewModel.phoneController,
              keyboardType: TextInputType.phone,
              initialvalue: viewModel.number,
              title: "Phone".tr,
              asterisk: true,
              showCursor: true,
              onChanged: (v) {
                viewModel.phone.value = v;
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

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 6.5
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.name.value != '' && viewModel.phone.value
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
              viewModel.storeviewmodel();
              GlobalVariables.datamodel.includeLocalAddress!
                  ? Get.to(() => LocalAddressView())
                  : GlobalVariables.includeshortanswer
                      ? Get.to(() => SingleLineQuestionView())
                      : GlobalVariables.includeradiobutton
                          ? Get.to(() => SingleChoiceRadioBtnView())
                          : GlobalVariables.includecheckbox
                              ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                              : GlobalVariables.includeparagraph
                                  ? Get.to(() => ParagraphQuestionView())
                                  : checknavigation();
            },
          )),
    );
  }

  checknavigation() {
    GlobalVariables.datamodel.includeHearAboutUs!
        ? Get.to(() => HearAboutUsView())
        : GlobalVariables.datamodel.includeWetsuitRental!
            ? Get.to(() => WetSuitRentalView())
            : GlobalVariables.datamodel.includeHelmetRental!
                ? Get.to(() => HelmetRentalView())
                : GlobalVariables.datamodel.includeAccidentInsurance!
                    ? Get.to(() => AccidentalInsuranceView())
                    : GlobalVariables.datamodel.includeShootingExperience!
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
                                : Get.to(() => WaiverView());
  }
}
