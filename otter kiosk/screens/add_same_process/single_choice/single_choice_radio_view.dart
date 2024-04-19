import 'package:kiosk/helper/constants.dart';

import '../../../helper/check_navigation.dart';
import '../../../libraries.dart';

class SingleChoiceRadioBtnView extends StatelessWidget {
  SingleChoiceRadioBtnView({super.key});

  final SingleChoiceRadioBtnViewModel viewModel =
      Get.put(SingleChoiceRadioBtnViewModel());

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
                  // SizedBox(height: 20),
                  // singleChoiceQuestionTxt(),
                  SizedBox(height: 20),
                  QuestionTxt(),
                  SizedBox(height: 20),
                  yesNoMaybeRadioBtn(),
                  SizedBox(height: 20),
                ],
              ),
            )
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
            viewModel.storewaiverModel();
            if (viewModel.required) {
              if (viewModel.groupValue.value != "") {
                GlobalVariables.includecheckbox
                    ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                    : GlobalVariables.includeparagraph
                        ? Get.to(() => ParagraphQuestionView())
                        : Navigation.checknavigation();
              }
            } else {
              GlobalVariables.includecheckbox
                  ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                  : GlobalVariables.includeparagraph
                      ? Get.to(() => ParagraphQuestionView())
                      : Navigation.checknavigation();
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: viewModel.groupValue.value != ""
                        ? ThemeColors.fullLightPrimary
                        : ThemeColors.grey2),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        ),
      ],
    );
  }

  Widget singleChoiceQuestionTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Single Choice question".tr,
        style: TextStyle(
          fontSize: 18,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget QuestionTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        viewModel.question,
        style: TextStyle(
          fontSize: 15,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget yesNoMaybeRadioBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
          height: 70.h,
          width: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 3
              : double.infinity,
          child: ListView.separated(
              separatorBuilder: (_, __) {
                return SizedBox(
                  height: 9,
                );
              },
              itemCount: viewModel.option.length,
              itemBuilder: ((context, index) {
                return Obx(() => Container(
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [
                          Radio(
                            value: viewModel.option[index],
                            groupValue: viewModel.groupValue.value,
                            onChanged: (value) {
                              viewModel.groupValue.value = value!;
                            },
                          ),
                          SizedBox(width: 20),
                          Text(
                            viewModel.option[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ));
              }))
          // Obx(
          //   () => Column(
          //     children: [
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: Row(
          //           children: [
          //             // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
          //             Radio(
          //               value: "YES",
          //               groupValue: viewModel.groupValue.value,
          //               onChanged: (value) {
          //                 viewModel.groupValue.value = value!;
          //               },
          //             ),
          //             SizedBox(width: 20),
          //             Text(
          //               "YES",
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(height: 15),
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: Row(
          //           children: [
          //             Radio(
          //               value: "Maybe",
          //               groupValue: viewModel.groupValue.value,
          //               onChanged: (value) {
          //                 viewModel.groupValue.value = value!;
          //               },
          //             ),
          //             SizedBox(width: 20),
          //             Text(
          //               "Maybe",
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       SizedBox(height: 15),
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: Row(
          //           children: [
          //             Radio(
          //               value: "NO",
          //               groupValue: viewModel.groupValue.value,
          //               onChanged: (value) {
          //                 viewModel.groupValue.value = value!;
          //               },
          //             ),
          //             SizedBox(width: 20),
          //             Text(
          //               "NO",
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          ),
    );
  }
}
