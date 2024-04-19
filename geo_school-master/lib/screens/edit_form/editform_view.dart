import 'package:flutter/material.dart';
import 'package:geo_school/helper/CommonFunctions.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/custom_buttons.dart';
import 'package:geo_school/widgets/custom_dropdowns.dart';
import 'package:geo_school/screens/edit_form/editform_viewmodel.dart';
import 'package:geo_school/widgets/custom_radioButton.dart';
import 'package:geo_school/widgets/custom_textfields.dart';
import 'package:get/get.dart';

class EditFormView extends StatelessWidget {
  final editFormViewModel = Get.put(EditFormViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: editFormViewModel.scrollController,
            child: Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(Get.width * 0.05, 0,
                        Get.width * 0.05, Get.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: editFormViewModel.formKey,
                          child: Column(
                            children: [
                              schoolNameTextField(),
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
                    //    addImageButton(context),
                      ],
                    ),
                  ),
              //    imageListView(),
                  submitButton(),
                ],
              ),
            ),
          ),
          Loader()
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text('editSchool'.tr),
    );
  }

  Widget schoolNameTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        readOnly: true,
        showCursor: false,
        title: 'schoolName'.tr,
        hintText: 'schoolName'.tr,
        controller: editFormViewModel.schoolNameController,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   return editFormViewModel.validateField(value);
        // },
      ),
    );
  }

  Widget regionTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        readOnly: true,
        showCursor: false,
        hintText: 'region'.tr,
        title: 'region'.tr,
        controller: editFormViewModel.regionController,
      ),
    );
  }

  Widget townTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        readOnly: true,
        showCursor: false,
        hintText: 'town'.tr,
        title: 'town'.tr,
        controller: editFormViewModel.townController,
      ),
    );
  }

  Widget departmentTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        readOnly: true,
        showCursor: false,
        hintText: 'department'.tr,
        title: 'department'.tr,
        controller: editFormViewModel.departmentController,
      ),
    );
  }

  Widget latitudeTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CustomTextField13(
        hintText: 'latitude'.tr,
        title: 'latitude'.tr,
        readOnly: true,
        showCursor: false,
        controller: editFormViewModel.latitudeController,
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
        hintText: 'longitude'.tr,
        title: 'longitude'.tr,
        readOnly: true,
        showCursor: false,
        controller: editFormViewModel.longitudeController,
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
        controller: editFormViewModel.connectionSpeedController,
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
        controller: editFormViewModel.totalStudentsController,
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
        controller: editFormViewModel.girlsController,
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
        controller: editFormViewModel.boysController,
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
        controller: editFormViewModel.teachingStaffController,
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
        controller: editFormViewModel.phoneNumberController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTextField(value);
        },
      ),
    );
  }

  Widget buildingMaterialDropDown(BuildContext context) {
    return Obx(
      () => CustomDropDownList1(
        focusNode: editFormViewModel.dropDownFocus,
        title: 'constructionMaterial'.tr,
        value: editFormViewModel.buildingMaterial.value,
        onChanged: (value) {
          FocusScope.of(context).requestFocus(new FocusNode());
          editFormViewModel.buildingMaterial.value = value;
        },
        list: editFormViewModel.buildingMaterialList,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultDropDown(value);
        },
      ),
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
                  groupValue: editFormViewModel.electricityCbValue.value,
                  onChanged: (value) {
                    editFormViewModel.electricityCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.electricityCbValue.value,
                    onChanged: (value) {
                      editFormViewModel.electricityCbValue.value = value;
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
                  groupValue: editFormViewModel.waterCbValue.value,
                  onChanged: (value) {
                    editFormViewModel.waterCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.waterCbValue.value,
                    onChanged: (value) {
                      editFormViewModel.waterCbValue.value = value;
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
                  groupValue: editFormViewModel.internetCbValue.value,
                  onChanged: (value) {
                    editFormViewModel.internetCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.internetCbValue.value,
                    onChanged: (value) {
                      editFormViewModel.internetCbValue.value = value;
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
                  groupValue: editFormViewModel.toiletCbValue.value,
                  onChanged: (value) {
                    editFormViewModel.toiletCbValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.toiletCbValue.value,
                    onChanged: (value) {
                      editFormViewModel.toiletCbValue.value = value;
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
                  groupValue: editFormViewModel.mobileNetworkValue.value,
                  onChanged: (value) {
                    editFormViewModel.mobileNetworkValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.mobileNetworkValue.value,
                    onChanged: (value) {
                      editFormViewModel.mobileNetworkValue.value = value;
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
                  groupValue: editFormViewModel.fencingValue.value,
                  onChanged: (value) {
                    editFormViewModel.fencingValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.fencingValue.value,
                    onChanged: (value) {
                      editFormViewModel.fencingValue.value = value;
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
                  groupValue: editFormViewModel.libraryValue.value,
                  onChanged: (value) {
                    editFormViewModel.libraryValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.libraryValue.value,
                    onChanged: (value) {
                      editFormViewModel.libraryValue.value = value;
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
                  groupValue: editFormViewModel.computerRoomValue.value,
                  onChanged: (value) {
                    editFormViewModel.computerRoomValue.value = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  child: CustomRadioButton1(
                    title: 'no'.tr,
                    value: 'No',
                    groupValue: editFormViewModel.computerRoomValue.value,
                    onChanged: (value) {
                      editFormViewModel.computerRoomValue.value = value;
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
    return CustomTextField13(
      title: 'description'.tr,
      hintText: 'description'.tr,
      controller: editFormViewModel.descriptionController,
      minLines: 5,
      maxLines: null,
    );
  }

  Widget submitButton() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      width: Get.width * 0.8,
      height: 55,
      child: CustomButton8(
        onPressed: () {
          editFormViewModel.updateOfflineData();
        },
        backgroundColor: Color(0xffFE9900),
        text: 'submit'.tr,
      ),
    );
  }
}
