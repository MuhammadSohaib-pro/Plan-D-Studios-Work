import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../helper/check_navigation.dart';
import '../../../helper/constants.dart';
import '../../../helper/get_state.dart';
import '../../../libraries.dart';

import '../../../widgets/custom_dropdown.dart';

class MinorParentView extends StatelessWidget {
  MinorParentView({super.key});

  final MinorParentViewModel viewModel = Get.put(MinorParentViewModel());
  XFile? image;

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
            child: Column(
              crossAxisAlignment:
                  Get.context!.isTablet && Get.context!.isLandscape
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.zero,
                  child: Form(
                    key: viewModel.FnameandLnamekey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        biologicalTxt(),
                        SizedBox(height: 30),
                        fNameAndLnameTxtField(),
                        SizedBox(height: 20),
                        genderAndBirthDateTxtField(),
                        SizedBox(height: 20),
                        legalGuardianCheckBox(),
                        SizedBox(height: 10),
                        checkboxerror(),
                        SizedBox(height: 20),
                        countrystreetaddressField(),
                        // SizedBox(height: 10),
                        // cscpickererror(),
                        SizedBox(height: 20),
                        CitystateAndZipCodeTxtField(),
                        SizedBox(height: 20),
                        emailAndPhoneTxtField(),
                        SizedBox(height: 20),
                        messageCheckBox(),
                        SizedBox(height: 20),
                        subscribrEmailCheckBox(),
                        SizedBox(height: 10),
                        twocheckboxerror(),
                        SizedBox(height: 20),
                        nextBtn(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
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
            if (viewModel.FnameandLnamekey.currentState!.validate()) {
              if (viewModel.confirmGuardianCheckBox.value &&
                  viewModel.receivesEmailsCheckBox.value &&
                  viewModel.receivesTextMessageCheckBox.value) {
                imagecapture();
                ConfirmationDialog();
              }
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.isFormValid.value &&
                          viewModel.confirmGuardianCheckBox.value &&
                          viewModel.receivesTextMessageCheckBox.value &&
                          viewModel.receivesEmailsCheckBox.value
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

  Widget biologicalTxt() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 6.5),
      child: Text(
        "Biological Parent or Legal Guardian".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget fNameAndLnameTxtField() {
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
              onChanged: (v) {
                viewModel.validateForm();
              },
              hint: 'First Name'.tr,
              title: "First Name".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.fNameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
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
              controller: viewModel.lNameController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.name,
              onChanged: (v) {
                viewModel.validateForm();
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

  Widget genderAndBirthDateTxtField() {
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
                controller: viewModel.genderController,
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
                  await genderModelSheet();
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
                controller: viewModel.dateController,
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
                    viewModel.birthdate = dateTime.toIso8601String();
                    var dt = DateFormat.yMd().format(dateTime);
                    viewModel.dateController.text = dt;
                    viewModel.validateForm();
                  }
                },
              ))
        ]));
  }

  Future<dynamic> genderModelSheet() {
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
                    initialItem: viewModel.genderIndex,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    viewModel.genderIndex = index;
                  },
                  children: List.generate(
                    viewModel.genderList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.genderList[index],
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
                  viewModel.genderController.text =
                      viewModel.genderList[viewModel.genderIndex];
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

  Widget legalGuardianCheckBox() {
    return Obx(
      () => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isPortrait
                ? Get.width / 5.5
                : Get.context!.isPhone
                    ? 20
                    : Get.width / 6.5),
        child: SimpleCheckBox2(
          title:
              "I confirm that I am the legal guardian or biological parent. *"
                  .tr,
          onChanged: (value) {
            viewModel.confirmGuardianCheckBox.value = value;
            viewModel.validateForm();
          },
          value: viewModel.confirmGuardianCheckBox.value,
        ),
      ),
    );
  }

  Widget checkboxerror() {
    return Obx(() => viewModel.confirmGuardianCheckBox.value
        ? SizedBox()
        : Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 5.5
                    : Get.context!.isPhone
                        ? 20
                        : Get.width / 6.2),
            child: Text(
              'You must agree before proceeding *'.tr,
              style: TextStyle(color: ThemeColors.errorRedColor),
            )));
  }

  Widget countrystreetaddressField() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 6.2),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3.03
                : Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 3.3
                    : double.infinity,
            child: countryFlagTextField(
              initialValue: viewModel.countryCode.value,
              title: "Country",
              asterisk: true,
              controller: viewModel.countryController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value!);
              },
              onChanged: (val) async {
                viewModel.countryController.text = val.toCountryStringOnly();
                StateGet.fetchData(val.toCountryStringOnly());
                await Future.delayed(Duration(milliseconds: 500));
                viewModel.dropdownValue.value =
                    StateGet.model.value.states![0].stateCode ?? '';
                print(viewModel.dropdownValue.value);
              },
            ),
          ),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 3.03
                : Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 3.3
                    : double.infinity,
            child: CustomTextField2(
              hint: 'Street Address'.tr,
              title: "Street Address".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.addressController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.text,
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget cscpickererror() {
  //   return Obx(
  //       () => viewModel.country.value != '' && viewModel.state.value != ''
  //           ? SizedBox()
  //           : Container(
  //               width: double.infinity,
  //               margin: EdgeInsets.symmetric(
  //                   horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //                       ? Get.width / 5.5
  //                       : Get.context!.isPhone
  //                           ? 30
  //                           : Get.width / 6.1),
  //               child: Text(
  //                 'Above fields are required *'.tr,
  //                 style: TextStyle(color: ThemeColors.errorRedColor),
  //               )));
  // }

  Widget CitystateAndZipCodeTxtField() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 6.2),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 20,
        spacing: 20,
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            runSpacing: 20,
            spacing: 20,
            children: [
              SizedBox(
                  width: Get.context!.isTablet && Get.context!.isLandscape
                      ? Get.width / 4.9
                      : Get.context!.isTablet && Get.context!.isPortrait
                          ? Get.width / 5.8
                          : double.infinity,
                  child: CustomTextField2(
                    hint: 'City',
                    title: "City",
                    asterisk: true,
                    fillColor: ThemeColors.white,
                    controller: viewModel.cityController,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return CommonFunctions.validateDefaultTxtField(value);
                    },
                  )),
              SizedBox(
                  width: Get.context!.isTablet && Get.context!.isLandscape
                      ? Get.width / 9
                      : Get.context!.isTablet && Get.context!.isPortrait
                          ? Get.width / 9.2
                          : double.infinity,
                  child: CustomStatedropdown(
                    val: viewModel.dropdownValue,
                    onchange: (String? value) {
                      viewModel.dropdownValue.value = value!;
                    },
                  ))
              // SizedBox(
              //     width: Get.context!.isTablet && Get.context!.isLandscape
              //         ? Get.width / 9
              //         : Get.context!.isTablet && Get.context!.isPortrait
              //             ? Get.width / 9.2
              //             : double.infinity,
              //     child: CustomTextField2(
              //       onTap: () {},
              //       hint: 'State',
              //       title: "State",
              //       asterisk: true,
              //       fillColor: ThemeColors.white,
              //       controller: viewModel.stateController,
              //       autoValidateMode: AutovalidateMode.onUserInteraction,
              //       keyboardType: TextInputType.text,
              //       validator: (value) {
              //         return CommonFunctions.validateDefaultTxtField(value);
              //       },
              //     )),
            ],
          ),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 6
                : Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 6.1
                    : double.infinity,
            child: CustomTextField2(
              hint: 'Zip Code'.tr,
              title: "Zip Code".tr,
              inputformatters: [
                LengthLimitingTextInputFormatter(9),
              ],
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.zipCodeController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.streetAddress,
              validator: (value) {
                return CommonFunctions.validateState(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget countryAndStreetAddressTxtField() {
  //   return Container(
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //     margin: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //             ? Get.width / 5.5
  //             : Get.context!.isPhone
  //                 ? 20
  //                 : 0),
  //     child: Wrap(
  //       runSpacing: 20,
  //       spacing: 20,
  //       children: [
  //         SizedBox(
  //           width: Get.context!.isTablet && Get.context!.isLandscape
  //               ? Get.width / 3
  //               : double.infinity,
  //           child: countryFlagTextField(
  //             initialValue: "United States".tr,
  //             title: "Country".tr,
  //             asterisk: true,
  //             controller: viewModel.countryController,
  //             autoValidateMode: AutovalidateMode.onUserInteraction,
  //             validator: (value) {
  //               return CommonFunctions.validateDefaultTxtField(value!);
  //             },
  //             onChanged: (val) {
  //               viewModel.countryController.text = val.toCountryStringOnly();
  //             },
  //           ),
  //         ),
  //         SizedBox(
  //           width: Get.context!.isTablet && Get.context!.isLandscape
  //               ? Get.width / 3
  //               : double.infinity,
  //           child: CustomTextField2(
  //             hint: 'Street Address'.tr,
  //             title: "Street Address".tr,
  //             asterisk: true,
  //             fillColor: ThemeColors.white,
  //             controller: viewModel.addressController,
  //             autoValidateMode: AutovalidateMode.onUserInteraction,
  //             keyboardType: TextInputType.text,
  //             onChanged: (v) {
  //               viewModel.validateForm();
  //             },
  //             validator: (value) {
  //               return CommonFunctions.validateDefaultTxtField(value);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget cityStateAndZipCodeTxtField() {
  //   return Container(
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //     margin: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //             ? Get.width / 5.5
  //             : Get.context!.isPhone
  //                 ? 20
  //                 : 0),
  //     child: Wrap(
  //       runSpacing: 20,
  //       spacing: 20,
  //       children: [
  //         SizedBox(
  //           width: Get.context!.isTablet && Get.context!.isLandscape
  //               ? Get.width / 3
  //               : double.infinity,
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: CustomTextField2(
  //                   hint: 'City'.tr,
  //                   title: "City".tr,
  //                   asterisk: true,
  //                   fillColor: ThemeColors.white,
  //                   controller: viewModel.cityController,
  //                   autoValidateMode: AutovalidateMode.onUserInteraction,
  //                   keyboardType: TextInputType.text,
  //                   onChanged: (v) {
  //                     viewModel.validateForm();
  //                   },
  //                   validator: (value) {
  //                     return CommonFunctions.validateDefaultTxtField(value);
  //                   },
  //                 ),
  //               ),
  //               SizedBox(width: 20),
  //               Expanded(
  //                 child: CustomTextField2(
  //                   hint: 'State'.tr,
  //                   title: "State".tr,
  //                   asterisk: true,
  //                   fillColor: ThemeColors.white,
  //                   controller: viewModel.stateController,
  //                   autoValidateMode: AutovalidateMode.onUserInteraction,
  //                   keyboardType: TextInputType.text,
  //                   onChanged: (v) {
  //                     viewModel.validateForm();
  //                   },
  //                   validator: (value) {
  //                     return CommonFunctions.validateDefaultTxtField(value);
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           width: Get.context!.isTablet && Get.context!.isLandscape
  //               ? Get.width / 3
  //               : double.infinity,
  //           child: CustomTextField2(
  //             maxlength: 9,
  //             hint: 'Zip Code'.tr,
  //             title: "Zip Code".tr,
  //             asterisk: true,
  //             fillColor: ThemeColors.white,
  //             controller: viewModel.zipCodeController,
  //             autoValidateMode: AutovalidateMode.onUserInteraction,
  //             keyboardType: TextInputType.name,
  //             onChanged: (v) {
  //               viewModel.validateForm();
  //             },
  //             validator: (value) {
  //               return CommonFunctions.validateDefaultTxtField(value);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget emailAndPhoneTxtField() {
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
              hint: 'Email'.tr,
              title: "Email".tr,
              asterisk: true,
              fillColor: ThemeColors.white,
              controller: viewModel.emailController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) {
                viewModel.validateForm();
              },
              validator: (value) {
                return CommonFunctions.validateEmail(value);
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
              onChanged: (value) {
                viewModel.countryCode.value = value.toString();
                viewModel.validateForm();
              },
              title: "Phone".tr,
              asterisk: true,
              showCursor: true,
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget messageCheckBox() {
    return Obx(
      () => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isPortrait
                ? Get.width / 5.5
                : Get.context!.isPhone
                    ? 20
                    : Get.width / 6.5),
        child: SimpleCheckBox2(
          title: "I consent to receive text messages from ".tr +
              GlobalVariables.organization.title! +
              " containing updates, offers, and valuable information. You can type STOP at anytime to be opted out of text messages."
                  .tr,
          onChanged: (value) {
            viewModel.receivesTextMessageCheckBox.value = value;
            viewModel.validateForm();
          },
          value: viewModel.receivesTextMessageCheckBox.value,
        ),
      ),
    );
  }

  Widget subscribrEmailCheckBox() {
    return Obx(
      () => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isPortrait
                ? Get.width / 5.5
                : Get.context!.isPhone
                    ? 20
                    : Get.width / 6.5),
        child: SimpleCheckBox2(
          title: "I consent to receive periodic emails from ".tr +
              GlobalVariables.organization.title! +
              ", and you can unsubscribe at any time by clicking the *UNSUBSCRIBE* link provided in our emails."
                  .tr,
          onChanged: (value) {
            viewModel.validateForm();

            viewModel.receivesEmailsCheckBox.value = value;
          },
          value: viewModel.receivesEmailsCheckBox.value,
        ),
      ),
    );
  }

  Widget twocheckboxerror() {
    return Obx(() => viewModel.receivesEmailsCheckBox.value &&
            viewModel.receivesTextMessageCheckBox.value
        ? SizedBox()
        : Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
                horizontal: Get.context!.isTablet && Get.context!.isPortrait
                    ? Get.width / 5.5
                    : Get.context!.isPhone
                        ? 20
                        : Get.width / 6.2),
            child: Text(
              'You must agree before proceeding *'.tr,
              style: TextStyle(color: ThemeColors.errorRedColor),
            )));
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
            backgroundColor: viewModel.isFormValid.value &&
                    viewModel.confirmGuardianCheckBox.value &&
                    viewModel.receivesTextMessageCheckBox.value &&
                    viewModel.receivesEmailsCheckBox.value
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
              if (viewModel.FnameandLnamekey.currentState!.validate()) {
                if (viewModel.confirmGuardianCheckBox.value &&
                    viewModel.receivesEmailsCheckBox.value &&
                    viewModel.receivesTextMessageCheckBox.value) {
                  imagecapture();
                  ConfirmationDialog();
                }
              }
            },
          )),
    );
  }

  Future<dynamic> ConfirmationDialog() {
    return showDialog(
        context: Get.context!,
        builder: (context) {
          return Dialog(
            alignment: Alignment.center,
            shape: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 300,
              width: 315,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: 10,
                    width: double.infinity,
                    color: ThemeColors.redColor,
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.lock,
                            color: ThemeColors.white,
                            size: 30,
                          ),
                          radius: 30,
                          backgroundColor: ThemeColors.redColor,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                            child: RichText(
                          text: TextSpan(
                              text: 'Verification Required:\n'.tr,
                              style: TextStyle(
                                fontSize: 20,
                                color: ThemeColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      "Confirm the Accuracy of Your Information"
                                          .tr,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: ThemeColors.primaryColor,
                                  ),
                                ),
                              ]),
                          maxLines: 4,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      "Before you proceed, we kindly ask you ensure that the information matches the details on your goverment-issued ID."
                          .tr,
                      maxLines: 6,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomElevatedBtn(
                          height: 45,
                          width: 100,
                          backgroundColor: Colors.grey.shade300,
                          child: Text(
                            "Back".tr,
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        CustomElevatedBtn(
                          height: 45,
                          width: 100,
                          backgroundColor: ThemeColors.redColor,
                          child: Text(
                            "Confirm".tr,
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            viewModel.storewaivermodel();
                            GlobalVariables.datamodel.includeEmergencyContact!
                                ? Get.to(() => EmergencyContactView())
                                : GlobalVariables.datamodel.includeLocalAddress!
                                    ? Get.to(() => LocalAddressView())
                                    : GlobalVariables.includeshortanswer
                                        ? Get.to(() => SingleLineQuestionView())
                                        : GlobalVariables.includeradiobutton
                                            ? Get.to(() =>
                                                SingleChoiceRadioBtnView())
                                            : GlobalVariables.includecheckbox
                                                ? Get.to(() =>
                                                    MultipleChoiceCheckBoxBtnView())
                                                : GlobalVariables
                                                        .includeparagraph
                                                    ? Get.to(() =>
                                                        ParagraphQuestionView())
                                                    : Navigation
                                                        .checknavigation();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  imagecapture() async {
    if (viewModel.photocontroller.value.isInitialized) {
      await viewModel.initCamera();
    }
    if (viewModel.photocontroller.value.isTakingPicture) {
      return null;
    }
    try {
      await viewModel.photocontroller.setFlashMode(FlashMode.off);
      image = await viewModel.photocontroller.takePicture();
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }

    print(Image.file(File(image!.path)));
  }
}
