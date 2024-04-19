import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/request_details/request_details_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'hiring_request_viewmodel.dart';

class HiringRequestView extends StatelessWidget {
  HiringRequestView({super.key});

  final HiringRequestViewModel viewModel = Get.put(HiringRequestViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          Column(
            children: [
              tabsButton(),
              Obx(
                () => viewModel.hiringRequestBtn.value == "Received"
                    ? receivedListView()
                    : sentListView(),
              ),
            ],
          ),
          LoaderView()
        ],
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      title: Text(
        'Hiring Request'.tr,
        style: TextStyle(),
      ),
    );
  }

  Widget tabsButton() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: CustomButton8(
                backgroundColor: viewModel.hiringRequestBtn.value == "Received"
                    ? Color(0xff0C8A7B)
                    : Color(0xffD9D9D9),
                textColor: viewModel.hiringRequestBtn.value == "Received"
                    ? Colors.white
                    : Colors.black,
                text: "Received".tr,
                onPressed: () {
                  viewModel.hiringRequestBtn.value = "Received";
                },
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CustomButton8(
                backgroundColor: viewModel.hiringRequestBtn.value == "Sent"
                    ? Color(0xff0C8A7B)
                    : Color(0xffD9D9D9),
                textColor: viewModel.hiringRequestBtn.value == "Sent"
                    ? Colors.white
                    : Colors.black,
                text: "Sent".tr,
                onPressed: () {
                  viewModel.hiringRequestBtn.value = "Sent";
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedListView() {
    return Expanded(
      child: (viewModel.receivedRequestsList.isNotEmpty)
          ? ListView.builder(
              itemCount: viewModel.receivedRequestsList.length,
              itemBuilder: (context, index) {
                return receivedListViewItem(index);
              },
            )
          : Center(
              child: Text('No Request Found'.tr),
            ),
    );
  }

  Widget receivedListViewItem(int index) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              imageContainer(
                  viewModel.receivedRequestsList[index].laborPhoto ?? ''),
              const SizedBox(width: 13),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.receivedRequestsList[index].fullname ?? 'N/A',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.black1,
                      ),
                    ),
                    Text(
                      "${viewModel.receivedRequestsList[index].title}, ${viewModel.receivedRequestsList[index].nationality}",
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColors.grey2,
                      ),
                    ),
                    Text(
                      "${'Sponsor'.tr} : ${viewModel.receivedRequestsList[index].firstName} ${viewModel.receivedRequestsList[index].lastName}",
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColors.mainColor,
                      ),
                    ),
                    SizedBox(height: 6),
                    viewModel.receivedRequestsList[index].laborStatus == "0"
                        ? Row(
                            children: [
                              CustomElevatedBtn(
                                btnColor: Color(0xff0C8A7B),
                                textColor: Color(0xffFFFFFF),
                                text: "Accept".tr,
                                onPress: () {
                                  viewModel.updateRequest(
                                      index: index, status: '1');
                                },
                              ),
                              SizedBox(width: 15),
                              CustomElevatedBtn(
                                btnColor: Color(0xffFF3A2C),
                                textColor: Color(0xffFFFFFF),
                                text: "Reject".tr,
                                onPress: () {
                                  viewModel.updateRequest(
                                      index: index, status: '2');
                                },
                              ),
                            ],
                          )
                        : viewModel.receivedRequestsList[index].laborStatus ==
                                "1"
                            ? CustomElevatedBtn(
                                width: 120,
                                btnColor: Color(0xff0C8A7B),
                                textColor: Color(0xffFFFFFF),
                                text: "Request Accepted".tr,
                                onPress: () {},
                              )
                            : viewModel.receivedRequestsList[index]
                                        .laborStatus ==
                                    "2"
                                ? CustomElevatedBtn(
                                    width: 120,
                                    btnColor: Color(0xffFF3A2C),
                                    textColor: Color(0xffFFFFFF),
                                    text: "Request Rejected".tr,
                                    onPress: () {},
                                  )
                                : CustomElevatedBtn(
                                    width: 120,
                                    btnColor: Color(0xffFF3A2C),
                                    textColor: Color(0xffFFFFFF),
                                    text: "Request Ignored".tr,
                                    onPress: () {},
                                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sentListView() {
    return Expanded(
      child: (viewModel.sentRequestsList.isNotEmpty)
          ? ListView.builder(
              itemCount: viewModel.sentRequestsList.length,
              itemBuilder: (context, index) {
                return sentListViewItem(index);
              },
            )
          : Center(
              child: Text('No Request Found'.tr),
            ),
    );
  }

  Widget sentListViewItem(int index) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // selectImageBottomSheet(index);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageContainer(
                    viewModel.sentRequestsList[index].laborPhoto ?? ''),
                const SizedBox(width: 13),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.sentRequestsList[index].fullname ?? 'N/A',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.black1,
                        ),
                      ),
                      Text(
                        "${viewModel.sentRequestsList[index].title}, ${viewModel.sentRequestsList[index].nationality}",
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeColors.grey2,
                        ),
                      ),
                      Text(
                        "${'Sponsor'.tr} : ${viewModel.sentRequestsList[index].firstName} ${viewModel.sentRequestsList[index].lastName}",
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeColors.mainColor,
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          (viewModel.sentRequestsList[index].laborStatus == '0')
                              ? CustomElevatedBtn(
                                  btnColor: Color(0xedecd649),
                                  textColor: Color(0xffFFFFFF),
                                  text: "Pending".tr,
                                  onPress: () {},
                                )
                              : (viewModel.sentRequestsList[index]
                                          .laborStatus ==
                                      '1')
                                  ? CustomElevatedBtn(
                                      width: 120,
                                      btnColor: Color(0xff0C8A7B),
                                      textColor: Color(0xffFFFFFF),
                                      text: "View Detail".tr,
                                      onPress: () {
                                        Get.to(() => RequestDetailsView(),
                                            arguments: {
                                              'id': viewModel
                                                  .sentRequestsList[index].id,
                                              'title': viewModel
                                                  .sentRequestsList[index]
                                                  .title,
                                            });
                                      },
                                    )
                                  : (viewModel.sentRequestsList[index]
                                              .laborStatus ==
                                          '2')
                                      ? CustomElevatedBtn(
                                          width: 120,
                                          btnColor: Color(0xffFF3A2C),
                                          textColor: Color(0xffFFFFFF),
                                          text: "Cancelled".tr,
                                          onPress: () {},
                                        )
                                      : CustomElevatedBtn(
                                          width: 120,
                                          btnColor: Color(0xffFF3A2C),
                                          textColor: Color(0xffFFFFFF),
                                          text: "Request Ignored".tr,
                                          onPress: () {},
                                        ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
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
    );
  }
}
