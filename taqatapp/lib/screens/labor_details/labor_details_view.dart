import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/labor_details/labor_details_viewmodel.dart';
import 'package:taqat/screens/upload_document/upload_document_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_checkbox.dart';
import 'package:taqat/widgets/loader_view.dart';

class LaborDetailsView extends StatelessWidget {
  final LaborDetailsViewModel viewModel = Get.put(LaborDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  imageContainer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        nameDistance(),
                        location(),
                        categoryAge(),
                        divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 30),
                          child: Row(
                            children: [
                              item1(
                                title: 'Gender'.tr,
                                value: viewModel.laborDetail.value.gender ?? "",
                              ),
                              SizedBox(width: 5),
                              item1(
                                title: 'Experiences'.tr,
                                value:
                                    '${viewModel.laborDetail.value.experience ?? ""} ${'year'.tr}',
                              ),
                              SizedBox(width: 5),
                              item1(
                                title: 'Religion'.tr,
                                value:
                                    '${viewModel.laborDetail.value.religion ?? 'N/A'}',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item2(
                                  title: 'Passport No'.tr,
                                  value:
                                      viewModel.laborDetail.value.passportNo ??
                                          "",
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 25),
                                  child: item2(
                                    title: 'Education'.tr,
                                    value:
                                        viewModel.laborDetail.value.education ??
                                            "",
                                  ),
                                ),
                                item2(
                                  title: 'DOB'.tr,
                                  value: viewModel.laborDetail.value.dob ?? "",
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                item2(
                                  title: 'Martial Status'.tr,
                                  value: viewModel
                                          .laborDetail.value.maritalStatus ??
                                      "",
                                ),
                                SizedBox(height: 25),
                                item2(
                                  title: 'Working'.tr,
                                  value:
                                      viewModel.laborDetail.value.jobType ?? "",
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        hireBtn(context)
                      ],
                    ),
                  )
                ],
              ),
            ),
            LoaderView()
          ],
        ),
      ),
    );
  }

  Widget imageContainer() {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              '${Urls.imageUrl + (viewModel.laborDetail.value.laborPhoto ?? '')}',
          height: Get.height * 0.3,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/default_image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2.0),
            );
          },
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: 7, top: 7, right: 7),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(33)),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget nameDistance() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            viewModel.laborDetail.value.fullname ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        RichText(
          text: TextSpan(
            text:
                '${'OMR'.tr} ${viewModel.laborDetail.value.monthlySalary ?? ""}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ThemeColors.grey2,
            ),
            children: [
              TextSpan(
                text: '/',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: 'm'.tr,
                style: TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15,
                color: ThemeColors.grey2,
              ),
              SizedBox(width: 3),
              Text(
                viewModel.laborDetail.value.location ?? "",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            viewModel.laborDetail.value.nationality ?? "",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryAge() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewModel.laborDetail.value.title ?? "",
          style: TextStyle(
            fontSize: 11,
            color: ThemeColors.grey3,
          ),
        ),
        ageTxt(),
      ],
    );
  }

  Widget ageTxt() {
    if (viewModel.laborDetail.value.dob != null) {
      DateTime dateTimeNow =
          DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
      DateTime dob = DateFormat('yyyy-MM-dd')
          .parse(viewModel.laborDetail.value.dob.toString());
      viewModel.age.value = (dateTimeNow.year - dob.year).toString();
    }
    return Obx(
      () => Text(
        '${viewModel.age.value} ${'Years Old'.tr}',
        style: TextStyle(
          fontSize: 11,
          color: ThemeColors.grey3,
        ),
      ),
    );
  }

  Widget divider() {
    return Divider(
      height: 40,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Color(0xffF0F0F2),
    );
  }

  Widget item1({required String title, required String value}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: ThemeColors.grey4,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            decoration: BoxDecoration(
              color: ThemeColors.grey5,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: ThemeColors.black1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget item2({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ThemeColors.black1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: ThemeColors.grey4,
          ),
        )
      ],
    );
  }

  Widget hireBtn(BuildContext context) {
    return !viewModel.hireBtnFlag.value? CustomTextBtn(
      onPressed: () {
        if (GlobalVariables.profileCompletion.value == 100) {
          confirmSalaryDialog();
        } else {
          GetxHelper.showSnackBar(
              title: 'Error'.tr,
              message: 'Please complete your profile first'.tr);
        }
      },
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff0C8A7B),
      child: Text(
        'Hire'.tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ):SizedBox();
  }

  Future<dynamic> confirmSalaryDialog() {
    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm your Salary'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 30),
                confirmationCheckBox(),
                SizedBox(height: 10),
                doneBtn()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget confirmationCheckBox() {
    return Obx(
      () => SimpleCheckBox(
        title:
            "${'I confirmed that my salary is greater or equal to'.tr} ${viewModel.minSalary.value} RO",
        value: viewModel.minSalaryFlag.value,
        onChanged: (value) {
          viewModel.minSalaryFlag.value = value;
        },
      ),
    );
  }

  Widget doneBtn() {
    return Obx(
      () => CustomButton8(
        text: "Done".tr,
        textColor: viewModel.minSalaryFlag.value
            ? Color(0xffEFF2F1)
            : Color(0xff000000),
        onPressed: viewModel.minSalaryFlag.value
            ? () {
                Get.back();
                if (GlobalVariables.userModel.value.salaryCertificate == null ||
                    GlobalVariables.userModel.value.marriageCertificate ==
                        null) {
                  alertDialogforUser();
                } else {
                  if (GlobalVariables.userModel.value.hireLaborStatus == 1) {
                    viewModel.hireBtn();
                    viewModel.minSalaryFlag.value = false;
                  } else {
                    viewModel.minSalaryFlag.value = false;
                    GetxHelper.showSnackBar(
                        title: 'Error'.tr,
                        message:
                            'The document has not been verified by the admin yet.'
                                .tr);
                  }
                }
              }
            : () {},
        backgroundColor: viewModel.minSalaryFlag.value
            ? Color(0xff0C8A7B)
            : Color(0xffEFF2F1),
      ),
    );
  }

  Future<dynamic> alertDialogforUser() {
    return showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Document Alert'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: ThemeColors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: Text(
                    'Please upload required document first'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton8(
                        text: "Cancel".tr,
                        backgroundColor: ThemeColors.mainColor,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CustomButton8(
                        text: "Upload".tr,
                        backgroundColor: ThemeColors.mainColor,
                        onPressed: () {
                          Get.back();
                          Get.to(() => UploadDocumentView());
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
