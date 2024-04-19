import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/Widgets/custom_buttons.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/request_details/request_details_view.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'pending_invoice_viewmodel.dart';

class PendingInvoiceView extends StatelessWidget {
  PendingInvoiceView({super.key});

  final PendingInvoiceViewModel viewModel = Get.put(PendingInvoiceViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          listView(),
          LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: Text('Pending Invoice'.tr),
    );
  }

  Widget listView() {
    return Obx(
      () => (viewModel.pendingInvoiceList.isNotEmpty)
          ? ListView.builder(
              itemCount: viewModel.pendingInvoiceList.length,
              itemBuilder: (context, index) {
                return listViewItem(index);
              },
            )
          : Center(
              child: Text('No Pending Invoice'.tr),
            ),
    );
  }

  Widget listViewItem(int index) {
    return Obx(
      () => Container(
        margin: EdgeInsets.fromLTRB(20, 9, 20, 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 3.5,
              blurRadius: 10,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Get.to(() => RequestDetailsView(), arguments: {
              'id': viewModel.pendingInvoiceList[index].applicationId,
              'title': viewModel.pendingInvoiceList[index].title,
            });
          },
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageContainer(
                      viewModel.pendingInvoiceList[index].laborPhoto ?? ''),
                  const SizedBox(width: 13),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${viewModel.pendingInvoiceList[index].fullname ?? 'N/A'}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ThemeColors.black1,
                                ),
                              ),
                            ),
                            Text(
                              '${'OMR'.tr} ${viewModel.pendingInvoiceList[index].totalAmount ?? '0'}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.black1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0, top: 4),
                          child: Text(
                            "${viewModel.pendingInvoiceList[index].title ?? "N/A"}, ${viewModel.pendingInvoiceList[index].nationality ?? "N/A"}",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors.grey2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 5.0,
                          ),
                          child: Text(
                            "${CommonFunctions.convertDateFormat2(viewModel.pendingInvoiceList[index].createdAt.toString())}",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors.grey2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 45,
                              child: CustomElevatedBtn(
                                btnColor:
                                    viewModel.pendingInvoiceList[index].type ==
                                            "taqat"
                                        ? ThemeColors.mainColor
                                        : ThemeColors.red,
                                textColor: Color(0xffFFFFFF),
                                text:
                                    viewModel.pendingInvoiceList[index].type ==
                                            "taqat"
                                        ? "Taqat".tr
                                        : "Sanad".tr,
                                onPress: () {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageContainer(String url) {
    return CachedNetworkImage(
      height: 84,
      width: 84,
      imageUrl: Urls.imageUrl + url,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
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
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              image: AssetImage('assets/images/default_image.png'),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }
}
