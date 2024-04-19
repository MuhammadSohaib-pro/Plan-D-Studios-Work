import 'package:flutter/cupertino.dart';

import '../../libraries.dart';

class ScreenSaverView extends StatelessWidget {
  ScreenSaverView({super.key});

  final ScreenSaverViewModel viewModel = Get.put(ScreenSaverViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            uploadImagesTxt(),
            browseFileWidgets(),
            changePictureCheckBoxRow(),
            selectDurationTxtField(),
            saveBtn()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Screensaver",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget uploadImagesTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
      ),
      child: Text(
        "Upload images",
        style: TextStyle(
          fontSize: 14,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget browseFileWidgets() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
          vertical: 40),
      child: Wrap(
        runSpacing: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 15,
        spacing: Get.context!.isTablet && Get.context!.isLandscape ? 40 : 20,
        alignment: WrapAlignment.spaceBetween,
        children: [
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DottedBorder(
            radius: Radius.circular(10),
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            color: ThemeColors.grey2,
            strokeWidth: 2,
            dashPattern: const [4.5, 4.5],
            child: Container(
              height: 120,
              width: (Get.context!.isTablet && Get.context!.isLandscape)
                  ? Get.width / 5
                  : Get.width / 2.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ThemeColors.grey2.withOpacity(.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: ThemeColors.fullLightPrimary,
                    size: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "Browse files",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "1024 x 768",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.grey2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget changePictureCheckBoxRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
      ),
      child: Wrap(
        children: [
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? 165
                : double.infinity,
            child: SimpleCheckBox(
              title: "Change Picture",
              value: true,
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 90),
          SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape
                ? 155
                : double.infinity,
            child: SimpleCheckBox(
              title: "Random order",
              value: false,
              onChanged: (value) {},
            ),
          ),
          SizedBox(width: 80),
          SizedBox(
              width: Get.context!.isTablet && Get.context!.isLandscape
                  ? 120
                  : double.infinity,
              child: Row(
                children: [
                  Switch(
                    activeColor: Colors.teal,
                    // value: viewModel.experiencedBtn.value,
                    value: true,
                    onChanged: (value) {
                      // viewModel.experiencedBtn.value = value;
                    },
                  ),
                  Text(
                    "Turn on",
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget selectDurationTxtField() {
    return Container(
      width: 200,
      margin: EdgeInsets.fromLTRB(
          Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
          20,
          Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
          25),
      child: CustomTextField13(
        controller: viewModel.timeController,
        hintText: "Select Duration",
        textColor: const Color(0xff828A89),
        fillColor: ThemeColors.grey2.withOpacity(.1),
        sufixIcon: const Icon(
          Icons.arrow_drop_down,
          color: const Color(0xff828A89),
        ),
        readOnly: true,
        onTap: () {
          showModalBottomSheet(
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
                        'Cancel',
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
                          initialItem: viewModel.timeIndex,
                        ),
                        itemExtent: 35,
                        onSelectedItemChanged: (int index) {
                          viewModel.timeIndex = index;
                          viewModel.timeController.text =
                              "Every ${viewModel.timeList[viewModel.timeIndex]} seconds";
                        },
                        children: List.generate(
                          viewModel.timeList.length,
                          (int index) {
                            return Center(
                              child: Text(
                                "Every ${viewModel.timeList[index]} Seconds",
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
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget saveBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 61 : 20,
          vertical: 20),
      child: CustomElevatedBtn(
        height: 50,
        width: 110,
        backgroundColor: ThemeColors.fullLightPrimary,
        onPressed: () {},
        child: Text(
          "Save",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
