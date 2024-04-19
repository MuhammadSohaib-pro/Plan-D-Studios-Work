import 'dart:convert';
import 'dart:io';

import 'package:html/dom.dart' as html;
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:kiosk/widgets/finalizeloading.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../libraries.dart';

class WaiverView extends StatefulWidget {
  WaiverView({super.key});

  @override
  State<WaiverView> createState() => _WaiverViewState();
}

class _WaiverViewState extends State<WaiverView> {
  XFile? image;
  final double inch = 1.0;
  @override
  void initState() {
    super.initState();
    viewModel.initialController.text = processviewModel.participatingTypeBtn ==
            "Minor(s)"
        ? "${minorparentviewModel.fNameController.text} ${minorparentviewModel.lNameController.text}"
        : "${adultparticipantviewModel.fNameController.text} ${adultparticipantviewModel.lNameController.text}";
    viewModel.htmlinitialController.text = processviewModel
                .participatingTypeBtn ==
            "Minor(s)"
        ? "${minorparentviewModel.fNameController.text.substring(0, 1)} ${minorparentviewModel.lNameController.text.substring(0, 1)}"
        : "${adultparticipantviewModel.fNameController.text.substring(0, 1)} ${adultparticipantviewModel.lNameController.text.substring(0, 1)}";
  }

