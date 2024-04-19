import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kiosk/helper/constants.dart';
import 'package:kiosk/helper/get_state.dart';

import '../../../helper/check_navigation.dart';
import '../../../libraries.dart';
import '../../../widgets/custom_dropdown.dart';

class AdultParticipantView extends StatefulWidget {
  AdultParticipantView({super.key});

  @override
  State<AdultParticipantView> createState() => _AdultParticipantViewState();
}

class _AdultParticipantViewState extends State<AdultParticipantView> {
  final AdultParticipantViewModel viewModel =
      Get.put(AdultParticipantViewModel());

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                AdultParticipantTxt(),
                SizedBox(height: 30),
                fNameLnameGenderandBirthTxtField(),
                // SizedBox(height: 20),
                // genderAndBirthDateTxtField(),
                SizedBox(height: 20),
                ImageTxtField(),
                SizedBox(height: 20),
                emailAndPhoneTxtField(),
                SizedBox(height: 20),
                if (GlobalVariables.datamodel.includeAddress!) ...[
                  contactInformationTxt(),
                  SizedBox(height: 20),
                  countrystreetaddressField(),
                  SizedBox(height: 10),
                  // GlobalVariables.datamodel.addressRequired!
                  //     ? cscpickererror()
                  //     : SizedBox(),
                  SizedBox(height: 20),
                  CitystateAndZipCodeTxtField(),
                  SizedBox(height: 20),
                ],
                if (GlobalVariables.datamodel.includeIdentification!) ...[
                  identificationTxt(),
                  SizedBox(height: 20),
                  identificationTypeAndCountryTxtField(),
                  SizedBox(height: 20),
                  // idStateAndIdNumberTxtField(),
                  // SizedBox(height: 20),
                ],
                messageCheckBox(),
                SizedBox(height: 20),
                subscribrEmailCheckBox(),
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
            imagecapture();
            viewModel.firstlastnameformkey.currentState!.validate() &&
                    viewModel.emailformkey.currentState!.validate()
                ?
                //if address & identification is not required then navigate to screen
                GlobalVariables.datamodel.addressRequired! == false &&
                        GlobalVariables.datamodel.identificationRequired! ==
                            false
                    ? ConfirmationDialog()
                    :

                    //if address is required then validate else null
                    GlobalVariables.datamodel.addressRequired!
                        ? viewModel.addressformkey.currentState!.validate()
                            ?
                            // if identification is required then validate
                            GlobalVariables.datamodel.identificationRequired!
                                ? viewModel.identificationformkey.currentState!
                                        .validate()
                                    ?
                                    // if validate true then navigate else null
                                    ConfirmationDialog()
                                    :
                                    //address null
                                    null
                                :
                                // if identification is not required then navigate

                                ConfirmationDialog()
                            :
                            //address null
                            null
                        :
                        // if address is not required then navigate
                        ConfirmationDialog()
                : null;
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: btncolor()
                    // viewModel.isFormValid.value
                    //     ? GlobalVariables.datamodel.addressRequired! == false &&
                    //             GlobalVariables
                    //                     .datamodel.identificationRequired! ==
                    //                 false
                    //         ? ThemeColors.fullLightPrimary
                    //         : GlobalVariables.datamodel.addressRequired!
                    //             ? viewModel.isaddressFormValid.value &&
                    //                     viewModel.country.value != "" &&
                    //                     viewModel.state.value != ""
                    //                 ? GlobalVariables
                    //                         .datamodel.identificationRequired!
                    //                     ? viewModel
                    //                             .isidentificationFormValid.value
                    //                         ? ThemeColors.fullLightPrimary
                    //                         : ThemeColors.grey2
                    //                     :
                    //                     // if identification is not required then navigate

                    //                     ThemeColors.fullLightPrimary
                    //                 :
                    //                 //address null
                    //                 ThemeColors.grey2
                    //             :
                    //             // if address is not required then navigate
                    //             ThemeColors.fullLightPrimary
                    //     : ThemeColors.grey2
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

