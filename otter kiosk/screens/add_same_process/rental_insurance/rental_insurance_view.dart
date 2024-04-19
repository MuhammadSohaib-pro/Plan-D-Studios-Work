import '../../../libraries.dart';

class RentalInsuranceView extends StatelessWidget {
  RentalInsuranceView({super.key});

  final RentalInsuranceViewModel viewModel =
      Get.put(RentalInsuranceViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: Get.context!.isTablet &&
                  (Get.context!.isLandscape || Get.context!.isPortrait)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment:
                  Get.context!.isTablet && Get.context!.isPortrait
                      ? CrossAxisAlignment.center
                      : Get.context!.isLandscape
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                doYouNeedRentalInsuranceTxt(),
                SizedBox(height: 20),
                yesNoRadioBtn(),
                SizedBox(height: 20),
              ],
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
            checknavigation();
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
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget doYouNeedRentalInsuranceTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "Do you need rental insurance?".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget yesNoRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 3
            : double.infinity,
        child: Obx(
          () => Row(
            mainAxisAlignment: Get.context!.isTablet && Get.context!.isPortrait
                ? MainAxisAlignment.center
                : Get.context!.isLandscape
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
            children: [
              Radio(
                value: "YES".tr,
                groupValue: viewModel.groupValue.value,
                onChanged: (value) {
                  viewModel.groupValue.value = value!;
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
                groupValue: viewModel.groupValue.value,
                onChanged: (value) {
                  viewModel.groupValue.value = value!;
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
      ),
    );
  }

  checknavigation() {
    viewModel.storewaivermodel();

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
