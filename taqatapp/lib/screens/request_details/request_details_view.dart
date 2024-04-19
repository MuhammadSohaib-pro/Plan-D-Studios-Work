import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/message/message_view.dart';
import 'package:taqat/screens/request_details/request_details_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class RequestDetailsView extends StatelessWidget {
  RequestDetailsView({super.key});

  final RequestDetailsViewModel viewModel = Get.put(RequestDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ScrollableColumn(
              children: [
                statusContainer(),
                sponsorContainer(),
                laborContainer(),
                bankDetails(),
                taqatAndSanadBtn(),
                taqatData(),
                sanadData(),
                Spacer(),
                doneBtn(),
                SizedBox(height: 30),
              ],
            ),
          ),
          LoaderView()
        ],
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: Text(
        'Request Details'.tr,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Color(0xff1A1D1E),
        ),
      ),
      centerTitle: true,
    );
  }

  Widget statusContainer() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        margin: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Request Status'.tr,
              style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameTxt('${'Status'.tr} : ', Colors.black),
                nameTxt(
                    viewModel.statusStr.value,
                    viewModel.status.value == 1
                        ? Colors.green
                        : ThemeColors.red),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sponsorContainer() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Sponsor Details'.tr,
              style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                // image(viewModel.sponsorModel.value.sponsorId ?? ''),
                Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ThemeColors.grey4.withOpacity(.5)),
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameTxt(
                        '${viewModel.sponsorModel.value.firstName ?? ''} ${viewModel.sponsorModel.value.lastName ?? ''}',
                        Colors.black),
                    SizedBox(height: 5),
                    emailTxt('${viewModel.sponsorModel.value.email ?? ''}'),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                whatsAppBtn(
                    icon: Icons.messenger_outline,
                    title: 'Chat'.tr,
                    onTap: () {
                      Get.to(() => MessageView(), arguments: {
                        'userId': '${viewModel.sponsorModel.value.id}'
                      });
                    }),
                SizedBox(width: 15),
                whatsAppBtn(icon: Icons.call_outlined, title: 'Call'.tr),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget whatsAppBtn(
      {GestureTapCallback? onTap,
      required IconData icon,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff25D366),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset("assets/images/whatsapp.png"),
            Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xffFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget laborContainer() {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Labor Details'.tr,
              style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                // image(viewModel.laborModel.value.laborPhoto ?? ''),
                Container(
                  height: 84,
                  width: 84,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ThemeColors.grey4.withOpacity(.5)),
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    nameTxt(viewModel.laborModel.value.fullname ?? '',
                        Colors.black),
                    SizedBox(height: 5),
                    emailTxt(
                        '${viewModel.title.value}, ${viewModel.laborModel.value.nationality ?? ''}'),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bankDetails() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Bank Details'.tr,
                style: TextStyle(
                    color: ThemeColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: 10),
            Text(
                '${'Taqat Bank Name'.tr} : ${viewModel.bankInfoModel.value.taqatBankName ?? 'xxxx-xxxx-xxxx-xxxx'}'),
            SizedBox(height: 10),
            Text(
                '${'Taqat Bank Account'.tr} : ${viewModel.bankInfoModel.value.taqatBankAccount ?? 'xxxx-xxxx-xxxx-xxxx'}'),
            SizedBox(height: 10),
            Text(
                '${'WhatsApp Number'.tr} : ${viewModel.bankInfoModel.value.taqatWhatsapp ?? 'xxxx-xxxx-xxxx-xxxx'}'),
            SizedBox(height: 10),
            Text(
              'Note : Please deposit above mentioned fee through any medium and upload the receipt'
                  .tr,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget taqatAndSanadBtn() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomButton8(
                  text: "Taqat".tr,
                  onPressed: () {
                    viewModel.selectedBtn.value = "taqat";
                  },
                  textColor: viewModel.selectedBtn.value == "taqat"
                      ? Colors.white
                      : Colors.black,
                  backgroundColor: viewModel.selectedBtn.value == "taqat"
                      ? Color(0xff0C8A7B)
                      : Color(0xffD9D9D9),
                ),
              ),
            ),
            viewModel.flag.value == true
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomButton8(
                        text: "Sanad".tr,
                        backgroundColor: viewModel.selectedBtn.value == "sanad"
                            ? Color(0xff0C8A7B)
                            : Color(0xffD9D9D9),
                        textColor: viewModel.selectedBtn.value == "sanad"
                            ? Colors.white
                            : Colors.black,
                        onPressed: () {
                          viewModel.selectedBtn.value = "sanad";
                        },
                      ),
                    ),
                  )
                : Padding(padding: EdgeInsets.all(0)),
          ],
        ),
      ),
    );
  }