  Widget AdultParticipantTxt() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 7),
      child: Text(
        "Adult Participant".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget fNameLnameGenderandBirthTxtField() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : 0),
      child: Form(
        key: viewModel.firstlastnameformkey,
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          children: [
            SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: CustomTextField2(
                hint: 'First Name'.tr,
                title: "First Name".tr,
                asterisk: true,
                fillColor: ThemeColors.white,
                controller: viewModel.fNameController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  viewModel.validateForm();
                },
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              ),
            ),
            SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: CustomTextField2(
                hint: 'Last Name'.tr,
                title: "Last Name".tr,
                asterisk: true,
                fillColor: ThemeColors.white,
                controller: viewModel.lNameController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  viewModel.validateForm();
                },
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              ),
            ),
            // SizedBox(
            //   width: Get.context!.isTablet && Get.context!.isLandscape
            //       ? Get.width / 1.4
            //       : double.infinity,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: CustomTextField2(
            //           controller: viewModel.genderController,
            //           onChanged: (value) {
            //             viewModel.validateForm();
            //           },
            //           title: "Gender".tr,
            //           asterisk: true,
            //           hint: "Select Gender".tr,
            //           // textColor: ThemeColors.primaryColor,
            //           fillColor: ThemeColors.grey2.withOpacity(.1),
            //           suffixIcon: const Icon(
            //             Icons.arrow_drop_down,
            //             color: const Color(0xff828A89),
            //           ),
            //           readOnly: true,
            //           onTap: () async {
            //             await genderModelSheet();
            //           },
            //           validator: (value) {
            //             print(value);
            //             return CommonFunctions.validateDefaultTxtField(value);
            //           },
            //         ),
            //       ),
            //       SizedBox(width: 20),
            //       Expanded(
            //         child: CustomTextField2(
            //           fillColor: ThemeColors.white,
            //           // textColor: ThemeColors.primaryColor,
            //           controller: viewModel.dateController,
            //           // showCursor: false,
            //           hint: "MM/DD/YYYY".tr,
            //           title: "Birthday".tr,
            //           asterisk: true,
            //           suffixIcon: Icon(Icons.arrow_drop_down),
            //           autoValidateMode: AutovalidateMode.onUserInteraction,
            //           readOnly: true,
            //           onChanged: (value) {
            //             // viewModel.validateForm();
            //           },
            //           validator: (value) {
            //             return CommonFunctions.validateDefaultTxtField(value);
            //           },
            //           onTap: () async {
            //             DateTime? dateTime = await showDatePicker(
            //               context: Get.context!,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(1900),
            //               lastDate: DateTime(3000),
            //             );
            //             if (dateTime != null) {
            //               viewModel.birthdate = dateTime.toIso8601String();
            //               var dt = DateFormat.yMd().format(dateTime);
            //               viewModel.dateController.text = dt;
            //               viewModel.validateForm();
            //             }
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Wrap(runSpacing: 20, spacing: 20, children: [
              SizedBox(
                  width: Get.context!.isTablet && Get.context!.isLandscape
                      ? Get.width / 2.85
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
                      ? Get.width / 2.85
                      : Get.context!.isTablet && Get.context!.isPortrait
                          ? Get.width / 3.3
                          : Get.context!.isPhone && Get.context!.isPortrait
                              ? Get.width / 2.4
                              : Get.width / 2.43,
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
            ])
          ],
        ),
      ),
    );
  }

  Widget ImageTxtField() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.context!.isTablet && Get.context!.isLandscape
                      ? Get.width / 7
                      : 0),
      child: Wrap(
        runAlignment: WrapAlignment.start,
        runSpacing: 15,
        spacing: 20,
        children: [
          SizedBox(
            // width: Get.context!.isTablet && Get.context!.isLandscape
            //     ? double.infinity
            //     : double.infinity,
            child: Padding(
              padding: Get.context!.isTablet && Get.context!.isLandscape
                  ? EdgeInsets.only(top: 8.0)
                  : EdgeInsets.all(0),
              child: Row(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: ThemeColors.grey2,
                    dashPattern: [4, 2],
                    strokeWidth: 3,
                    radius: Radius.circular(10),
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: ThemeColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Obx(() {
                        final image = viewModel.selectedImage.value;
                        if (image != null) {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(image: image));
                        } else {
                          return SizedBox();
                        }
                      }),
                    ),
                  ),
                  SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: 10),
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          "Profile Picture (optional but prefered)".tr,
                          style: TextStyle(
                            fontSize: 10,
                            color: ThemeColors.grey2,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      CustomElevatedBtn(
                        height: 42,
                        width: 120,
                        backgroundColor: ThemeColors.fullLightPrimary,
                        child: Text(
                          "Upload".tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: ThemeColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          imagepickerbottomsheet();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget imagefield(){}
  Future<dynamic> imagepickerbottomsheet() {
    return showModalBottomSheet(
        context: Get.context!,
        shape: UnderlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      pickimagecamera();
                    },
                    child: gallerycameracontainer(Icons.camera, 'Camera'.tr)),
                GestureDetector(
                    onTap: () {
                      pickimagegallery();
                    },
                    child: gallerycameracontainer(Icons.image, 'Gallery'.tr))
              ],
            ),
          );
        });
  }

  Future<void> pickimagegallery() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      viewModel.selectedImage.value = FileImage(File(img.path));
      Get.back();
    }
  }

  Future<void> pickimagecamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      viewModel.selectedImage.value = FileImage(File(pickedFile.path));
      Get.back();
    }
  }

  Widget gallerycameracontainer(icon, text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            decoration: BoxDecoration(
                color: ThemeColors.grey2,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                )),
            child: Padding(
              padding: const EdgeInsets.all(23),
              child: Icon(
                icon,
                size: 35,
              ),
            ),
          ),
        ),
        Text(text)
      ],
    );
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
          Form(
            key: viewModel.emailformkey,
            child: SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: CustomTextField2(
                hint: 'Email'.tr,
                title: "Email".tr,
                asterisk: true,
                fillColor: ThemeColors.white,
                controller: viewModel.emailController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                onChanged: (_) {
                  viewModel.validateForm();
                },
                validator: (value) {
                  return CommonFunctions.validateEmail(value);
                },
              ),
            ),
          ),
          // SizedBox(
          //     width: Get.context!.isTablet && Get.context!.isLandscape
          //         ? Get.width / 3
          //         : double.infinity,
          //     child: Column(children: [
          // InternationalPhoneNumberInput(
          //   onInputChanged: (PhoneNumber number) {
          //     print(number.phoneNumber);
          //   },
          //   onInputValidated: (bool value) {
          //     print(value);
          //   },
          //   selectorConfig: SelectorConfig(
          //     selectorType: PhoneInputSelectorType.DIALOG,
          //   ),
          //   ignoreBlank: false,
          //   autoValidateMode: AutovalidateMode.disabled,
          //   selectorTextStyle: TextStyle(color: Colors.black),
          //   initialValue: viewModel.number,
          //   textFieldController: viewModel.phoneController,
          //   formatInput: true,
          //   keyboardType: TextInputType.numberWithOptions(
          //       signed: true, decimal: true),
          //   inputBorder: OutlineInputBorder(),
          //   onSaved: (PhoneNumber number) {
          //     print('On Saved: $number');
          //   },
          // ),
          //     ])),
          Form(
            key: viewModel.phoneformkey,
            child: SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: countryFlagNumberTextField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: viewModel.phoneController,
                keyboardType: TextInputType.phone,
                title: "Phone".tr,
                asterisk: true,
                initialvalue: viewModel.number,

                onChanged: (value) {
                  viewModel.phoneformkey.currentState?.validate();
                  if (value) {
                    viewModel.isNumberValid = true;
                  } else {
                    viewModel.isNumberValid = false;
                  }
                  viewModel.validateForm();
                },
                showCursor: true,
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactInformationTxt() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 7),
      child: Text(
        "Contact Information".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
                  : 0),
      child: Wrap(
        runSpacing: 20,
        spacing: 20,
        children: [
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? Get.width / 2.86
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
                viewModel.validateaddressForm();
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
                ? Get.width / 2.86
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
              onChanged: (_) {
                viewModel.validateaddressForm();
              },
              validator: (value) {
                return CommonFunctions.validateDefaultTxtField(value);
              },
            ),
          ),
          //csc picker
          // SizedBox(
          //   width: Get.context!.isTablet && Get.context!.isLandscape
          //       ? Get.width / 1.4
          //       : double.infinity,
          //   child: Row(
          //     children: [
          //       Flexible(
          //         child: CSCPicker(
          //           key: viewModel.cscPickerKey,
          //           showStates: true,
          //           showCities: true,
          //           flagState: CountryFlag.ENABLE,
          //           dropdownDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.all(Radius.circular(10)),
          //               color: ThemeColors.white,
          //               border: Border.all(color: ThemeColors.grey2, width: 1)),
          //           disabledDropdownDecoration: BoxDecoration(
          //               borderRadius: BorderRadius.all(Radius.circular(10)),
          //               color: ThemeColors.grey5,
          //               border: Border.all(color: ThemeColors.grey5, width: 1)),
          //           countrySearchPlaceholder: "Country".tr,
          //           stateSearchPlaceholder: "State".tr,
          //           citySearchPlaceholder: "City".tr,
          //           countryDropdownLabel: "*Country".tr,
          //           stateDropdownLabel: "*State".tr,
          //           cityDropdownLabel: "*City".tr,
          //           defaultCountry: CscCountry.United_States,
          //           disableCountry: false,
          //           selectedItemStyle: TextStyle(
          //             color: Colors.black,
          //             fontSize: 14,
          //           ),
          //           dropdownHeadingStyle: TextStyle(
          //               color: Colors.black,
          //               fontSize: 17,
          //               fontWeight: FontWeight.bold),
          //           dropdownItemStyle: TextStyle(
          //             color: Colors.black,
          //             fontSize: 14,
          //           ),
          //           dropdownDialogRadius: 10.0,
          //           searchBarRadius: 10.0,
          //           onCountryChanged: (value) {
          //             viewModel.country.value = value;
          //           },
          //           onStateChanged: (value) {
          //             viewModel.state.value = value ?? '';
          //           },
          //           onCityChanged: (value) {
          //             viewModel.city.value = value ?? '';
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          //csc picker

          //
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
  //                           : Get.width / 6.5),
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
                  : Get.context!.isTablet && Get.context!.isLandscape
                      ? Get.width / 7
                      : 0),
      child: Form(
        key: viewModel.addressformkey,
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
                        ? Get.width / 4.5
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
                      onChanged: (val) {
                        viewModel.validateaddressForm();
                      },
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
                      onchange: (item) {
                        viewModel.dropdownValue.value = item!;
                      },
                    ))
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
                onChanged: (_) {
                  viewModel.validateaddressForm();
                },
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget identificationTxt() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : Get.width / 7),
      child: Text(
        "Identification".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget identificationTypeAndCountryTxtField() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isPortrait
              ? Get.width / 5.5
              : Get.context!.isPhone
                  ? 20
                  : 0),
      child: Form(
        key: viewModel.identificationformkey,
        child: Wrap(
          runSpacing: 20,
          spacing: 20,
          children: [
            SizedBox(
                width: Get.context!.isTablet && Get.context!.isLandscape
                    ? Get.width / 2.86
                    : double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Identification Type',
                          style: const TextStyle(
                            fontSize: 14,
                            color: ThemeColors.primaryColor,
                          ),
                          children: [
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                              color: ThemeColors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.7, color: ThemeColors.grey1))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              isExpanded: true,
                              value: viewModel.iddropdown.value,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              elevation: 16,
                              onChanged: (String? value) {
                                viewModel.iddropdown.value = value!;
                                viewModel.validateidentificationForm();
                              },
                              items: viewModel.idlist
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ))
                  ],
                )
                // CustomTextField2(
                //   hint: 'Identification Type'.tr,
                //   title: "Identification Type".tr,
                //   asterisk: true,
                //   fillColor: ThemeColors.white,
                //   // readOnly: true,
                //   suffixIcon: Icon(Icons.arrow_drop_down),
                //   controller: viewModel.identificationTypeController,
                //   autoValidateMode: AutovalidateMode.onUserInteraction,
                //   onChanged: (_) {
                //     viewModel.validateidentificationForm();
                //   },
                //   validator: (value) {
                //     return CommonFunctions.validateDefaultTxtField(value);
                //   },
                // ),

                ),
            SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: countryFlagTextField(
                initialValue: "United States".tr,
                title: "Country".tr,
                asterisk: true,
                controller: viewModel.identificationCountryController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value!);
                },
                onChanged: (val) async {
                  viewModel.identificationCountryController.text =
                      val.toCountryStringOnly();
                  StateGet.fetchData(val.toCountryStringOnly());
                  await Future.delayed(Duration(milliseconds: 500));
                  viewModel.idstatedropdown.value =
                      StateGet.model.value.states![0].stateCode ?? '';
                  print(viewModel.dropdownValue.value);
                },
              ),
            ),
            SizedBox(
                height: 80,
                width: Get.context!.isTablet && Get.context!.isLandscape
                    ? Get.width / 2.86
                    : double.infinity,
                child: CustomStatedropdown(
                  val: viewModel.idstatedropdown,
                  onchange: (String? value) {
                    viewModel.idstatedropdown.value = value!;
                  },
                )
                //  CustomTextField13(
                //   controller: viewModel.stateController,
                //   title: "State".tr,
                //   asterisk: true,
                //   hintText: "ID# State".tr,
                //   textColor: ThemeColors.primaryColor,
                //   fillColor: ThemeColors.grey2.withOpacity(.1),
                //   sufixIcon: const Icon(
                //     Icons.arrow_drop_down,
                //     color: const Color(0xff828A89),
                //   ),
                //   readOnly: true,
                //   onTap: () {},
                // ),
                ),
            Container(
              margin: Get.context!.isTablet && Get.context!.isLandscape
                  ? EdgeInsets.only(top: 8)
                  : EdgeInsets.all(0),
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? Get.width / 2.86
                  : double.infinity,
              child: CustomTextField2(
                hint: 'ID Number'.tr,
                title: "ID Number".tr,
                asterisk: true,
                fillColor: ThemeColors.white,
                controller: viewModel.idNumberController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                onChanged: (_) {
                  viewModel.validateidentificationForm();
                },
                validator: (value) {
                  return CommonFunctions.validateDefaultTxtField(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget idStateAndIdNumberTxtField() {
  Widget messageCheckBox() {
    return Obx(
      () => Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
            horizontal: Get.context!.isTablet && Get.context!.isPortrait
                ? Get.width / 5.5
                : Get.context!.isPhone
                    ? 20
                    : Get.width / 7.25),
        child: SimpleCheckBox2(
          title: "I consent to receive text messages from ".tr +
              GlobalVariables.organization.title! +
              " containing updates, offers, and valuable information. You can type STOP at anytime to be opted out of text messages."
                  .tr,
          onChanged: (value) {
            viewModel.receiveTxtMessges.value = value;
          },
          value: viewModel.receiveTxtMessges.value,
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
                    : Get.width / 7.25),
        child: SimpleCheckBox2(
          title: "I consent to receive periodic emails from ".tr +
              GlobalVariables.organization.title! +
              ", and you can unsubscribe at any time by clicking the *UNSUBSCRIBE* link provided in our emails."
                  .tr,
          onChanged: (value) {
            viewModel.receiveEmails.value = value;
          },
          value: viewModel.receiveEmails.value,
        ),
      ),
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 7
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: btncolor(),
            child: Text(
              "Next".tr,
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              imagecapture();
              viewModel.firstlastnameformkey.currentState!.validate() &&
                      viewModel.emailformkey.currentState!.validate()
                  ?
                  //if address & identification is not required then navigate to screen
                  GlobalVariables.datamodel.addressRequired! == false &&
                          GlobalVariables.datamodel.identificationRequired! ==
                              false
                      ? ConfirmationDialog()
                      :

                      //if address is required then validate else null
                      GlobalVariables.datamodel.addressRequired!
                          ? viewModel.addressformkey.currentState!.validate()
                              ?
                              // if identification is required then validate
                              GlobalVariables.datamodel.identificationRequired!
                                  ? viewModel
                                          .identificationformkey.currentState!
                                          .validate()
                                      ?
                                      // if validate true then navigate else null
                                      ConfirmationDialog()
                                      :
                                      //address null
                                      null
                                  :
                                  // if identification is not required then navigate

                                  ConfirmationDialog()
                              :
                              //address null
                              null
                          :
                          // if address is not required then navigate
                          ConfirmationDialog()
                  : null;
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

  Color btncolor() {
    return viewModel.isFormValid.value
        ? GlobalVariables.datamodel.addressRequired! == false &&
                GlobalVariables.datamodel.identificationRequired! == false
            ? ThemeColors.fullLightPrimary
            : GlobalVariables.datamodel.addressRequired!
                ? viewModel.isaddressFormValid.value
                    ? GlobalVariables.datamodel.identificationRequired!
                        ? viewModel.isidentificationFormValid.value
                            ? ThemeColors.fullLightPrimary
                            : ThemeColors.grey2
                        :
                        // if identification is not required then navigate

                        ThemeColors.fullLightPrimary
                    :
                    //address null
                    ThemeColors.grey2
                :
                // if address is not required then navigate
                ThemeColors.fullLightPrimary
        : ThemeColors.grey2;
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
