import 'package:kiosk/helper/constants.dart';

import '../../../helper/check_navigation.dart';
import '../../../libraries.dart';

class SingleLineQuestionView extends StatelessWidget {
  SingleLineQuestionView({super.key});

  final SingleLineQuestionViewModel viewModel =
      Get.put(SingleLineQuestionViewModel());

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
                  // singleLineQuestionTxt(),
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
            checknavigation();
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.required
                      ? viewModel.value.value != ''
                          ? ThemeColors.fullLightPrimary
                          : ThemeColors.grey2
                      : ThemeColors.fullLightPrimary,
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

  Widget singleLineQuestionTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 0
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: Text(
        "Single Line Question".tr,
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
              ? 0
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
              ? 0
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20),
      child: SizedBox(
        width: Get.context!.isTablet && Get.context!.isLandscape
            ? Get.width / 3
            : double.infinity,
        child: Form(
          key: viewModel.singlequestionkey,
          child: CustomTextField2(
            onChanged: (v) {
              viewModel.value.value = v;
            },
            asterisk: true,
            fillColor: ThemeColors.white,
            controller: viewModel.questionController,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            validator: (value) {
              return CommonFunctions.validateDefaultTxtField(value);
            },
          ),
        ),
      ),
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 0
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.required
                ? viewModel.value.value != ''
                    ? ThemeColors.fullLightPrimary
                    : ThemeColors.grey2
                : ThemeColors.fullLightPrimary,
            child: Text(
              "Next",
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

  checknavigation() {
    viewModel.storewaiverModel();
    if (viewModel.required) {
      if (viewModel.singlequestionkey.currentState!.validate()) {
        GlobalVariables.includeradiobutton
            ? Get.to(() => SingleChoiceRadioBtnView())
            : GlobalVariables.includecheckbox
                ? Get.to(() => MultipleChoiceCheckBoxBtnView())
                : GlobalVariables.includeparagraph
                    ? Get.to(() => ParagraphQuestionView())
                    : Navigation.checknavigation();
      }
    } else {
      GlobalVariables.includeradiobutton
          ? Get.to(() => SingleChoiceRadioBtnView())
          : GlobalVariables.includecheckbox
              ? Get.to(() => MultipleChoiceCheckBoxBtnView())
              : GlobalVariables.includeparagraph
                  ? Get.to(() => ParagraphQuestionView())
                  : Navigation.checknavigation();
    }
  }

  // Color btncolor() {
  //   return
  // }
}
