import '../../../libraries.dart';

class AdultProcessView extends StatefulWidget {
  AdultProcessView({super.key});

  @override
  State<AdultProcessView> createState() => _AdultProcessViewState();
}

class _AdultProcessViewState extends State<AdultProcessView> {
  final AdultProcessViewModel viewModel = Get.find<AdultProcessViewModel>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Scaffold(
              appBar: appBar(),
              body: Obx(
                () => GlobalVariables.showLoader.value
                    ? LoaderView()
                    : viewModel.showerror.value != ''
                        ? showError(ontap: () {
                            viewModel.getadultprocessdata;
                          })
                        : ScrollableColumn(
                            children: [
                              // selectlanguage(),
                              SizedBox(height: 20),
                              bulletImage(),
                              SizedBox(height: 20),
                              pleaseSelectWhoTxt(),
                              SizedBox(height: 20),
                              Column(
                                children: [
                                  adultMinorBtnRow(),
                                  SizedBox(height: 30),
                                  if (viewModel.participatingTypeBtn.value ==
                                          "Adult + Minor(s)" ||
                                      viewModel.participatingTypeBtn.value ==
                                          "Minor(s)") ...[
                                    howManyMinorsTxt(),
                                    SizedBox(height: 15),
                                    oneToFIveBtnRow(),
                                    sixToTenBtnRow(),
                                    SizedBox(height: 20),
                                    if (viewModel.selectedMinorBtn != '') ...[
                                      continueBtn(),
                                      SizedBox(height: 20)
                                    ]
                                  ] else
                                    Padding(padding: EdgeInsets.all(0)),
                                ],
                              )
                              // GlobalVariables.datamodel.ageGroup!.contains("adult") &&
                              //             GlobalVariables.datamodel.ageGroup!
                              //                 .contains("minor") ||
                              //         GlobalVariables.datamodel.ageGroup!
                              //             .contains("minor")
                              // ? Column(
                              //     children: [
                              //       SizedBox(height: 30),
                              //       howManyMinorsTxt(),
                              //       SizedBox(height: 15),
                              //       oneToFIveBtnRow(),
                              //       sixToTenBtnRow(),
                              //       SizedBox(height: 20),
                              //       // continueBtn()
                              //     ],
                              //   )
                              // : Padding(padding: EdgeInsets.all(0))
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? SizedBox(height: 30)
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? howManyMinorsTxt()
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? SizedBox(height: 15)
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? oneToFIveBtnRow()
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? sixToTenBtnRow()
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? SizedBox(height: 20)
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // viewModel.participatingTypeBtn.value == "Adult + Minor(s)" ||
                              //         viewModel.participatingTypeBtn.value == "Minor(s)"
                              //     ? continueBtn()
                              //     : Padding(padding: EdgeInsets.all(0)),
                              // SizedBox(height: 30),
                            ],
                          ),
              ),
            ));
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
            // Get.to(() => EmergencyContactView());

            if (viewModel.participatingTypeBtn.isEmpty) {
              //   GetxHelper.showSnackBar(
              //       title: "Error",
              //       message:
              //           "By using this kiosk you consent to have your picture taken.");
              // } else {}
              GetxHelper.showSnackBar(
                  title: 'Error', message: 'Select an option');
            } else {
              viewModel.participatingTypeBtn.value == "Minor(s)" ||
                      viewModel.participatingTypeBtn.value == "Adult + Minor(s)"
                  ? viewModel.selectedMinorBtn != ''
                      ? GlobalVariables.datamodel.includeVideo!
                          ? Get.to(() => WatchVideoView())
                          : GlobalVariables.datamodel.includeTripDate!
                              ? Get.to(() => TripDateView())
                              : viewModel.participatingTypeBtn.value ==
                                          "Minor(s)" ||
                                      viewModel.participatingTypeBtn.value ==
                                          "Adult + Minor(s)"
                                  ? Get.to(() => MinorParticipantView())
                                  : Get.to(() => AdultParticipantView())
                      : GetxHelper.showSnackBar(
                          title: 'Error', message: 'Select minor first')
                  : GlobalVariables.datamodel.includeVideo!
                      ? Get.to(() => WatchVideoView())
                      : GlobalVariables.datamodel.includeTripDate!
                          ? Get.to(() => TripDateView())
                          : viewModel.participatingTypeBtn.value ==
                                      "Minor(s)" ||
                                  viewModel.participatingTypeBtn.value ==
                                      "Adult + Minor(s)"
                              ? Get.to(() => MinorParticipantView())
                              : Get.to(() => AdultParticipantView());
            }
          },
          child: Obx(() => Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: viewModel.participatingTypeBtn.isEmpty
                      ? ThemeColors.grey2
                      : viewModel.participatingTypeBtn.value == "Minor(s)" ||
                              viewModel.participatingTypeBtn.value ==
                                  "Adult + Minor(s)"
                          ? viewModel.selectedMinorBtn == ''
                              ? ThemeColors.grey2
                              : ThemeColors.fullLightPrimary
                          : ThemeColors.fullLightPrimary,
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

  Widget selectlanguage() {
    return Obx(() => DropdownButton<String>(
          value: viewModel.dropdownValue.value,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          underline: Container(
            height: 1,
            color: ThemeColors.black1,
          ),
          onChanged: (String? value) {
            viewModel.dropdownValue.value = value!;
            if (value == "United States - English") {
              Get.updateLocale(Locale('en_US'));
            } else if (value == "Espana - Epanol") {
              Get.updateLocale(Locale('es_ESP'));
            } else if (value == "Espagne - Francais") {
              Get.updateLocale(Locale('fr_FRA'));
            }
            setState(() {});
          },
          items: viewModel.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }

  Widget bulletImage() {
    return Image.network(
      GlobalVariables.organization.photoUrl!,
      height: 110,
      width: 110,
    );
  }

  Widget pleaseSelectWhoTxt() {
    return Text(
      "Please select who will be participating. If both\n adults and minors are participating, you will\n need to fill out separate documents\n for each."
          .tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: ThemeColors.grey1,
      ),
    );
  }

  Widget adultMinorBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 300 : 0),
      child: Obx(() => GlobalVariables.showLoader.value
          ? LoaderView()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (GlobalVariables.datamodel.ageGroup!.length == 1) ...[
                  GlobalVariables.datamodel.ageGroup!.contains("adult")
                      ? CustomElevatedBtn(
                          height: 45,
                          width: 80,
                          child: Text(
                            "Adult".tr,
                            style: TextStyle(
                              color: ThemeColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor:
                              viewModel.participatingTypeBtn.value == "Adult"
                                  ? ThemeColors.fullLightPrimary
                                  : ThemeColors.grey2,
                          onPressed: () {
                            viewModel.participatingTypeBtn.value = "Adult";
                            GlobalVariables.datamodel.includeVideo!
                                ? Get.to(() => WatchVideoView())
                                : GlobalVariables.datamodel.includeTripDate!
                                    ? Get.to(() => TripDateView())
                                    : viewModel.participatingTypeBtn.value ==
                                                "Minor(s)" ||
                                            viewModel.participatingTypeBtn
                                                    .value ==
                                                "Adult + Minor(s)"
                                        ? Get.to(() => MinorParticipantView())
                                        : Get.to(() => AdultParticipantView());
                          },
                        )
                      :
                      // SizedBox(
                      //     width: Get.context!.isTablet && Get.context!.isLandscape
                      //         ? 50
                      //         : Get.context!.isTablet && Get.context!.isPortrait
                      //             ? 30
                      //             : 10),
                      CustomElevatedBtn(
                          height: 45,
                          width: 80,
                          child: Text(
                            "Minor(s)".tr,
                            style: TextStyle(
                              color: ThemeColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor:
                              viewModel.participatingTypeBtn.value == "Minor(s)"
                                  ? ThemeColors.fullLightPrimary
                                  : ThemeColors.grey2,
                          onPressed: () {
                            viewModel.participatingTypeBtn.value = "Minor(s)";
                          },
                        ),
                ] else ...[
                  CustomElevatedBtn(
                    height: 45,
                    width: 80,
                    child: Text(
                      "Adult".tr,
                      style: TextStyle(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor:
                        viewModel.participatingTypeBtn.value == "Adult"
                            ? ThemeColors.fullLightPrimary
                            : ThemeColors.grey2,
                    onPressed: () {
                      viewModel.participatingTypeBtn.value = "Adult";
                      GlobalVariables.datamodel.includeVideo!
                          ? Get.to(() => WatchVideoView())
                          : GlobalVariables.datamodel.includeTripDate!
                              ? Get.to(() => TripDateView())
                              : viewModel.participatingTypeBtn.value ==
                                          "Minor(s)" ||
                                      viewModel.participatingTypeBtn.value ==
                                          "Adult + Minor(s)"
                                  ? Get.to(() => MinorParticipantView())
                                  : Get.to(() => AdultParticipantView());
                    },
                  ),
                  SizedBox(
                      width: Get.context!.isTablet && Get.context!.isLandscape
                          ? 50
                          : Get.context!.isTablet && Get.context!.isPortrait
                              ? 30
                              : 10),
                  CustomElevatedBtn(
                    height: 45,
                    width: 80,
                    child: Text(
                      "Minor(s)".tr,
                      style: TextStyle(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor:
                        viewModel.participatingTypeBtn.value == "Minor(s)"
                            ? ThemeColors.fullLightPrimary
                            : ThemeColors.grey2,
                    onPressed: () {
                      viewModel.participatingTypeBtn.value = "Minor(s)";
                    },
                  ),
                ]
                //  else ...[
                //   CustomElevatedBtn(
                //     height: 45,
                //     width: 120,
                //     child: Text(
                //       "Adult + Minor(s)",
                //       style: TextStyle(
                //         color: ThemeColors.white,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     backgroundColor: viewModel.participatingTypeBtn.value ==
                //             "Adult + Minor(s)"
                //         ? ThemeColors.fullLightPrimary
                //         : ThemeColors.grey2,
                //     onPressed: () {
                //       viewModel.participatingTypeBtn.value = "Adult + Minor(s)";
                //     },
                //   )
                // ]
              ],
            )),
    );
  }

  Widget howManyMinorsTxt() {
    return Text(
      "HOW MANY MINORS?".tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: ThemeColors.grey1,
      ),
    );
  }

  Widget oneToFIveBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        numberButtons(
          number: '1',
          backgroundColor: viewModel.selectedMinorBtn.value == "1"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "1"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "1"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '1';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '2',
          backgroundColor: viewModel.selectedMinorBtn.value == "2"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "2"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "2"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '2';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '3',
          backgroundColor: viewModel.selectedMinorBtn.value == "3"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "3"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "3"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '3';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '4',
          backgroundColor: viewModel.selectedMinorBtn.value == "4"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "4"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "4"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '4';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '5',
          backgroundColor: viewModel.selectedMinorBtn.value == "5"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "5"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "5"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '5';
                },
        ),
      ],
    );
  }

  Widget sixToTenBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        numberButtons(
          number: '6',
          backgroundColor: viewModel.selectedMinorBtn.value == "6"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "6"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "6"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '6';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '7',
          backgroundColor: viewModel.selectedMinorBtn.value == "7"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "7"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "7"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '7';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '8',
          backgroundColor: viewModel.selectedMinorBtn.value == "8"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "8"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "8"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '8';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '9',
          backgroundColor: viewModel.selectedMinorBtn.value == "9"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "9"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "9"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '9';
                },
        ),
        SizedBox(
            width: Get.context!.isTablet && Get.context!.isLandscape ? 20 : 10),
        numberButtons(
          number: '10',
          backgroundColor: viewModel.selectedMinorBtn.value == "10"
              ? ThemeColors.fullLightPrimary
              : const Color(0xffe9e9e9),
          textColor: viewModel.selectedMinorBtn.value == "10"
              ? ThemeColors.white
              : Color(0xff00293a),
          onPressed: viewModel.selectedMinorBtn.value == "10"
              ? () {}
              : () {
                  viewModel.selectedMinorBtn.value = '10';
                },
        ),
      ],
    );
  }

  Widget numberButtons({
    required String number,
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            number,
            style: TextStyle(
              height: 1,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget continueBtn() {
    return CustomElevatedBtn(
      height: 50,
      width: 250,
      child: Text(
        "Continue".tr,
        style: TextStyle(
          color: ThemeColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: ThemeColors.fullLightPrimary,
      onPressed: () {
        GlobalVariables.datamodel.includeVideo!
            ? Get.to(() => WatchVideoView())
            : GlobalVariables.datamodel.includeTripDate!
                ? Get.to(() => TripDateView())
                : viewModel.participatingTypeBtn.value == "Minor(s)" ||
                        viewModel.participatingTypeBtn.value ==
                            "Adult + Minor(s)"
                    ? Get.to(() => MinorParticipantView())
                    : Get.to(() => AdultParticipantView());
      },
    );
  }
}
