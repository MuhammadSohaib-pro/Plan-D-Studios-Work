import 'package:flutter/material.dart';
import 'package:geo_school/helper/CommonFunctions.dart';
import 'package:geo_school/screens/form/form_viewmodel.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/custom_buttons.dart';
import 'package:geo_school/widgets/custom_dropdowns.dart';
import 'package:geo_school/widgets/custom_radioButton.dart';
import 'package:geo_school/widgets/custom_textfields.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormView extends StatelessWidget {
  late LatLng latLng;
  late FormViewModel formViewModel;
  late double altitude;
  late String accuracy;

  FormView({required this.latLng, required this.altitude, required this.accuracy}) {
    formViewModel = Get.put(
      FormViewModel(latLng: latLng, altitude: altitude, accuracy: accuracy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: formViewModel.scrollController,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Get.width * 0.05, 0, Get.width * 0.05, Get.width * 0.03),
                  child: Column(
                    children: [
                      Form(
                        key: formViewModel.formKey,
                        child: Column(
                          children: [
                            schoolNameTextField(),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    regionTextField(),
                                    townTextField(),
                                    departmentTextField(),
                                    latitudeTextField(),
                                    longitudeTextField(),
                                    // connectionSpeedTextField(),
                                    // totalStudentsTextField(),
                                    // girlsTextField(),
                                    // boysTextField(),
                                    // teachingStaffTextField(),
                                    // phoneNumberTextField(),
                                    buildingMaterialDropDown(context)
                                  ],
                                ),
                                schoolList(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      electricityRadioButtons(),
                      waterRadioButtons(),
                      internetRadioButtons(),
                      toiletRadioButtons(),
                      // mobileNetworkButtons(),
                      // fencingButtons(),
                      // libraryButtons(),
                      // computerRoomButtons(),
                      descriptionTextField(),
                      //  addImageButton(context),
                    ],
                  ),
                ),
                //  imageListView(),
                submitButton(),
              ],
            ),
          ),
          Loader()
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text('fillForm'.tr),
    );
  }

  Widget schoolNameTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'schoolName'.tr,
        maxLines: 1,
        hintText: 'schoolName'.tr,
        onChanged: (value) {
          formViewModel.getSchoolSuggestions(value);
        },
        controller: formViewModel.schoolNameController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget schoolList() {
    return Obx(
      () => (formViewModel.schoolSuggestion.length > 0)
          ? Container(
              padding: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey.shade100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(0.0, 0.0), //(x,y)
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: formViewModel.schoolSuggestion.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      formViewModel.loadSchoolData(index);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 18),
                          child: Row(
                            children: [
                              Icon(
                                Icons.school,
                                color: Colors.grey,
                                size: 18,
                              ),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(3, 10, 0, 10),
                                  child: Text(
                                    formViewModel
                                            .schoolSuggestion[index].name?? '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 0, height: 0)
                      ],
                    ),
                  );
                },
              ),
            )
          : Container(height: 0),
    );
  }

  Widget regionTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'region'.tr,
        hintText: 'region'.tr,
        readOnly: true,
        showCursor: false,
        controller: formViewModel.regionController,
      ),
    );
  }

  Widget townTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'town'.tr,
        hintText: 'town'.tr,
        readOnly: true,
        showCursor: false,
        controller: formViewModel.townController,
      ),
    );
  }

  Widget departmentTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'department'.tr,
        hintText: 'department'.tr,
        readOnly: true,
        showCursor: false,
        controller: formViewModel.departmentController,
      ),
    );
  }

  Widget latitudeTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'latitude'.tr,
        hintText: 'latitude'.tr,
        readOnly: true,
        showCursor: false,
        controller: formViewModel.latitudeController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget longitudeTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'longitude'.tr,
        hintText: 'longitude'.tr,
        readOnly: true,
        showCursor: false,
        controller: formViewModel.longitudeController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget connectionSpeedTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'connectionSpeed'.tr,
        hintText: 'connectionSpeed'.tr,
        controller: formViewModel.connectionSpeedController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget totalStudentsTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'totalStudents'.tr,
        hintText: 'totalStudents'.tr,
        controller: formViewModel.totalStudentsController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget girlsTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'girls'.tr,
        hintText: 'girls'.tr,
        controller: formViewModel.girlsController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget boysTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'boys'.tr,
        hintText: 'boys'.tr,
        controller: formViewModel.boysController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget teachingStaffTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'teachingStaff'.tr,
        hintText: 'teachingStaff'.tr,
        controller: formViewModel.teachingStaffController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget phoneNumberTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        title: 'phoneNumber'.tr,
        hintText: 'phoneNumber'.tr,
        controller: formViewModel.phoneNumberController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget buildingMaterialDropDown(BuildContext context) {
    return CustomDropDownList1(
      focusNode: formViewModel.dropDownFocus,
      title: 'constructionMaterial'.tr,
      value: formViewModel.buildingMaterial.value,
      onChanged: (value) {
        formViewModel.buildingMaterial.value = value;
      },
      list: formViewModel.buildingMaterialList,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return CommonFunctions.validateDefaultDropDown(value);
      },
    );
  }

  Widget electricityRadioButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'electricity'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.electricityCbValue.value,
                  onChanged: (value) {
                    formViewModel.electricityCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.electricityCbValue.value,
                    onChanged: (value) {
                      formViewModel.electricityCbValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget waterRadioButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'water'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.waterCbValue.value,
                  onChanged: (value) {
                    formViewModel.waterCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.waterCbValue.value,
                    onChanged: (value) {
                      formViewModel.waterCbValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget internetRadioButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'internet'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.internetCbValue.value,
                  onChanged: (value) {
                    formViewModel.internetCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.internetCbValue.value,
                    onChanged: (value) {
                      formViewModel.internetCbValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget toiletRadioButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'toilet'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.toiletCbValue.value,
                  onChanged: (value) {
                    formViewModel.toiletCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.toiletCbValue.value,
                    onChanged: (value) {
                      formViewModel.toiletCbValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileNetworkButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'mobileNetwork'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.mobileNetworkValue.value,
                  onChanged: (value) {
                    formViewModel.mobileNetworkValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.mobileNetworkValue.value,
                    onChanged: (value) {
                      formViewModel.mobileNetworkValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fencingButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'fencing'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.fencingValue.value,
                  onChanged: (value) {
                    formViewModel.fencingValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.fencingValue.value,
                    onChanged: (value) {
                      formViewModel.fencingValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget libraryButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'library'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.libraryValue.value,
                  onChanged: (value) {
                    formViewModel.libraryValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.libraryValue.value,
                    onChanged: (value) {
                      formViewModel.libraryValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget computerRoomButtons() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'computerRoom'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins-Regularr',
                color: Color(0xff999999),
              ),
            ),
            Row(
              children: [
                CustomRadioButton1(
                  title: 'yes'.tr,
                  value: 'Yes',
                  groupValue: formViewModel.computerRoomValue.value,
                  onChanged: (value) {
                    formViewModel.computerRoomValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: formViewModel.computerRoomValue.value,
                    onChanged: (value) {
                      formViewModel.computerRoomValue.value = value;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget descriptionTextField() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: CustomTextField13(
        title: 'description'.tr,
        hintText: 'description'.tr,
        controller: formViewModel.descriptionController,
        minLines: 5,
        maxLines: null,
      ),
    );
  }

  Widget submitButton() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 20),
      width: Get.width * 0.8,
      height: 55,
      child: CustomButton8(
        onPressed: () {
          formViewModel.updateOfflineData();
        },
        backgroundColor: Color(0xffFE9900),
        text: 'submit'.tr,
      ),
    );
  }
}
