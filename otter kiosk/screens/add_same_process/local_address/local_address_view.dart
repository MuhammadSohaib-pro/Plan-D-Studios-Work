import 'package:kiosk/helper/check_navigation.dart';

import '../../../libraries.dart';

class LocalAddressView extends StatelessWidget {
  LocalAddressView({super.key});

  final LocalAddressViewModel viewModel = Get.put(LocalAddressViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
            child: Center(
          child: Container(
            child: Padding(
              padding: Get.context!.isLandscape && Get.context!.isPhone
                  ? EdgeInsets.symmetric(horizontal: 10.w)
                  : EdgeInsets.zero,
              child: Form(
                key: viewModel.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    localAddressTxt(),
                    SizedBox(height: 30),
                    countryAndStreetAddressTxtField(),
                    SizedBox(height: 20),
                    cityStateAndZipCodeTxtField(),
                    SizedBox(height: 20),
                    nextBtn(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        )),
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
            viewModel.storewaivermodel();
            if (GlobalVariables.datamodel.addresslocalRequired!) {
              if (viewModel.formkey.currentState!.validate()) {
                GlobalVariables.includeshortanswer
                    ? Get.to(() => SingleLineQuestionView())
                    : GlobalVariables.includeradiobutton
                        ? Get.to(() => SingleChoiceRadioBtnView())
                        : GlobalVariables.includecheckbox
                            ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                            : GlobalVariables.includeparagraph
                                ? Get.to(() => ParagraphQuestionView())
                                : Navigation.checknavigation();
              }
            } else {
              GlobalVariables.includeshortanswer
                  ? Get.to(() => SingleLineQuestionView())
                  : GlobalVariables.includeradiobutton
                      ? Get.to(() => SingleChoiceRadioBtnView())
                      : GlobalVariables.includecheckbox
                          ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                          : GlobalVariables.includeparagraph
                              ? Get.to(() => ParagraphQuestionView())
                              : Navigation.checknavigation();
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.chkvalidate.value == true
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

  Widget localAddressTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 110
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Local address".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget countryAndStreetAddressTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 110
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
            child: countryFlagTextField(
              initialValue: 'United States'.tr,
              title: "Country".tr,
              asterisk: true,
              controller: viewModel.countryController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value!);
              },
              onChanged: (val) {
                viewModel.countryController.text = val.toCountryStringOnly();
              },
            ),
          ),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3
                : double.infinity,
            child: CustomTextField2(
              hint: 'Street Address'.tr,
              title: "Street Address".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.addressController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              onChanged: (v) {
                viewModel.checkvalidate();
              },
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
          // SizedBox(
          //   width: Get.context!.isTablet && Get.context!.isLandscape
          //       ? Get.width / 3
          //       : double.infinity,
          //   child: CustomTextField2(
          //     hint: 'Street Address',
          //     title: "Street Address",
          //     asterisk: true,
          //     fillColor: ThemeColors.white,
          //     controller: viewModel.addressController,
          //     autoValidateMode: AutovalidateMode.onUserInteraction,
          //     keyboardType: TextInputType.text,
          //     validator: (value) {
          //       return CommonFunctions.validateDefaultTxtField(value);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget cityStateAndZipCodeTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 110
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
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField2(
                    hint: 'City'.tr,
                    title: "City".tr,
                    asterisk: true,
                    fillColor: ThemeColors.white,
                    controller: viewModel.cityController,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    onChanged: (v) {
                      viewModel.checkvalidate();
                    },
                    validator: (value) {
                      return CommonFunctions.validateDefaultTxtField(value);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomTextField2(
                    hint: 'State'.tr,
                    title: "State".tr,
                    asterisk: true,
                    fillColor: ThemeColors.white,
                    controller: viewModel.stateController,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    onChanged: (v) {
                      viewModel.checkvalidate();
                    },
                    validator: (value) {
                      return CommonFunctions.validateDefaultTxtField(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3
                : double.infinity,
            child: CustomTextField2(
              hint: 'Zip Code'.tr,
              title: "Zip Code".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.zipCodeController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              // keyboardType: TextInputType.number,
              onChanged: (v) {
                viewModel.checkvalidate();
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
              ? 110
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.chkvalidate.value == true
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
              if (GlobalVariables.datamodel.addresslocalRequired!) {
                if (viewModel.formkey.currentState!.validate()) {
                  GlobalVariables.includeshortanswer
                      ? Get.to(() => SingleLineQuestionView())
                      : GlobalVariables.includeradiobutton
                          ? Get.to(() => SingleChoiceRadioBtnView())
                          : GlobalVariables.includecheckbox
                              ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                              : GlobalVariables.includeparagraph
                                  ? Get.to(() => ParagraphQuestionView())
                                  : Navigation.checknavigation();
                }
              } else {
                GlobalVariables.includeshortanswer
                    ? Get.to(() => SingleLineQuestionView())
                    : GlobalVariables.includeradiobutton
                        ? Get.to(() => SingleChoiceRadioBtnView())
                        : GlobalVariables.includecheckbox
                            ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                            : GlobalVariables.includeparagraph
                                ? Get.to(() => ParagraphQuestionView())
                                : Navigation.checknavigation();
              }
            },
          )),
    );
  }
}
