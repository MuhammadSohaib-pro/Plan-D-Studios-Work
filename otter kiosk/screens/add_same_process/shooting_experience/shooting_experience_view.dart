import 'package:kiosk/helper/constants.dart';

import '../../../libraries.dart';

class ShootingExperienceView extends StatelessWidget {
  ShootingExperienceView({super.key});

  final ShootingExperienceViewModel viewModel =
      Get.put(ShootingExperienceViewModel());
  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: Get.context!.isTablet && Get.context!.isLandscape
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Get.context!.isLandscape && Get.context!.isPhone
                  ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
                  : EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  shootingExpTxt(),
                  SizedBox(height: 20),
                  radioBtn(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
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
            viewModel.handGunGroupValue.value != '' &&
                    viewModel.rifleGroupValue.value != '' &&
                    viewModel.shotgunGroupValue.value != ''
                ? GlobalVariables.datamodel.includeRulesOfFirearmSafety!
                    ? Get.to(() => FirearmSafetyView())
                    : adultviewModel.participatingTypeBtn.value == "Adult" ||
                            adultviewModel.participatingTypeBtn.value ==
                                "Adult + Minor(s)"
                        ? GlobalVariables.datamodel.includeQuestions4473!
                            ? Get.to(() => EligiablityRequirementView())
                            : Get.to(() => WaiverView())
                        : Get.to(() => WaiverView())
                : GetxHelper.showSnackBar(
                    title: 'Error', message: 'Select an option');
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
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget shootingExpTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 3
                  : 20),
      child: Text(
        "Shooting Experience".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget radioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 60
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 3
                  : 20),
      child: Obx(
        () => Wrap(
          runSpacing: 20,
          spacing: 40,
          children: [
            handGunRadioBtns(),
            rifleRadioBtns(),
            shotGunRadioBtns(),
          ],
        ),
      ),
    );
  }

  Widget handGunRadioBtns() {
    return SizedBox(
      width: Get.context!.isTablet && Get.context!.isLandscape
          ? Get.width / 4
          : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hand Gun *".tr,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Radio(
                value: "1st Time",
                groupValue: viewModel.handGunGroupValue.value,
                onChanged: (value) {
                  viewModel.handGunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "1st Time".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Novice",
                groupValue: viewModel.handGunGroupValue.value,
                onChanged: (value) {
                  viewModel.handGunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Novice".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Beginner",
                groupValue: viewModel.handGunGroupValue.value,
                onChanged: (value) {
                  viewModel.handGunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Beginner".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Intermediate",
                groupValue: viewModel.handGunGroupValue.value,
                onChanged: (value) {
                  viewModel.handGunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Intermediate".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Expert",
                groupValue: viewModel.handGunGroupValue.value,
                onChanged: (value) {
                  viewModel.handGunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Expert".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rifleRadioBtns() {
    return SizedBox(
      width: Get.context!.isTablet && Get.context!.isLandscape
          ? Get.width / 4
          : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rifle *".tr,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Radio(
                value: "1st Time",
                groupValue: viewModel.rifleGroupValue.value,
                onChanged: (value) {
                  viewModel.rifleGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "1st Time".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Novice",
                groupValue: viewModel.rifleGroupValue.value,
                onChanged: (value) {
                  viewModel.rifleGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Novice".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Beginner",
                groupValue: viewModel.rifleGroupValue.value,
                onChanged: (value) {
                  viewModel.rifleGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Beginner".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Intermediate",
                groupValue: viewModel.rifleGroupValue.value,
                onChanged: (value) {
                  viewModel.rifleGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Intermediate".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Expert",
                groupValue: viewModel.rifleGroupValue.value,
                onChanged: (value) {
                  viewModel.rifleGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Expert".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget shotGunRadioBtns() {
    return SizedBox(
      width: Get.context!.isTablet && Get.context!.isLandscape
          ? Get.width / 4
          : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shotgun *".tr,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Radio(
                value: "1st Time",
                groupValue: viewModel.shotgunGroupValue.value,
                onChanged: (value) {
                  viewModel.shotgunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "1st Time".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Novice",
                groupValue: viewModel.shotgunGroupValue.value,
                onChanged: (value) {
                  viewModel.shotgunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Novice".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Beginner",
                groupValue: viewModel.shotgunGroupValue.value,
                onChanged: (value) {
                  viewModel.shotgunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Beginner".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Intermediate",
                groupValue: viewModel.shotgunGroupValue.value,
                onChanged: (value) {
                  viewModel.shotgunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Intermediate".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: "Expert",
                groupValue: viewModel.shotgunGroupValue.value,
                onChanged: (value) {
                  viewModel.shotgunGroupValue.value = value!;
                  checknavigation();
                },
              ),
              SizedBox(width: 20),
              Text(
                "Expert".tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  checknavigation() {
    if (viewModel.handGunGroupValue.value != '' &&
        viewModel.rifleGroupValue.value != '' &&
        viewModel.shotgunGroupValue.value != '') {
      print('navigate');
      GlobalVariables.datamodel.includeRulesOfFirearmSafety!
          ? Get.to(() => FirearmSafetyView())
          : adultviewModel.participatingTypeBtn.value == "Adult" ||
                  adultviewModel.participatingTypeBtn.value ==
                      "Adult + Minor(s)"
              ? Get.to(() => EligiablityRequirementView())
              : Get.to(() => WaiverView());
    } else {
      print('not navigate');
    }
  }
}
