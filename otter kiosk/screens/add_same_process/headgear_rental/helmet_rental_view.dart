import 'package:kiosk/helper/constants.dart';

import '../../../libraries.dart';

class HelmetRentalView extends StatelessWidget {
  HelmetRentalView({super.key});

  final HelmetRentalViewModel viewModel = Get.put(HelmetRentalViewModel());
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
            Obx(
              () => Padding(
                padding: Get.context!.isLandscape && Get.context!.isPhone
                    ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                    : EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    protectiveHeadGearTxt(),
                    SizedBox(height: 30),
                    rentalHeadGearTxt(),
                    SizedBox(height: 20),
                    rentalYesNoRadioBtn(),
                    SizedBox(height: 20),
                    viewModel.rentGroupValue.value == 'NO'
                        ? ownHeadGearTxt()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.rentGroupValue.value == 'NO'
                        ? SizedBox(height: 20)
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.rentGroupValue.value == 'NO'
                        ? ownYesNoRadioBtn()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.ownGroupValue.value == 'NO'
                        ? SizedBox(height: 20)
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.ownGroupValue.value == 'NO'
                        ? refuseTxt()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.ownGroupValue.value == 'NO'
                        ? SizedBox(height: 20)
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.ownGroupValue.value == 'NO'
                        ? agreeCheckBox()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.ownGroupValue.value == 'NO'
                        ? checkboxerror()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.rentGroupValue.value == 'NO'
                        ? SizedBox(height: 20)
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.rentGroupValue.value == 'NO'
                        ? nextBtn()
                        : Padding(padding: EdgeInsets.all(0)),
                    viewModel.rentGroupValue.value == 'NO'
                        ? SizedBox(height: 20)
                        : Padding(padding: EdgeInsets.all(0)),
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
            GlobalVariables.datamodel.helmetRentalRequired!
                ? viewModel.rentGroupValue.value == ''
                    ? GetxHelper.showSnackBar(
                        title: 'Error'.tr,
                        message: 'Please select atleast one option.'.tr)
                    : viewModel.rentGroupValue.value == 'YES'
                        ? GlobalVariables.datamodel.includeAccidentInsurance!
                            ? Get.to(() => AccidentalInsuranceView())
                            : GlobalVariables
                                    .datamodel.includeShootingExperience!
                                ? Get.to(() => ShootingExperienceView())
                                : GlobalVariables
                                        .datamodel.includeRulesOfFirearmSafety!
                                    ? Get.to(() => FirearmSafetyView())
                                    : adultviewModel.participatingTypeBtn
                                                    .value ==
                                                "Adult" ||
                                            adultviewModel.participatingTypeBtn
                                                    .value ==
                                                "Adult + Minor(s)"
                                        ? GlobalVariables
                                                .datamodel.includeQuestions4473!
                                            ? Get.to(() =>
                                                EligiablityRequirementView())
                                            : Get.to(() => WaiverView())
                                        : Get.to(() => WaiverView())
                        : viewModel.checkboxvalue.value
                            ? GlobalVariables
                                    .datamodel.includeAccidentInsurance!
                                ? Get.to(() => AccidentalInsuranceView())
                                : GlobalVariables
                                        .datamodel.includeShootingExperience!
                                    ? Get.to(() => ShootingExperienceView())
                                    : Get.to(() => FirearmSafetyView())
                            : null
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
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.rentGroupValue.value == ''
                      ? ThemeColors.grey2
                      : viewModel.rentGroupValue.value == 'YES'
                          ? ThemeColors.fullLightPrimary
                          : viewModel.ownGroupValue.value == 'YES'
                              ? ThemeColors.fullLightPrimary
                              : viewModel.checkboxvalue.value
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

  Widget protectiveHeadGearTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "PROTECTIVE RIDING HEADGEAR".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget rentalHeadGearTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Do you need to rent riding headgear? *".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget rentalYesNoRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 3
            : double.infinity,
        child: Row(
          children: [
            Radio(
              value: "YES".tr,
              groupValue: viewModel.rentGroupValue.value,
              onChanged: (value) {
                viewModel.storewaivermodel();

                viewModel.rentGroupValue.value = value!;
                GlobalVariables.datamodel.includeAccidentInsurance!
                    ? Get.to(() => AccidentalInsuranceView())
                    : GlobalVariables.datamodel.includeShootingExperience!
                        ? Get.to(() => ShootingExperienceView())
                        : GlobalVariables.datamodel.includeRulesOfFirearmSafety!
                            ? Get.to(() => FirearmSafetyView())
                            : adultviewModel.participatingTypeBtn.value ==
                                        "Adult" ||
                                    adultviewModel.participatingTypeBtn.value ==
                                        "Adult + Minor(s)"
                                ? Get.to(() => EligiablityRequirementView())
                                : Get.to(() => WaiverView());
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
              groupValue: viewModel.rentGroupValue.value,
              onChanged: (value) {
                viewModel.rentGroupValue.value = value!;
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

  Widget ownHeadGearTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Are you providing your own helmet?".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget ownYesNoRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 3
            : double.infinity,
        child: Obx(
          () => Row(
            children: [
              Radio(
                value: "YES".tr,
                groupValue: viewModel.ownGroupValue.value,
                onChanged: (value) {
                  viewModel.storewaivermodel();

                  viewModel.ownGroupValue.value = value!;
                  GlobalVariables.datamodel.includeAccidentInsurance!
                      ? Get.to(() => AccidentalInsuranceView())
                      : GlobalVariables.datamodel.includeShootingExperience!
                          ? Get.to(() => ShootingExperienceView())
                          : GlobalVariables
                                  .datamodel.includeRulesOfFirearmSafety!
                              ? Get.to(() => FirearmSafetyView())
                              : adultviewModel.participatingTypeBtn.value ==
                                          "Adult" ||
                                      adultviewModel
                                              .participatingTypeBtn.value ==
                                          "Adult + Minor(s)"
                                  ? Get.to(() => EligiablityRequirementView())
                                  : Get.to(() => WaiverView());
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
                groupValue: viewModel.ownGroupValue.value,
                onChanged: (value) {
                  viewModel.ownGroupValue.value = value!;
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

  Widget refuseTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Get.context!.isTablet && Get.context!.isLandscape
          ? Text(
              "I refuse to wear/rent a protective \nwetsuit & accept responsibility for \npotential risks. *"
                  .tr,
              maxLines: 5,
              style: TextStyle(
                fontSize: 15,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(
              "I refuse to wear/rent a protective wetsuit & accept responsibility for potential risks. *"
                  .tr,
              maxLines: 5,
              style: TextStyle(
                fontSize: 15,
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }

  Widget agreeCheckBox() {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isLandscape
                ? 150
                : Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 5.5
                    : 20),
        child: SizedBox(
          width: 150,
          child: Obx(() => SimpleCheckBox(
                value: viewModel.checkboxvalue.value,
                title: "I agree".tr,
                onChanged: (value) {
                  viewModel.checkboxvalue.value = value;
                },
              )),
        ));
  }

  Widget checkboxerror() {
    return Obx(() => viewModel.checkboxvalue.value
        ? SizedBox()
        : Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: Get.context!.isTablet && Get.context!.isLandscape
                    ? 150
                    : Get.context!.isTablet && Get.context!.isPortrait
                        ? Get.width / 5.5
                        : 30),
            child: Text(
              'You must agree before proceeding *'.tr,
              style: TextStyle(color: ThemeColors.errorRedColor),
            )));
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
            backgroundColor: viewModel.rentGroupValue.value == ''
                ? ThemeColors.grey2
                : viewModel.rentGroupValue.value == 'YES'
                    ? ThemeColors.fullLightPrimary
                    : viewModel.ownGroupValue.value == 'YES'
                        ? ThemeColors.fullLightPrimary
                        : viewModel.checkboxvalue.value
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
              viewModel.storewaivermodel();

              GlobalVariables.datamodel.helmetRentalRequired!
                  ? viewModel.rentGroupValue.value == ''
                      ? GetxHelper.showSnackBar(
                          title: 'Error',
                          message: 'Please select atleast one option.')
                      : viewModel.rentGroupValue.value == 'YES'
                          ? GlobalVariables.datamodel.includeAccidentInsurance!
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
                          : viewModel.checkboxvalue.value
                              ? GlobalVariables
                                      .datamodel.includeAccidentInsurance!
                                  ? Get.to(() => AccidentalInsuranceView())
                                  : GlobalVariables
                                          .datamodel.includeShootingExperience!
                                      ? Get.to(() => ShootingExperienceView())
                                      : Get.to(() => FirearmSafetyView())
                              : null
                  : GlobalVariables.datamodel.includeAccidentInsurance!
                      ? Get.to(() => AccidentalInsuranceView())
                      : GlobalVariables.datamodel.includeShootingExperience!
                          ? Get.to(() => ShootingExperienceView())
                          : GlobalVariables
                                  .datamodel.includeRulesOfFirearmSafety!
                              ? Get.to(() => FirearmSafetyView())
                              : adultviewModel.participatingTypeBtn.value ==
                                          "Adult" ||
                                      adultviewModel
                                              .participatingTypeBtn.value ==
                                          "Adult + Minor(s)"
                                  ? Get.to(() => EligiablityRequirementView())
                                  : Get.to(() => WaiverView());
            },
          )),
    );
  }
}
