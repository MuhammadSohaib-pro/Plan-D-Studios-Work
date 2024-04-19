import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/complete_profile/step_2/complete_profile2_viewmodel.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_textfields.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class CompleteProfile2View extends StatelessWidget {
  final CompleteProfile2ViewModel viewModel =
      Get.put(CompleteProfile2ViewModel());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: ScrollableColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                progressBar(),
                completeYourProfileTxt(),
                Form(
                  key: viewModel.completeProfile2Key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addressTxtField(),
                      Padding(
                        padding: EdgeInsets.only(right: 24,left: 24, bottom: 5,top: 15),
                        child: RichText(
                          text: TextSpan(
                            text: 'Mobile Number'.tr,
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      numberTextField(),
                      idNumberTxtField(),
                    ],
                  ),
                ),
                Spacer(),
                continueBtn(),
              ],
            ),
          ),
        ),
        LoaderView(),
      ],
    );
  }

  Widget progressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
      child: Row(
        children: [
          linearProgressBar(),
          const SizedBox(width: 10),
          stepNoTxt(),
        ],
      ),
    );
  }

  Widget linearProgressBar() {
    return const Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: LinearProgressIndicator(
          backgroundColor: Color(0xffC7D3EB),
          value: 0.66,
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xff0C8A7B),
          ),
          minHeight: 10,
          color: Color(0xffC7D3EB),
        ),
      ),
    );
  }

  Widget stepNoTxt() {
    return Text(
      'step 2 of 3'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  
  Widget completeYourProfileTxt() {
    return Padding(
      padding: const EdgeInsets.only(right: 24,bottom: 30, top: 15, left: 24),
      child: Text(
        "Complete Your Profile".tr,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Color(0xff1A1D1E),
        ),
      ),
    );
  }

  Widget addressTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.addressController,
        fillColor: Color(0xffFFFFFF),
        title: "Address".tr,
        hintText: "Address".tr,
        textColor: Color(0xff828A89),
        keyboardType: TextInputType.text,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }


  Widget numberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: countryFlagNumberTextField(
        controller: viewModel.phoneNumberController,
        keyboardType: TextInputType.number,
        initialvalue: viewModel.countryCode.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
        onChanged: (val) {
          viewModel.countryCode.value = val.dialCode!;
        },
      ),
    );
  }

  Widget idNumberTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      child: CustomTextField13(
        controller: viewModel.idNumberController,
        fillColor: Color(0xffFFFFFF),
        title: "ID Number".tr,
        hintText: "ID Number".tr,
        textColor: Color(0xff828A89),
        inputFormatter: [
          FilteringTextInputFormatter.allow(RegExp(r'\d')),
        ],
        keyboardType: TextInputType.number,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return CommonFunctions.validateDefaultTxtField(value);
        },
      ),
    );
  }


  Widget continueBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Continue".tr,
        onPressed: () {
          viewModel.continueBtn();
        },
      ),
    );
  }
}
