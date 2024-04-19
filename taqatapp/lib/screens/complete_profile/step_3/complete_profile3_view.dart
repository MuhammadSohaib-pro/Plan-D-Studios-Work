import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/screens/complete_profile/step_3/complete_profile3_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class CompleteProfile3View extends StatelessWidget {
  final CompleteProfile3ViewModel viewModel =
      Get.put(CompleteProfile3ViewModel());

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
                Obx(
                  () => documentSelectionItem(
                    title: 'Sponsor Labor ID'.tr,
                    file: viewModel.sponsorIDFile.value,
                    onTap: () {
                      viewModel.type = 1;
                      selectImageBottomSheet();
                    },
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: documentSelectionItem(
                      title: 'Salary Certificate or Bank Salary'.tr,
                      file: viewModel.salaryCertificateFile.value,
                      onTap: () {
                        viewModel.type = 2;
                        selectImageBottomSheet();
                      },
                    ),
                  ),
                ),
                Obx(
                  () => documentSelectionItem(
                    title: 'Marriage Certificate'.tr,
                    file: viewModel.marriageCertificateFile.value,
                    onTap: () {
                      viewModel.type = 3;
                      selectImageBottomSheet();
                    },
                  ),
                ),
                Spacer(),
                completeBtn(),
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
          value: 1.0,
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
      'step 3 of 3'.tr,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xff000000),
      ),
    );
  }

  Padding completeYourProfileTxt() {
    return Padding(
      padding: const EdgeInsets.only(right: 24, bottom: 30, top: 15, left: 24),
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

  Widget documentSelectionItem(
      {required GestureTapCallback? onTap,
      required String title,
      required File file,
      String? asterick}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.mainColor,
          width: 0.5,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff1A1D1E),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        asterick != null
                            ? Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Icon(
                      Icons.add,
                      color: ThemeColors.mainColor,
                    ),
                  ],
                ),
                file.path != ''
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 140,
                        color: Colors.grey.shade300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : SizedBox(height: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectImageBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Image'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                    InkWell(
                      customBorder: CircleBorder(),
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.5,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              BottomSheetItemRow(
                title: 'Photo Library'.tr,
                icon: CupertinoIcons.photo_on_rectangle,
                onTap: () {
                  viewModel.imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera'.tr,
                icon: CupertinoIcons.photo_camera,
                onTap: () {
                  viewModel.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget completeBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Complete".tr,
        onPressed: () {
          viewModel.completeBtn();
        },
      ),
    );
  }
}