  final WaiverViewModel viewModel = Get.put(WaiverViewModel());
  final MinorParticipantViewModel minorviewModel =
      Get.put(MinorParticipantViewModel());
  final AdultProcessViewModel processviewModel =
      Get.put(AdultProcessViewModel());
  final MinorParentViewModel minorparentviewModel =
      Get.put(MinorParentViewModel());
  final AdultParticipantViewModel adultparticipantviewModel =
      Get.put(AdultParticipantViewModel());
  String formattedDate = '';
  String formattedDate2 = '';

  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat('d MMMM,y').format(now);
    formattedDate2 = DateFormat('MMMM, d y').format(now);

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
          backgroundColor: const Color.fromARGB(255, 199, 204, 208),
          body: SafeArea(
            child: Obx(
              () => GlobalVariables.showLoader.value
                  ? LoaderView()
                  : viewModel.loading.value
                      ? FinalLoaderView()
                      : Column(children: [
                          Container(
                            color: ThemeColors.white,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.context!.isTablet &&
                                            Get.context!.isLandscape
                                        ? 235
                                        : 10),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Obx(() => (viewModel
                                                  .noOfSignatureHtml.value +
                                              viewModel
                                                  .buttonSignature.value) <=
                                          0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "When you are done reviewing the document, please click Finish button."
                                                    .tr,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            CustomElevatedBtn(
                                                child: Text('Finish'.tr),
                                                backgroundColor: ThemeColors
                                                    .fullLightPrimary,
                                                height: 35,
                                                width: 80,
                                                onPressed: () async {
                                                  bool result =
                                                      await InternetConnectionChecker()
                                                          .hasConnection;
                                                  if (result == true) {
                                                    print('Connected');
                                                    // store type in waivermodel
                                                    StorewaiverModel.instance
                                                        .updateData(
                                                            waivertype:
                                                                processviewModel
                                                                    .participatingTypeBtn
                                                                    .value);

                                                    almostdonetopsheet();
                                                  } else {
                                                    print('Not connected');
                                                    //Store localy
                                                    Get.defaultDialog(
                                                      titlePadding:
                                                          EdgeInsets.only(
                                                              top: 15),
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              30, 20, 30, 20),
                                                      title:
                                                          'Do you want to continue'
                                                              .tr,
                                                      middleText:
                                                          "You device has not connected to Internet"
                                                              .tr,
                                                      cancel: ElevatedButton(
                                                          style: ElevatedButton.styleFrom(
                                                              side: BorderSide(
                                                                  color: ThemeColors
                                                                      .primaryColor),
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .white,
                                                              foregroundColor:
                                                                  ThemeColors
                                                                      .primaryColor),
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text('No'.tr)),
                                                      confirm: ElevatedButton(
                                                          onPressed: () {
                                                            viewModel
                                                                .storedatalocal();
                                                          },
                                                          child:
                                                              Text('Yes'.tr)),
                                                    );
                                                  }
                                                })
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Container(
                                              width: 36.w,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'REQ*FIELDS LEFT'.tr,
                                                      style: TextStyle(
                                                          color: viewModel.sign
                                                                          .value ==
                                                                      true &&
                                                                  viewModel
                                                                          .initialsign
                                                                          .value ==
                                                                      true
                                                              ? ThemeColors
                                                                  .black1
                                                              : ThemeColors
                                                                  .errorRedColor),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  CircleAvatar(
                                                    radius: 15,
                                                    backgroundColor: ThemeColors
                                                        .errorRedColor,
                                                    child: Text(
                                                      "${viewModel.noOfSignatureHtml.value + viewModel.buttonSignature.value}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // viewModel.sign.value == true &&
                                            //         viewModel.initialsign.value == true
                                            //     ? SizedBox()
                                            //     : CircleAvatar(
                                            //         backgroundColor:
                                            //             ThemeColors.redColor,
                                            //         foregroundColor: ThemeColors.white,
                                            //         maxRadius: 14,
                                            //         child: Text('1'),
                                            //       ),
                                            Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  viewModel.zoomlevel.value +=
                                                      0.1;
                                                },
                                                child: Icon(Icons.zoom_in)),
                                            SizedBox(width: 5),
                                            GestureDetector(
                                                onTap: () {
                                                  viewModel.zoomlevel.value -=
                                                      0.1;
                                                },
                                                child: Icon(Icons.zoom_out)),
                                            SizedBox(width: 8),
                                            CustomElevatedBtn(
                                                child: Text('Start'.tr),
                                                backgroundColor: ThemeColors
                                                    .fullLightPrimary,
                                                height: 35,
                                                width: 80,
                                                onPressed: () async {
                                                  viewModel.pdfController
                                                      .nextPage();
                                                  if (viewModel.pageno.value ==
                                                      viewModel.pdfController
                                                          .pageNumber) {
                                                    viewModel.pageno.value =
                                                        viewModel.pdfController
                                                                .pageNumber -
                                                            1;
                                                  } else {
                                                    viewModel.pageno.value =
                                                        viewModel.pdfController
                                                            .pageNumber;
                                                  }
                                                  if ((viewModel
                                                              .noOfSignatureHtml
                                                              .value +
                                                          viewModel
                                                              .buttonSignature
                                                              .value) !=
                                                      0) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            new SnackBar(
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '*this field is required'
                                                                .tr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () =>
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .hideCurrentSnackBar(),
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Color(0xFFE67E7F),
                                                      margin: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height -
                                                            137,
                                                      ),
                                                    ));
                                                    return;
                                                  }
                                                })
                                          ],
                                        )),
                                )
                                //  Row(
                                //   children: [
                                //     doneReveiwingDocumentTxt(),
                                //     SizedBox(
                                //       width: 15,
                                //     ),
                                //     finishBtn(),
                                //   ],
                                // ),
                                ),
                          ),

                          // Center(
                          //   child: Image.network(
                          //     GlobalVariables.organization.photoUrl!,
                          //     height: 110,
                          //     width: 110,
                          //   ),
                          // ),
                          //..............
                          Expanded(
                            child:
                                //    Obx(
                                // () => viewModel.pageno.value ==
                                //         viewModel.pdfController.pageCount
                                //     ?
                                //     Padding(
                                //         padding: EdgeInsets.symmetric(
                                //             horizontal: Get.context!.isTablet &&
                                //                     Get.context!.isLandscape
                                //                 ? 150
                                //                 : 10),
                                //         child: Container(
                                //           height: 11 * 96,
                                //           width: 8.5 * 96,
                                //           color: ThemeColors.white,
                                //           child: Padding(
                                //             padding: EdgeInsets.all(38.sp),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.start,
                                //               children: [
                                //                 signaturetxt(),
                                //                 SizedBox(height: 30),
                                //                 iHaveCarefullyTxt(),
                                //                 SizedBox(height: 30),
                                //                 if (processviewModel
                                //                         .participatingTypeBtn ==
                                //                     'Minor(s)') ...[
                                //                   minorParticipantTxt(),
                                //                   SizedBox(height: 10),
                                //                   oneAndTwoMinorTxt(),
                                //                   SizedBox(height: 10),
                                //                   parentLegalGuardianTxt(),
                                //                   SizedBox(height: 30),
                                //                   inExcahngeForTxt(),
                                //                   SizedBox(height: 30),
                                //                 ],
                                //                 executedTxt(),
                                //                 SizedBox(height: 30),
                                //                 signBtn(),
                                //                 SizedBox(height: 30),
                                //                 parentLeagalNameTxt(),
                                //                 dateSignedTxt(),
                                //                 dateOfBirthTxt(),
                                //                 phoneNumberTxt(),
                                //                 addressTxt(),
                                //                 SizedBox(height: 30),
                                //                 DateSignedTxt2(),
                                //               ],
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     :
                                Container(
                                    child: SfPdfViewer.file(
                              viewModel.pdffile!,
                              pageLayoutMode: PdfPageLayoutMode.single,
                              controller: viewModel.pdfController,
                            )),
                            // )
                          ),
                          //............
                          // poweredByRow(),
                          // Expanded(
                          //   child: Container(
                          //     child: ListView(children: [
                          //       SizedBox(height: 20),
                          //       Center(
                          //         child: Image.network(
                          //           GlobalVariables.organization.photoUrl!,
                          //           height: 110,
                          //           width: 110,
                          //         ),
                          //       ),
                          //       Padding(
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: Get.context!.isTablet &&
                          //                       Get.context!.isLandscape
                          //                   ? 150
                          //                   : 10),
                          //           child: Container(
                          //               height: 80.h,
                          //               child: Obx(() => Transform.scale(
                          //                   scale: viewModel.zoomlevel.value,
                          //                   child: InteractiveViewer(
                          //                       panEnabled: false,
                          //                       boundaryMargin:
                          //                           EdgeInsets.all(80),
                          //                       minScale: 1,
                          //                       maxScale: 4,
                          //                       child: SfPdfViewer.network(
                          //                         viewModel.showpdf,
                          //                       )))))),
                          //       SizedBox(height: 10),
                          //       // Column(
                          //       //   children: [
                          //       //     Padding(
                          //       //       padding: EdgeInsets.symmetric(
                          //       //           horizontal:
                          //       //               Get.context!.isTablet &&
                          //       //                       Get.context!
                          //       //                           .isLandscape
                          //       //                   ? 150
                          //       //                   : 10),
                          //       //       child: Container(
                          //       //         height: 11 * 96,
                          //       //         width: 8.5 * 96,
                          //       //         color: ThemeColors.white,
                          //       //         child: Padding(
                          //       //           padding:
                          //       //               EdgeInsets.all(38.sp),
                          //       //           child: Column(
                          //       //             children: [
                          //       //               Text(
                          //       //                 GlobalVariables
                          //       //                     .organization
                          //       //                     .title!,
                          //       //                 style: TextStyle(
                          //       //                   fontSize: 16,
                          //       //                   fontWeight:
                          //       //                       FontWeight.bold,
                          //       //                   fontFamily:
                          //       //                       'Times New Roman',
                          //       //                 ),
                          //       //               ),
                          //       //               Text(
                          //       //                 StorewaiverModel
                          //       //                     .instance
                          //       //                     .waivername!,
                          //       //                 style: TextStyle(
                          //       //                   fontSize: 16,
                          //       //                   fontWeight:
                          //       //                       FontWeight.bold,
                          //       //                   fontFamily:
                          //       //                       'Times New Roman',
                          //       //                 ),
                          //       //               ),
                          //       //               // Html(
                          //       //               //   data: viewModel.pdf,
                          //       //               //   onAnchorTap: (url,
                          //       //               //       attributes,
                          //       //               //       element) {
                          //       //               //     initialsignatureDialog(
                          //       //               //         element);
                          //       //               //   },
                          //       //               // ),
                          //       //             ],
                          //       //           ),
                          //       //         ),
                          //       //       ),
                          //       //     ),
                          //       //     // bulletImage(),
                          //       //     // SizedBox(height: 30),
                          //       //     // covid19Txt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // inConsiderationTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // inherentTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // iAcknowledgeTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // initialBtn(),
                          //       //     // SizedBox(height: 30),
                          //       //     // pleaseInitialTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // expressAssumptionTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // asLawfulTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // releaseWaiverTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // includingClaimTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // releaseLiabilityTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // inExchangeTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // IndemnificationTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // iAgreetoTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // applicableLawTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // termsOfThisReleaseTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // severablityTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     // iAgreeThatTxt(),
                          //       //     // SizedBox(height: 30),
                          //       //     SizedBox(
                          //       //       height: 15,
                          //       //     ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: Get.context!.isTablet &&
                          //               Get.context!.isLandscape
                          //           ? 150
                          //           : 10),
                          //   child: Container(
                          //     height: 11 * 96,
                          //     width: 8.5 * 96,
                          //     color: ThemeColors.white,
                          //     child: Padding(
                          //       padding: EdgeInsets.all(38.sp),
                          //       child: Column(
                          //         crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //         children: [
                          //           signaturetxt(),
                          //           SizedBox(height: 30),
                          //           iHaveCarefullyTxt(),
                          //           SizedBox(height: 30),
                          //           if (processviewModel
                          //                   .participatingTypeBtn ==
                          //               'Minor(s)') ...[
                          //             minorParticipantTxt(),
                          //             SizedBox(height: 10),
                          //             oneAndTwoMinorTxt(),
                          //             SizedBox(height: 10),
                          //             parentLegalGuardianTxt(),
                          //             SizedBox(height: 30),
                          //             inExcahngeForTxt(),
                          //             SizedBox(height: 30),
                          //           ],
                          //           executedTxt(),
                          //           SizedBox(height: 30),
                          //           signBtn(),
                          //           SizedBox(height: 30),
                          //           parentLeagalNameTxt(),
                          //           dateSignedTxt(),
                          //           dateOfBirthTxt(),
                          //           phoneNumberTxt(),
                          //           addressTxt(),
                          //           SizedBox(height: 30),
                          //           DateSignedTxt2(),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //       SizedBox(height: 30),
                          //       poweredByRow(),
                          //       SizedBox(height: 30)
                          //     ]),
                          //   ),
                          // )
                        ]),
            ),
          )),
    );
  }

  Widget poweredByRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 10),
      child: Container(
        width: 8.5 * 96,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Powered By".tr),
            SizedBox(width: 10),
            SvgPicture.asset(
              'assets/svg/logo1.svg',
              height: 25,
            ),
            Spacer(),
            CustomElevatedBtn(
              child: Text('Reset'.tr),
              backgroundColor: ThemeColors.primaryColor,
              height: 35,
              width: 80,
              onPressed: () {
                Get.offAll(() => HomeUnlockView());
              },
            )
          ],
        ),
      ),
    );
  }

  Widget DateSignedTxt2() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Date Signed: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: formattedDate2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameOfAdditinionalMinor() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Name of additional minor(s) rider(s): ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text:
                  "Adian Nelson, Jasmon Nelson, Jason Nelson, Kenny Nelson, Linda Nelson, Greg Nelson."
                      .tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signBtn4() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 45,
          width: 100,
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Text(
            "SIGN".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ThemeColors.white,
              fontFamily: 'Times New Roman',
            ),
          ),
        ),
      ),
    );
  }

  Widget signatureOfParentTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "Signature of parent, guardian and or spouse:".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget signBtn3() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 45,
          width: 100,
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Text(
            "SIGN".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ThemeColors.white,
              fontFamily: 'Times New Roman',
            ),
          ),
        ),
      ),
    );
  }

  Widget SignautreOftheRiderTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "Signature of Rider (spouse must sign for themselves):".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget iWeTheUnderSignedTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I/we the undersigned have read the foregoing statement carefully before signing and do understand its warnings and assumption of risks."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget iForMyself() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I, for myself, and or on behalf of my child or legal ward, have been fully warned and advised by {{Company_Name}} that we should wear properly fitted wetsuit bottoms, or clothing that provides equivalent protection, while riding or being around Wave Runners and Jet Skis in order to protect against injuries caused by water forced into body cavities as a result of falling into the water or being near the jet thrust nozzle. Injuries include water forced into the rectum or vagina causing severe internal injuries or death. I understand that by not wearing wetsuit bottoms or equivalent clothing, I will be going against manufacturers' requirements and putting myself at risk for injuries. I realize that I may be subject to injury from this activity and that no form of replanning can remove all danger Against the advice Of {{Company_Name}}, we are declining this critical safety precaution."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget protectiveWetSuitTxt() {
    return Center(
      child: Text(
        "PROTECTIVE WETSUIT REFUSAL AGREEMENT".tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget signBtn2() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 45,
          width: 100,
          alignment: Alignment.center,
          color: Colors.blueAccent,
          child: Text(
            "SIGN".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ThemeColors.white,
              fontFamily: 'Times New Roman',
            ),
          ),
        ),
      ),
    );
  }

  Widget dateTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: RichText(
        text: TextSpan(
          text: "Date: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: "May 18th, 2023",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iTheUnderSignedTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I, the undersigned, have been fully warned and advised by {{Company_Name}} (hereinafter collectively referred to as {{Company_Name}}), that I should wear a properly fitted and secured DOT and/or or SNELL certified helmet while riding or being around all-terrain vehicles (\"ATV's\") or off-highway vehicles (\*OHV's\") (whether on the premises or off of the {{Company_Name}}'s premises) in order to potentially reduce the severity of an injury and/or to possibly prevent my death from occurring as the result of a fall or any other occurrence associated with this activity. I understand that by not wearing a helmet, I will be going against manufacturers' requirements and putting myself at an increased risk for injuries, and against the advice of {{Company_Name}} and numerous court cases I am refusing this critical safety precaution. _ also understand that minors are not allowed to refuse protective headgear and I cannot sign on their behalt to waive the requirement. 1, the undersigned, have read the foregoing statement carefully before signing and do understand its warning.",
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget protectiveHeadGearTxt() {
    return Center(
      child: Text(
        "PROTECTIVE RIDING HEADGEAR REFUSAL AGREEMENT".tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget idTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: RichText(
        text: TextSpan(
          text: "ID: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: "minorparticipantviewModel.".tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addressTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Address: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: processviewModel.participatingTypeBtn == "Minor(s)"
                  ? minorparentviewModel.addressController.text
                  : adultparticipantviewModel.addressController.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneNumberTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Phone Number: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: processviewModel.participatingTypeBtn == "Minor(s)"
                  ? minorparentviewModel.phoneController.text
                  : adultparticipantviewModel.phoneController.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateOfBirthTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Date of Birth: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: processviewModel.participatingTypeBtn == "Minor(s)"
                  ? minorparentviewModel.dateController.text
                  : adultparticipantviewModel.dateController.text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateSignedTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: "Date Signed: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: formattedDate2,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget parentLeagalNameTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: RichText(
        text: TextSpan(
          text: processviewModel.participatingTypeBtn == "Minor(s)"
              ? "Parent/Legal Guardian Name: ".tr
              : "Name: ".tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeColors.black1,
            fontFamily: 'Times New Roman',
          ),
          children: [
            TextSpan(
              text: processviewModel.participatingTypeBtn == "Minor(s)"
                  ? "${minorparentviewModel.fNameController.text} ${minorparentviewModel.lNameController.text}"
                  : "${adultparticipantviewModel.fNameController.text} ${adultparticipantviewModel.lNameController.text}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: ThemeColors.black1,
                fontFamily: 'Times New Roman',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget signBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Container(
        width: Get.width * .65,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Set the border color here
            width: 1.0, // Set the border width
          ),
        ),
        child: Row(
          children: [
            Obx(
              () => viewModel.initialTxtFormFieldValue.value.isNotEmpty
                  ? Container(
                      height: 60,
                      width: Get.width * 0.5,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        viewModel.initialController.text,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            fontStyle: FontStyle.italic
                            // fontFamily: 'Snell Rounded',
                            ),
                      ),
                    )
                  : viewModel.imageBytes.value.length == 0
                      ? InkWell(
                          onTap: () {
                            signatureDialog();
                          },
                          child: Container(
                              width: 110,
                              padding: EdgeInsets.all(14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xFF06a7ed),
                                  borderRadius: BorderRadius.circular(2)),
                              child: Column(
                                children: [
                                  Text(
                                    "SIGN".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ThemeColors.white,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/sign-logo.png',
                                    height: 20,
                                  ),
                                ],
                              )))
                      : Container(
                          height: 70,
                          width: Get.width * 0.6,
                          decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            image: DecorationImage(
                              image: MemoryImage(viewModel.imageBytes.value),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget executedTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Text(
        "Executed this".tr + "  ${formattedDate}",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget inExcahngeForTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Text(
        "In exchange for the minor child being permitted to participate in the Activity, I accept and agree to the full contents of this Release. I have the authority to sign on behalf of the minor child and to make decisions for the minor child regarding this Activity."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget parentLegalGuardianTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Text(
        "Parent or Legal Guardian".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget oneAndTwoMinorTxt() {
    return Container(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: minorviewModel.totalMinors,
          itemBuilder: (Context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  // horizontal: Get.context!.isTablet && Get.context!.isLandscape
                  //     ? 150
                  //     : 20
                  ),
              child: Text(
                "#${index + 1}: ${minorviewModel.controllerList[index].fNameController.text} ${minorviewModel.controllerList[index].lNameController.text}",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Times New Roman',
                ),
              ),
            );
          }),
    );
  }

  Widget minorParticipantTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Text(
        "Minor(s) Participant".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget iHaveCarefullyTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          // horizontal:
          //     Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20
          ),
      child: Text(
        "I have carefully read and fully understand all of the provisions of this Release and am freely, knowingly, and voluntarily entering into this Release. In the event of my death or disability, the terms of this Release will be binding on my estate, and my personal representative, executor, administrator or guardian will be obligated to enforce them."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget signaturetxt() {
    return Center(
      child: Text(
        "SIGNATURE PAGE".tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget iAgreeThatTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I agree that if any portion of this release is found to be invalid or unenforceable, then the remainder will continue in full force and effect."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget severablityTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "7. SEVERABILITY:".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget termsOfThisReleaseTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "The terms of this release shall be governed by and construed in accordance with the laws of the State of [State of Activity]."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget applicableLawTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "6. APPLICABLE LAW:".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget iAgreetoTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I agree to indemnify Released Parties against any and all claims, actions, lawsuits, damages and judgments, including claims for their own negligence, arising from my participation in the Activity. I also agree to indemnify and hold harmless the Released Parties against any and all claims for my own negligence. I will reimburse the Released Parties for any damages, reasonable settlements, and defense costs, including attorney’s fees, that the Released Parties incur because of any such claims made against them."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget IndemnificationTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "5. INDEMNIFICATION HOLD HARMLESS:".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget inExchangeTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "In exchange for my voluntary participation in the Activity, I hereby release [Activity Provider Company Name], its employees, agents, contractors, officers, directors, affiliated partners, and equipment providers (the “Released Parties”)  from all liabilities, causes of action, claims and demands that arise from any injury, death, loss or harm, that may occur to me or any other person or any property during the Activity or related to the activity, including during transportation to or from the Activity, whether caused by negligence of the Released Parties or otherwise. I agree not to make any claim against the Released Parties for any bodily injuries, death, or property damage that occur during the Activity or related in any way to the Activity."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget releaseLiabilityTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "4. RELEASE OF LIABILITY:".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget includingClaimTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "Including for Claims of NEGLIGENCE.I hereby voluntarily release, forever discharge, and agree to indemnify and hold harmless Huck from any and all claims, demands, or causes of action, which are in any way connected with my participation in the Huck activities or my use of Huck’s equipment or facilities, including any such claims which allege negligent acts or omissions of Huck. I hereby knowingly assume the risk of injury, harm, and loss associated with the Activity, including any injury, harm, and loss caused by the negligence, fault or conduct of any kind on the part of the Released Parties."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget releaseWaiverTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "3. Release and Waiver of Rights".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget asLawfulTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "As lawful consideration for my being allowed to participate in the activities offered through the A.A.C., I expressly agree on behalf of myself and any of the children for which I am responsible, to accept and assume all the risks existing in the A.A.C. activities I/we are attending. My/our participation in this A.A.C. activity is purely voluntary, and I/we elect to participate in spite of the risks. I/we expressly agree that this Participant Release of Liability, Waiver of Claims, Assumption of Risks and Indemnity Agreement is contractual in nature, supported by Colorado law and that I/we are signing it of my/our own free will."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget expressAssumptionTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "2. Express Assumption of Risk.".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget pleaseInitialTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "Please Initial".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget initialBtn(html.Element element) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                Get.context!.isTablet && Get.context!.isLandscape ? 150 : 0),
        child: InkWell(
          onTap: () {
            initialsignatureDialog(element);
          },
          child: Container(
            height: 45,
            width: 100,
            alignment: Alignment.center,
            color: Colors.blueAccent,
            child: Text(
              "INITIAL".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ThemeColors.white,
                fontFamily: 'Times New Roman',
              ),
            ),
          ),
        ));
  }

  Widget initialTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        viewModel.initialController.text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 25,
          fontFamily: 'Snell Rounded',
        ),
      ),
    );
  }

  Future<dynamic> signatureDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Add your initials".tr,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      children: [
                        CustomElevatedBtn(
                          height: 40,
                          width: 80,
                          onPressed: viewModel.SelectedBtn.value == 'Type'
                              ? () {}
                              : () {
                                  viewModel.SelectedBtn.value = 'Type';
                                },
                          backgroundColor: viewModel.SelectedBtn.value == 'Type'
                              ? Colors.blueAccent
                              : ThemeColors.grey2,
                          foregroundColor: viewModel.SelectedBtn.value == 'Type'
                              ? ThemeColors.white
                              : ThemeColors.black1,
                          child: Text(
                            "Type it in".tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomElevatedBtn(
                          height: 40,
                          width: 100,
                          onPressed: viewModel.SelectedBtn.value == 'Draw'
                              ? () {}
                              : () {
                                  viewModel.SelectedBtn.value = 'Draw';
                                },
                          backgroundColor: viewModel.SelectedBtn.value == 'Draw'
                              ? Colors.blueAccent
                              : ThemeColors.grey2,
                          foregroundColor: viewModel.SelectedBtn.value == 'Draw'
                              ? ThemeColors.white
                              : ThemeColors.black1,
                          child: Text(
                            "Draw It in".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    viewModel.SelectedBtn.value == 'Type'
                        ? Column(
                            children: [
                              CustomTextField10(
                                controller: viewModel.initialController,
                                fillColor: ThemeColors.white,
                                textColor: ThemeColors.primaryColor,
                                showCursor: false,
                                // hintText: processviewModel
                                //             .participatingTypeBtn ==
                                //         "Minor(s)"
                                //     ? "${minorparentviewModel.fNameController.text} ${minorparentviewModel.lNameController.text}"
                                //     : "${adultparticipantviewModel.fNameController.text} ${adultparticipantviewModel.lNameController.text}",
                                maxLines: 2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "I understand this is a legal representation of my initials."
                                    .tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors.grey8,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: SfSignaturePad(
                                    key: viewModel.signatureGlobalKey,
                                    backgroundColor: Colors.transparent,
                                    strokeColor: Colors.black,
                                    minimumStrokeWidth: 1.0,
                                    maximumStrokeWidth: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "By signing this document with an electronic signature, I agree that such signature will be as valid as handwritten signatures and considered originals to the extent allowed by applicable law."
                                    .tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors.grey8,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedBtn(
                          height: 40,
                          width: 90,
                          onPressed: () async {
                            DateFormat dateformat =
                                DateFormat("dd-MM-yyyy HH:mm:ss");
                            viewModel.outputdate = dateformat.format(now);
                            if (viewModel.SelectedBtn.value == "Type") {
                              viewModel.sign.value = true;
                              viewModel.initialTxtFormFieldValue.value =
                                  viewModel.initialController.text;
                              viewModel.buttonSignature.value =
                                  viewModel.buttonSignature.value - 1;
                              Get.back();
                            } else {
                              viewModel.handleSaveButtonPressed();
                              viewModel.buttonSignature.value =
                                  viewModel.buttonSignature.value - 1;
                              Get.back();
                            }
                          },
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: ThemeColors.white,
                          child: Text(
                            "Insert".tr,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> initialsignatureDialog(html.Element? element) {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Add your initials".tr,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Wrap(
                      children: [
                        CustomElevatedBtn(
                          height: 40,
                          width: 80,
                          onPressed: viewModel.SelectedBtn.value == 'Type'
                              ? () {}
                              : () {
                                  viewModel.SelectedBtn.value = 'Type';
                                },
                          backgroundColor: viewModel.SelectedBtn.value == 'Type'
                              ? Colors.blueAccent
                              : ThemeColors.grey2,
                          foregroundColor: viewModel.SelectedBtn.value == 'Type'
                              ? ThemeColors.white
                              : ThemeColors.black1,
                          child: Text(
                            "Type it in".tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomElevatedBtn(
                          height: 40,
                          width: 100,
                          onPressed: viewModel.SelectedBtn.value == 'Draw'
                              ? () {}
                              : () {
                                  viewModel.SelectedBtn.value = 'Draw';
                                },
                          backgroundColor: viewModel.SelectedBtn.value == 'Draw'
                              ? Colors.blueAccent
                              : ThemeColors.grey2,
                          foregroundColor: viewModel.SelectedBtn.value == 'Draw'
                              ? ThemeColors.white
                              : ThemeColors.black1,
                          child: Text(
                            "Draw It in",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    viewModel.SelectedBtn.value == 'Type'
                        ? Column(
                            children: [
                              CustomTextField10(
                                controller: viewModel.htmlinitialController,
                                fillColor: ThemeColors.white,
                                textColor: ThemeColors.primaryColor,
                                readOnly: true,
                                showCursor: false,
                                // hintText: processviewModel
                                //             .participatingTypeBtn ==
                                //         "Minor(s)"
                                //     ? "${minorparentviewModel.fNameController.text.substring(0, 1)} ${minorparentviewModel.lNameController.text.substring(0, 1)}"
                                //     : "${adultparticipantviewModel.fNameController.text.substring(0, 1)} ${adultparticipantviewModel.lNameController.text.substring(0, 1)}",
                                maxLines: 2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "I understand this is a legal representation of my initials."
                                    .tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors.grey8,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: SfSignaturePad(
                                    key: viewModel.signatureGlobalKey,
                                    backgroundColor: Colors.transparent,
                                    strokeColor: Colors.black,
                                    minimumStrokeWidth: 1.0,
                                    maximumStrokeWidth: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "By signing this document with an electronic signature, I agree that such signature will be as valid as handwritten signatures and considered originals to the extent allowed by applicable law."
                                    .tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColors.grey8,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomElevatedBtn(
                          height: 40,
                          width: 90,
                          onPressed: () async {
                            if (viewModel.SelectedBtn.value == "Type") {
                              print(viewModel.htmlinitialController.text);
                              String data =
                                  viewModel.htmlinitialController.text.trim();
                              print(element?.localName);
                              element?.parent?.innerHtml = """ 
                                  <div style="background-color:#f6F7F8;height:50px; width:80px">
                                  <div style="padding-top: 16px; padding-bottom:16px; font-size:21;text-align:center; font-family: Roundhand Bold CE; font-weight: bold;font-style:italic">
                               $data
                                      </div></div>""";
                              // viewModel.htmlinitialController.clear();
                              viewModel.noOfSignatureHtml.value =
                                  viewModel.noOfSignatureHtml.value - 1;
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              final data = await viewModel
                                  .signatureGlobalKey.currentState
                                  ?.toImage(pixelRatio: 3.0);
                              final bytes = await data?.toByteData(
                                  format: ui.ImageByteFormat.png);
                              Uint8List imageBytes =
                                  bytes!.buffer.asUint8List();
                              final image = base64Encode(imageBytes);
                              element?.parent?.innerHtml = """
                                   <div style="background-color:#f6F7F8;height:50px; width:80px">
                                  <img src='data:image/png;base64,${image}'style=\"width: 80px;height:50px\"/></div>""";

                              Navigator.pop(context);
                              viewModel.noOfSignatureHtml.value =
                                  viewModel.noOfSignatureHtml.value - 1;

                              setState(() {});
                            }
                          },
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: ThemeColors.white,
                          child: Text(
                            "Insert".tr,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget iAcknowledgeTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "I acknowledge that I am participating in a social/camping/climbing type event for which an A.A.C. ‘Section Leader’ may have had some loose organizational role. I specifically acknowledge that A.A.C. will not provide any social monitoring, climbing or camping or other type of instruction, supervision, oversight, or safety role and that I am completely responsible for myself, my equipment, my choices and all of the risks (whatever they might be) associated with this event. I acknowledge that A.A.C. has no duty to enumerate those risks to me and that I am choosing to participate in this event knowing that I am completely responsible for my own safety. I specifically acknowledge that, in the event I choose to consume alcohol during this event, I will bear complete responsibility for myself and for any damages I may cause to myself and my belongings, to A.A.C., to A.A.C.’s (owned, permitted or leased) property or to other guests and their property.\n\nI fully understand that by signing this Participant Release of Liability, Waiver of Claims, Assumption of Risks and Indemnity Agreement, I acknowledge that I AM ULTIMATELY RESPONSIBLE for my own safety during my participation in this event and at no time can make any claim for any reason against the American Alpine Club or our partners, sponsors, contractors, guides, or volunteers."
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget inherentTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "1. Inherent Risks.".tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget inConsiderationTxt() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
      child: Text(
        "In consideration of the services of the American Alpine Club, its respective agents, owners, lessors, shareholders, officers, volunteers, participants, employees, and all other persons or entities acting in any capacity on its behalf (hereinafter collectively referred to as A.A.C.@), I hereby agree to acknowledge and discharge A.A.C. on behalf of myself, my parents, my children, my heirs, all of my family members, assigns, administrators, wards, personal representatives and estate as follows:"
            .tr,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Times New Roman',
        ),
      ),
    );
  }

  Widget covid19Txt() {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                Get.context!.isTablet && Get.context!.isLandscape ? 150 : 20),
        child: Center(
          child: Text(
            "COVID-19 SAFETY ACKNOWLEDGMENT LIABILITY WAIVER AND RELEASE OF CLAIMS"
                .tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Times New Roman',
            ),
          ),
        ));
  }

  Widget bulletImage() {
    return Center(
      child: Image.asset(
        "assets/images/bullet.png",
        height: 110,
        width: 110,
      ),
    );
  }

  Widget finishBtn() {
    return CustomElevatedBtn(
      backgroundColor: ThemeColors.fullLightPrimary,
      height: 40,
      width: 130,
      onPressed: () async {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          print('Connected');
          //Api Call
        } else {
          print('Not connected');
          //Store localy
          Get.defaultDialog(
            titlePadding: EdgeInsets.only(top: 15),
            contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            title: 'Do you want to continue'.tr,
            middleText: "You device has not connected to Internet".tr,
            cancel: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: ThemeColors.primaryColor),
                    backgroundColor: ThemeColors.white,
                    foregroundColor: ThemeColors.primaryColor),
                onPressed: () {
                  Get.back();
                },
                child: Text('No'.tr)),
            confirm: ElevatedButton(onPressed: () {}, child: Text('Yes'.tr)),
          );
        }
      },
      foregroundColor: ThemeColors.white,
      child: Text(
        "Finish".tr,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget doneReveiwingDocumentTxt() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Text(
          "When you are done reveiwing the document, please click Finish button."
              .tr,
          maxLines: 3,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  almostdonetopsheet() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            // height: 150,

            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Almost done.'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  RichText(
                      text: TextSpan(
                          text: 'I agree to be legally bound by this '.tr,
                          style: TextStyle(
                              color: ThemeColors.black2, fontSize: 15),
                          children: [
                        TextSpan(
                            text:
                                'Documents Electronic Record and Signature Disclosure'
                                    .tr,
                            style: TextStyle(color: ThemeColors.green1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('document');
                              }),
                        TextSpan(text: ' and the Otter Waiver’s '.tr),
                        TextSpan(
                            text: 'terms of service.'.tr,
                            style: TextStyle(color: ThemeColors.green1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                CommonFunctions.termserviceurl();
                              })
                      ])),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.defaultDialog(
                              titlePadding: EdgeInsets.only(top: 15),
                              contentPadding:
                                  EdgeInsets.fromLTRB(30, 20, 30, 20),
                              title: '',
                              middleText:
                                  "Are you sure you want to decline signing this document."
                                      .tr,
                              cancel: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          color: ThemeColors.primaryColor),
                                      backgroundColor: ThemeColors.white,
                                      foregroundColor:
                                          ThemeColors.primaryColor),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('No'.tr)),
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    Get.offAll(() => HomeUnlockView());
                                  },
                                  child: Text('Yes'.tr)),
                            );
                          },
                          child: Text(
                            'I decline'.tr,
                            style: TextStyle(color: ThemeColors.black1),
                          )),
                      SizedBox(
                        width: 8,
                      ),
                      CustomElevatedBtn(
                          child: Text('I agree'.tr),
                          backgroundColor: ThemeColors.fullLightPrimary,
                          height: 35,
                          width: 80,
                          onPressed: () async {
                            Get.back();
                            imagecapture();
                            print(StorewaiverModel
                                .instance.singleLinequestion?.questionid);
                            viewModel.createParticipant();
                          }),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  imagecapture() async {
    if (viewModel.photocontroller == null ||
        !viewModel.photocontroller!.value.isInitialized) {
      await viewModel.initCamera();
    }
    if (viewModel.photocontroller!.value.isTakingPicture) {
      return null;
    }
    try {
      await viewModel.photocontroller!.setFlashMode(FlashMode.off);
      image = await viewModel.photocontroller!.takePicture();
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
    print(Image.file(File(image!.path)));
  }

  dateconvert() {
    DateTime originalDate = DateTime.parse(DateTime.now().toString());

    // originalDate = originalDate.toUtc();

    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(originalDate);

    print(formattedDate);
  }
}
