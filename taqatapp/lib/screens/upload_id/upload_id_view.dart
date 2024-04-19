import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/screens/upload_id/upload_id_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';

class UploadIDView extends StatelessWidget {
  final UploadIDViewModel viewModel = Get.put(UploadIDViewModel());

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
                uploadDocumentView(),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: documentSelectionItem(
                      title: 'Sponsor Labor ID'.tr,
                      asterick: "*",
                      file: viewModel.sponsorLaborID.value,
                      onTap: () {
                        selectImageBottomSheet();
                      },
                    ),
                  ),
                ),
                Spacer(),
                UploadBtn(),
              ],
            ),
          ),
        ),
        LoaderView(),
      ],
    );
  }

  Widget uploadDocumentView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15, left: 24),
      child: Text(
        "Upload Document".tr,
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file,
                            fit: BoxFit.fill,
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
                  Get.back();
                  viewModel.imgFromGallery();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera'.tr,
                icon: CupertinoIcons.photo_camera,
                onTap: () {
                  Get.back();
                  viewModel.imgFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget UploadBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 15, 24, 15),
      child: CustomButton8(
        backgroundColor: const Color(0xff0C8A7B),
        text: "Upload".tr,
        onPressed: () {
          viewModel.uploadBtn();
        },
      ),
    );
  }
}
