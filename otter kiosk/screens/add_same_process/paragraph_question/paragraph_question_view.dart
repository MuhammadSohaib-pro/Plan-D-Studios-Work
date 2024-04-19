import 'package:kiosk/helper/constants.dart';

import '../../../helper/check_navigation.dart';
import '../../../libraries.dart';

class ParagraphQuestionView extends StatelessWidget {
  ParagraphQuestionView({super.key});

  final ParagraphQuestionViewModel viewModel =
      Get.put(ParagraphQuestionViewModel());

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
              child: Form(
                key: viewModel.validatekey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20),
                    // paragraphQuestionTxt(),
                    SizedBox(height: 20),
                    QuestionTxt(),
                    SizedBox(height: 20),
                    questionTxtField(),
                    SizedBox(height: 20),
                    nextBtn(),
                    SizedBox(height: 20),
                  ],
                ),
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
            viewModel.storewaiverModel();
            if (viewModel.required) {
              if (viewModel.validatekey.currentState!.validate()) {
                Navigation.checknavigation();
              }
            } else {
              Navigation.checknavigation();
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.value.value != ''
                      ? ThemeColors.fullLightPrimary
                      : ThemeColors.grey2,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        ),
      ],
    );
  }

  // Widget paragraphQuestionTxt() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isLandscape
  //             ? 150
  //             : Get.context!.isTablet && Get.context!.isPortrait
  //                 ? Get.width / 5.5
  //                 : 20),
  //     child: Text(
  //       "Paragraph Question",
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

  Widget questionTxtField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 150
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 3
            : double.infinity,
        child: CustomTextField13(
          onChanged: (v) {
            viewModel.value.value = v;
          },
          hintText: "Question",
          maxLines: 5,
          fillColor: ThemeColors.white,
          controller: viewModel.questionController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.name,
          validator: (value) {
            return CommonFunctions.validateDefaultTxtField(value);
          },
        ),
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
            backgroundColor: viewModel.value.value != ''
                ? ThemeColors.fullLightPrimary
                : ThemeColors.grey2,
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              viewModel.storewaiverModel();
              if (viewModel.required) {
                if (viewModel.validatekey.currentState!.validate()) {
                  Navigation.checknavigation();
                }
              } else {
                Navigation.checknavigation();
              }
            },
          )),
    );
  }
}
