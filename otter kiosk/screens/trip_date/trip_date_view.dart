import 'package:intl/intl.dart';

import '../../libraries.dart';

class TripDateView extends StatelessWidget {
  TripDateView({super.key});

  final TripDateViewModel viewModel = Get.put(TripDateViewModel());
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                dateTxtField(context),
                SizedBox(height: 20),
                nextBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: forwardBackBtnRow(),
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
    );
  }

  Widget forwardBackBtnRow() {
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
            GlobalVariables.datamodel.tripDateRequired == false
                ? adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                        adultviewModel.participatingTypeBtn.value ==
                            "Adult + Minor(s)"
                    ? Get.to(() => MinorParticipantView())
                    : Get.to(() => AdultParticipantView())
                : viewModel.formkey.currentState!.validate()
                    ? adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                            adultviewModel.participatingTypeBtn.value ==
                                "Adult + Minor(s)"
                        ? Get.to(() => MinorParticipantView())
                        : Get.to(() => AdultParticipantView())
                    : null;
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.selectedDate.value != ""
                      ? ThemeColors.fullLightPrimary
                      : ThemeColors.grey2,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: ThemeColors.white,
                ),
              )),
        )
      ],
    );
  }

  Widget dateTxtField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 250
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : Get.context!.isLandscape && Get.context!.isPhone
                      ? 14.w
                      : 20.0),
      child: Form(
        key: viewModel.formkey,
        child: CustomTextField13(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field is required';
            }
            return null;
          },
          fillColor: ThemeColors.white,
          textColor: ThemeColors.primaryColor,
          controller: viewModel.dateController,
          showCursor: false,
          hintText: "MM/DD/YYYY".tr,
          title: "Trip Date *".tr,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          sufixIcon: Icon(Icons.arrow_drop_down),
          readOnly: true,
          onTap: () async {
            DateTime? dateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(3000),
            );
            if (dateTime != null) {
              var dt = DateFormat.yMd().format(dateTime);
              viewModel.dateController.text = dt;
              viewModel.selectedDate.value = dt;
            }
          },
        ),
      ),
    );
  }

  Widget nextBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.context!.isTablet && Get.context!.isLandscape
              ? 250
              : Get.context!.isTablet && Get.context!.isPortrait
                  ? Get.width / 5.5
                  : Get.context!.isLandscape && Get.context!.isPhone
                      ? 14.w
                      : 20.0),
      child: Obx(() => CustomElevatedBtn(
            height: 45,
            width: 120,
            backgroundColor: viewModel.selectedDate.value != ""
                ? ThemeColors.fullLightPrimary
                : ThemeColors.grey2,
            child: Text(
              "Next".tr,
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              GlobalVariables.datamodel.tripDateRequired == false
                  ? adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                          adultviewModel.participatingTypeBtn.value ==
                              "Adult + Minor(s)"
                      ? Get.to(() => MinorParticipantView())
                      : Get.to(() => AdultParticipantView())
                  : viewModel.formkey.currentState!.validate()
                      ? adultviewModel.participatingTypeBtn.value ==
                                  "Minor(s)" ||
                              adultviewModel.participatingTypeBtn.value ==
                                  "Adult + Minor(s)"
                          ? Get.to(() => MinorParticipantView())
                          : Get.to(() => AdultParticipantView())
                      : null;
            },
          )),
    );
  }
}