///////   Taqat   Data   //////

  Widget taqatData() {
    return Obx(() => viewModel.selectedBtn.value == "taqat"
        ? Container(
            child: Column(
              children: [
                taqatInvoiceContainer(),
                downloadTaqatInvoiceBtn(),
                taqatReceiptContainer()
              ],
            ),
          )
        : SizedBox());
  }

  Widget taqatInvoiceContainer() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Invoice Details'.tr,
              style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${'Ownership Fee'.tr}'),
                          Text('${'Taqat Tax'.tr}'),
                          Text(
                            '${'Total Amount'.tr}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                              '${viewModel.invoiceModel.value.subtotal?.toStringAsFixed(1) ?? ''} ${'OMR'.tr}'),
                          Text(
                              '${viewModel.invoiceModel.value.taqatPayment ?? 0} ${'OMR'.tr}'),
                          Text(
                            ' ${viewModel.invoiceModel.value.totalAmount ?? 0} ${'OMR'.tr}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget downloadTaqatInvoiceBtn() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: CustomButton8(
        text: "Download Taqat Invoice".tr,
        backgroundColor: ThemeColors.mainColor,
        textColor: ThemeColors.bgColor,
        onPressed: () {
          viewModel.invoiceModel.value.invoiceLink!.isNotEmpty
              ? FileDownloader.downloadFile(
                  url: '${viewModel.invoiceModel.value.invoiceLink}',
                  onProgress: (fileName, progress) {
                    GlobalVariables.showLoader.value = true;
                    print("$progress");
                  },
                  onDownloadCompleted: (String path) {
                    print('FILE DOWNLOADED TO PATH: $path');
                    GlobalVariables.showLoader.value = false;
                    GetxHelper.showSnackBar(
                        title: "Success",
                        message: "File Downloaded Successfully");
                  },
                  onDownloadError: (String error) {
                    print('DOWNLOAD ERROR: $error');
                    GlobalVariables.showLoader.value = false;
                    GetxHelper.showSnackBar(
                        title: "Error", message: "File Not Found! Try Again");
                  })
              : () {
                  GetxHelper.showSnackBar(
                      title: "Error", message: "File Not Found");
                };
        },
      ),
    );
  }

  Widget taqatReceiptContainer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          uploadReceiptTxt(title: 'Upload Taqat Receipt'.tr),
          taqatDocument(),
        ],
      ),
    );
  }

