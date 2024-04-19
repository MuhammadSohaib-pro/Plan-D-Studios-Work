import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/errors.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/dashboard/user_model.dart';
import 'package:taqat/screens/pending_invoice/invoice_model.dart';
import 'package:taqat/screens/request_details/bank_info_model.dart';
import 'package:taqat/screens/request_details/sanad_data_model.dart';
import 'package:taqat/screens/search/search_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailsViewModel extends GetxController {
  String id = '0';
  RxString title = ''.obs;
  RxBool flag = false.obs;
  RxString type = 'taqat'.obs;
  Rx<UserModel> sponsorModel = UserModel().obs;
  Rx<BankInfoModel> bankInfoModel = BankInfoModel().obs;
  Rx<InvoiceModel> invoiceModel = InvoiceModel().obs;
  List<SanadDataModel> sanadModelList = <SanadDataModel>[].obs;
  Rx<SubTotalDataModel> subTotalModel = SubTotalDataModel().obs;
  Rx<SearchModel> laborModel = SearchModel().obs;
  Rx<File> taqatPaymentReceipt = File('').obs;
  Rx<File> sanadPaymentReceipt = File('').obs;
  RxInt status = 0.obs;
  RxString statusStr = "".obs;
  RxString selectedBtn = "taqat".obs;
  RxString imageUrl = "".obs;
  String? taqatFileName = "";
  String? sanadFileName = "";

  @override
  void onReady() {
    id = Get.arguments['id'].toString();
    title.value = Get.arguments['title'];
    getHiringDetails();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  getRequestStatus() {
    print('file $taqatFileName');
    switch (status.value) {
      case 0:
        if (taqatFileName != null && taqatFileName != '') {
          statusStr.value = "Payment Paid (Unverified)".tr;
        } else {
          statusStr.value = "Payment Pending".tr;
        }
        break;
      case 1:
        statusStr.value = "Payment Verified".tr;
        break;
      case 2:
        statusStr.value = "Payment Rejected by Admin".tr;
        break;
      default:
        statusStr.value = "Unknown".tr;
        break;
    }
  }

  imgFromCamera({String type = 'taqat'}) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if (type == 'taqat') {
        taqatPaymentReceipt.value = File(image.path);
        uploadDocument();
      } else {
        sanadPaymentReceipt.value = File(image.path);
        uploadDocument(type: 'sanad');
      }
    }
  }

  imgFromGallery({String type = 'taqat'}) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 'taqat') {
        taqatPaymentReceipt.value = File(image.path);
        uploadDocument();
      } else {
        sanadPaymentReceipt.value = File(image.path);
        uploadDocument(type: 'sanad');
      }
    }
  }

  getHiringDetails() {
    GlobalVariables.showLoader.value = true;
    String url = Urls.laborUserDetail + '$id';
    ApiBaseHelper().getMethod(url: url).then((parsedJson) async {
      if (parsedJson['success'] == 'true') {
        laborModel.value = SearchModel.fromJson(parsedJson['labor']);
        sponsorModel.value = UserModel.fromJson(parsedJson['user_detail']);
        bankInfoModel.value = BankInfoModel.fromJson(parsedJson['bank_info']);
        status.value = parsedJson['payment_status'];
        getRequestStatus();
        // print(parsedJson['invoice_data']);
        //Invoice details Taqat
        if (parsedJson['invoice_data'] != null) {
          invoiceModel.value =
              InvoiceModel.fromJson(parsedJson['invoice_data']);
        }
        print(invoiceModel.value.toJson());

        //  Taqat proof Document
        if (parsedJson['payment_proof_doc'] != null) {
          taqatFileName = parsedJson['payment_proof_doc'];
          imageUrl.value = '${Urls.paymentProofsImage}taqat/' + taqatFileName!;
          print(
              '%%%%%%%%%%%%%%  taqat   ${imageUrl.value}    &&&&&&&&&&&&&&&&&');
          await CommonFunctions.downloadFileFromUrl(url: imageUrl.value)
              .then((value) {
            taqatPaymentReceipt.value = value;
          });
        }
        //  Sanad proof Document
        if (parsedJson['sanad_proof_doc'] != null) {
          sanadFileName = parsedJson['sanad_proof_doc'] ?? '';
          imageUrl.value = '${Urls.paymentProofsImage}sanad/' + sanadFileName!;
          print(
              '%%%%%%%%%%%%%%  sanad   ${imageUrl.value}    &&&&&&&&&&&&&&&&&');
          await CommonFunctions.downloadFileFromUrl(url: imageUrl.value)
              .then((value) {
            sanadPaymentReceipt.value = value;
          });
        }

        //  Sanad Data and subtotal data
        if ((parsedJson['sanad_data'] != null ||
                parsedJson['sanad_data'] != []) &&
            (parsedJson['subtotal_data'] != null)) {
          flag.value = true;
          type.value = "sanad";
          var data = parsedJson['sanad_data'] as List;
          sanadModelList.addAll(data.map((e) => SanadDataModel.fromJson(e)));
          subTotalModel.value = SubTotalDataModel.fromJson(
              parsedJson['subtotal_data'] ?? SubTotalDataModel());
        }
      }
      GlobalVariables.showLoader.value = false;
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  uploadDocument({String type = 'taqat'}) async {
    GlobalVariables.showLoader.value = true;
    http.MultipartFile file = (type == 'taqat')
        ? await http.MultipartFile.fromPath(
            'payment_proof', taqatPaymentReceipt.value.path)
        : await http.MultipartFile.fromPath(
            'sanad_payment_proof_doc', sanadPaymentReceipt.value.path);
    Map<String, String> param = {'id': id};
    ApiBaseHelper()
        .postMethodFormData(
            url: Urls.paymentProof, fields: param, imgFile: file)
        .then((parsedJson) async {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['success'] == 'true') {
        taqatFileName = parsedJson['payment_proof_doc'];
        await openWhatsapp(type);
      } else {
        GetxHelper.showSnackBar(
            title: 'Error'.tr, message: Errors.generalApiError.tr);
      }
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }

  openWhatsapp(String type) async {
    String msg = '\*Request No :\* $id\n'
        '\*LaborName :\* ${laborModel.value.fullname}\n'
        '\*Occupation :\* $title\n'
        '\*Location      :\* ${laborModel.value.location}\n'
        '\*PayableFee :\*  ${type=='taqat' ?'${invoiceModel.value.totalAmount ?? 0} OMR': '${((subTotalModel.value.subtotal ?? 0) * 0.05) + (subTotalModel.value.subtotal ?? 0)} OMR'}\n\n'
        '\*Payment Proof\* ${'${Urls.paymentProofsImage}$type/' + taqatFileName!}\n\n';
    Uri url = Uri.parse('https://wa.me/923040088896/?text=$msg');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}
