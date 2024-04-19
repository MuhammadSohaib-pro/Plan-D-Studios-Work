import 'package:kiosk/helper/constants.dart';
import 'package:kiosk/screens/add_same_process/multiple_chioce/multiple_choice_checkbox_viewmodel.dart';

import '../../../helper/check_navigation.dart';
import '../../../libraries.dart';

class MultipleChoiceCheckBoxBtnView extends StatelessWidget {
  MultipleChoiceCheckBoxBtnView({super.key});

  final MultipleChoiceCheckBoxBtnViewModel viewModel =
      Get.put(MultipleChoiceCheckBoxBtnViewModel());

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
              child: Container(
                height: 50.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20),
                    // singleChoiceQuestionTxt(),
                    SizedBox(height: 20),
                    QuestionTxt(),
                    SizedBox(height: 20),
                    yesNoMaybeCheckBoxes(context),
                    SizedBox(height: 20),
                    nextBtn(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
        // SingleChildScrollView(
        //   child: Column(
        //     crossAxisAlignment:
        //         Get.context!.isTablet && Get.context!.isLandscape
        //             ? CrossAxisAlignment.center
        //             : CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: Get.context!.isLandscape && Get.context!.isPhone
        //             ? EdgeInsets.symmetric(horizontal: ShowPadding.horizontal)
        //             : EdgeInsets.zero,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // SizedBox(height: 20),
        //             // multipleChoiceQuestionTxt(),
        //             SizedBox(height: 20),
        //             QuestionTxt(),
        //             SizedBox(height: 20),
        //             yesNoMaybeCheckBoxes(context),
        //             SizedBox(height: 20),
        //             nextBtn(),
        //             SizedBox(height: 20),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
                      'By using this kiosk you consent to have your picture taken.',
                      maxLines: 4,
                      style: TextStyle(color: ThemeColors.white),
                    )),
              )
            : SizedBox(),
        GestureDetector(
          onTap: () {
            checknavigation();
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: viewModel.required
                        ? viewModel.value.value
                            ? ThemeColors.fullLightPrimary
                            : ThemeColors.grey2
                        : ThemeColors.fullLightPrimary),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        ),
      ],
    );
  }

  // Widget multipleChoiceQuestionTxt() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isLandscape
  //             ? 150
  //             : Get.context!.isTablet && Get.context!.isPortrait
  //                 ? Get.width / 5.5
  //                 : 20),
  //     child: Text(
  //       "Mutiple Choice question",
  //       style: TextStyle(
  //         fontSize: 18,
  //         color: ThemeColors.primaryColor,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }

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

  Widget yesNoMaybeCheckBoxes(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Container(

          // height: 70.h,
          width: Get.context!.isTablet && Get.context!.isLandscape
              ? Get.width / 3
              : double.infinity,
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (_, __) {
                return SizedBox(
                  height: 9,
                );
              },
              itemCount: viewModel.option.length,
              itemBuilder: ((context, index) {
                return Obx(() => Container(
                      color: Colors.grey.shade200,
                      child: SimpleCheckBox(
                        title: viewModel.option[index].label,
                        onChanged: (value) {
                          viewModel.option[index].value.value = value;
                          viewModel.value.value = viewModel.option
                              .any((option) => option.value.value);
                        },
                        value: viewModel.option[index].value.value,
                      ),
                    ));
              }))

          //  Obx(
          //   () => Column(
          //     children: [
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: SimpleCheckBox(
          //           title: "YES",
          //           onChanged: (value) {
          //             viewModel.yesCheckBox.value = value;
          //           },
          //           value: viewModel.yesCheckBox.value,
          //         ),
          //       ),
          //       SizedBox(height: 15),
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: SimpleCheckBox(
          //           title: "NO",
          //           onChanged: (value) {
          //             viewModel.noCheckBox.value = value;
          //           },
          //           value: viewModel.noCheckBox.value,
          //         ),
          //       ),
          //       SizedBox(height: 15),
          //       Container(
          //         color: Colors.grey.shade200,
          //         child: SimpleCheckBox(
          //           title: "Maybe",
          //           onChanged: (value) {
          //             viewModel.mayBeCheckBox.value = value;
          //           },
          //           value: viewModel.mayBeCheckBox.value,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          ),
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.required
                ? viewModel.value.value
                    ? ThemeColors.fullLightPrimary
                    : ThemeColors.grey2
                : ThemeColors.fullLightPrimary,
            child: Text(
              "Next".tr,
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              checknavigation();
            },
          )),
    );
  }

  void checknavigation() {
    viewModel.storewaiverModel();
    if (viewModel.required) {
      if (viewModel.value.value != '') {
        GlobalVariables.includeparagraph
            ? Get.to(() => ParagraphQuestionView())
            : Navigation.checknavigation();
      }
    } else {
      GlobalVariables.includeparagraph
          ? Get.to(() => ParagraphQuestionView())
          : Navigation.checknavigation();
    }
  }
}
