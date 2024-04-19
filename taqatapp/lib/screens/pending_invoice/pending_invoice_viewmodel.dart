import 'package:get/get.dart';
import 'package:taqat/helper/api_base_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/pending_invoice/invoice_model.dart';

class PendingInvoiceViewModel extends GetxController {

  List<InvoiceModel> pendingInvoiceList = <InvoiceModel>[].obs;

  @override
  void onReady() {
    getReceivedRequest();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariables.showLoader.value = false;
    super.onClose();
  }

  getReceivedRequest() {
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.pendingInvoice).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      var data = parsedJson['invoices'] as List;
      pendingInvoiceList.clear();
      pendingInvoiceList
          .addAll(data.map((e) => InvoiceModel.fromJson(e)));
    }).catchError((e) {
      GlobalVariables.showLoader.value = false;
      print(e);
    });
  }
}