///////   Sanad   Data   //////

  Widget sanadData() {
    return Obx(() => viewModel.selectedBtn.value == "sanad"
        ? Container(
            child: Column(
              children: [
                sanadInvoiceContainer(),
                downloadSanadInvoice(),
                sanadReceiptContainer(),
              ],
            ),
          )
        : SizedBox());
  }

  Widget sanadInvoiceContainer() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Invoice Details'.tr,
              style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            viewModel.sanadModelList.length > 0
                ? Container(
                    height: 150,
                    margin: EdgeInsets.only(top: 15),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.sanadModelList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${'${'Service Name'.tr} : '}'),
                                Text('${'${'Price'.tr} : '}'),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${viewModel.sanadModelList[index].name ?? ''}'),
                                Text(
                                  ' ${viewModel.sanadModelList[index].rate ?? 0} ${'OMR'.tr}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  )
                : SizedBox(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'${'Grand Total'.tr} : '}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      '${((viewModel.subTotalModel.value.subtotal ?? 0) * 0.05) + (viewModel.subTotalModel.value.subtotal ?? 0)} ${'OMR'.tr}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget downloadSanadInvoice() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: CustomButton8(
        text: "Download Sanad Invoice".tr,
        backgroundColor: ThemeColors.mainColor,
        textColor: ThemeColors.bgColor,
        onPressed: () {
          // print('${Urls.sanadPdfLink}${viewModel.subTotalModel.value.invoiceLink}');
          viewModel.subTotalModel.value.invoiceLink!.isNotEmpty
              ? FileDownloader.downloadFile(
                  url:
                      '${Urls.sanadPdfLink}${viewModel.subTotalModel.value.invoiceLink}',
                  onProgress: (fileName, progress) {
                    GlobalVariables.showLoader.value = true;
                    print("$progress");
                  },
                  onDownloadCompleted: (String path) {
                    print('FILE DOWNLOADED TO PATH: $path');
                    GlobalVariables.showLoader.value = false;
                    GetxHelper.showSnackBar(
                        title: "Success",
                        message: "File Downloaded Successfully");
                  },
                  onDownloadError: (String error) {
                    print('DOWNLOAD ERROR: $error');
                    GlobalVariables.showLoader.value = false;
                    GetxHelper.showSnackBar(
                        title: "Error", message: "File Not Found! Try Again");
                  })
              : () {
                  GetxHelper.showSnackBar(
                      title: "Error", message: "File Not Found");
                };
        },
      ),
    );
  }

  Widget sanadReceiptContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          uploadReceiptTxt(title: 'Upload Sanad Receipt'.tr),
          sanadDocument(),
        ],
      ),
    );
  }

  Widget uploadReceiptTxt({required String title}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget taqatDocument() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: documentSelectionItem(
          title: 'Taqat Payment Receipt'.tr,
          file: viewModel.taqatPaymentReceipt,
          onTap: (viewModel.taqatPaymentReceipt.value.path == '')
              ? () {
                  selectImageBottomSheet(type: viewModel.type.value);
                }
              : null,
        ),
      ),
    );
  }

  Widget sanadDocument() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: documentSelectionItem(
          title: 'Sanad Payment Receipt'.tr,
          file: viewModel.sanadPaymentReceipt,
          onTap: (viewModel.sanadPaymentReceipt.value.path == '')
              ? () {
                  selectImageBottomSheet(type: viewModel.type.value);
                }
              : null,
        ),
      ),
    );
  }

  Widget documentSelectionItem(
      {required GestureTapCallback? onTap,
      required String title,
      required Rx<File> file}) {
    return Container(
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
                      ],
                    ),
                    (file.value.path == "")
                        ? Icon(
                            Icons.add,
                            color: ThemeColors.mainColor,
                          )
                        : SizedBox(),
                  ],
                ),
                file.value.path != ''
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            file.value,
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

  selectImageBottomSheet({String type = 'taqat'}) {
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
                  viewModel.imgFromGallery(type: type);
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: 'Camera'.tr,
                icon: CupertinoIcons.photo_camera,
                onTap: () {
                  viewModel.imgFromCamera(type: type);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget doneBtn() {
    return CustomButton8(
      text: "Done".tr,
      onPressed: () async {
        // Get.to(() => PaymentDoneView());
        Get.back();
      },
      textColor: Colors.black,
      backgroundColor: Color(0xffEFF2F1),
    );
  }

  Widget image(String url) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(
        height: 84,
        width: 84,
        imageUrl: Urls.imageUrl + url,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage('assets/images/default_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2.0),
          );
        },
      ),
    );
  }

  Widget nameTxt(String name, Color clr) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: clr,
      ),
    );
  }

  Widget emailTxt(String email) {
    return Text(
      email,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xffAAAAAA),
      ),
    );
  }
}
