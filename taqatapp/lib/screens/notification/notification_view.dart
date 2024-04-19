import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/Widgets/custom_buttons.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/hiring_request/hiring_request_view.dart';
import 'package:taqat/screens/notification/notification_viewmodel.dart';
import 'package:taqat/screens/pending_invoice/pending_invoice_view.dart';
import 'package:taqat/widgets/loader_view.dart';

class NotificationView extends StatelessWidget {
  NotificationView({super.key});

  final NotificationViewModel viewModel = Get.put(NotificationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          Obx(
            () => (viewModel.newNotificationList.isNotEmpty ||
                    viewModel.oldNotificationList.isNotEmpty)
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              viewModel.newNotificationList.isNotEmpty
                                  ? latestNotificationTxt()
                                  : SizedBox(),
                              clearAllTxtBtn(),
                            ],
                          ),
                          newListView(),
                          divider(),
                          oldTxt(),
                          oldListView(),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: Text('No Notification Available'.tr),
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
        'Notifications'.tr,
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

  Widget latestNotificationTxt() {
    return Text(
      'Latest Notification'.tr,
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Color(0xff1A1D1E),
      ),
    );
  }

  Widget clearAllTxtBtn() {
    return TextButton(
      onPressed: () {
        viewModel.clearNotificationsList();
      },
      child: Text(
        'Clear All'.tr,
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Color(0xffB2BDD0),
        ),
      ),
    );
  }

  Widget newListView() {
    return Obx(
      () => (viewModel.newNotificationList.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: viewModel.newNotificationList.length,
                itemBuilder: (context, index) {
                  return (viewModel.newNotificationList[index].isSanad == 'yes')
                      ? newListViewItem2(index, context)
                      : newListViewItem(index, context);
                  // return newListViewItem2(index, context);
                },
              ),
            )
          : SizedBox(),
    );
  }

  newListViewItem(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: InkWell(
        onTap: viewModel.newNotificationList[index].type == "profile"
            ? () {}
            : () {
                viewModel.updateNotifications(
                    viewModel.newNotificationList[index].id);
                Get.to(() => HiringRequestView());
              },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: CachedNetworkImage(
                  height: 84,
                  width: 84,
                  imageUrl: Urls.imageUrl +
                      (viewModel.newNotificationList[index].laborPhoto ?? ''),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
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
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      viewModel.getNotificationText(
                          viewModel.newNotificationList[index]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${viewModel.newNotificationList[index].createdAt}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xffB2BDD0),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Color(0xffB2BDD0),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        viewModel.updateNotifications(
                            viewModel.newNotificationList[index].id);
                      },
                      child: Text(
                        'Mark as read'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        viewModel.deleteNotifications(
                            viewModel.newNotificationList[index].id);
                      },
                      child: Text(
                        'Delete'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  newListViewItem2(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: InkWell(
        onTap: viewModel.newNotificationList[index].type == "invoice"
            ? () {
                viewModel.updateNotifications(
                    viewModel.newNotificationList[index].id);
                Get.to(() => PendingInvoiceView());
                // Get.to(() => HiringRequestView());
              }
            : () {},
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: CachedNetworkImage(
                  height: 84,
                  width: 84,
                  imageUrl: Urls.imageUrl +
                      (viewModel.newNotificationList[index].laborPhoto ?? ''),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
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
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      viewModel.getNotificationText(
                          viewModel.newNotificationList[index]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${viewModel.newNotificationList[index].createdAt}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xffB2BDD0),
                      ),
                    ),
                    SizedBox(height: 4),
                    viewModel.newNotificationList[index].type == "release"
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: CustomElevatedBtn(
                              text: 'Accept'.tr,
                              textColor: Colors.white,
                              btnColor: ThemeColors.mainColor,
                              onPress: () {
                                viewModel.acceptRequest(
                                    viewModel.newNotificationList[index]);
                              },
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Color(0xffB2BDD0),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        viewModel.updateNotifications(
                            viewModel.newNotificationList[index].id);
                      },
                      child: Text(
                        'Mark as read'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        viewModel.deleteNotifications(
                            viewModel.newNotificationList[index].id);
                      },
                      child: Text(
                        'Delete'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return viewModel.newNotificationList.isNotEmpty &&
            viewModel.oldNotificationList.isNotEmpty
        ? Divider(color: Color(0xffB2BDD0), thickness: 1)
        : SizedBox();
  }

  Widget oldTxt() {
    return Obx(
      () => viewModel.newNotificationList.isNotEmpty &&
              viewModel.oldNotificationList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Old'.tr,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color(0xff1A1D1E),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget oldListView() {
    return Obx(
      () => viewModel.oldNotificationList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.oldNotificationList.length,
              itemBuilder: (context, index) {
                return (viewModel.oldNotificationList[index].isSanad == 'yes')
                    ? oldListViewItem2(index, context)
                    : oldListViewItem(index, context);
              },
            )
          : SizedBox(),
    );
  }

  oldListViewItem(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: InkWell(
        onTap: viewModel.oldNotificationList[index].type == "profile"
            ? () {}
            : () {
                Get.to(() => HiringRequestView());
              },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: CachedNetworkImage(
                  height: 84,
                  width: 84,
                  imageUrl: Urls.imageUrl +
                      (viewModel.oldNotificationList[index].laborPhoto ?? ''),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
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
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      viewModel.getNotificationText(
                          viewModel.oldNotificationList[index]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${viewModel.oldNotificationList[index].createdAt}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xffB2BDD0),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Color(0xffB2BDD0),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        viewModel.deleteNotifications(
                            viewModel.oldNotificationList[index].id);
                      },
                      child: Text(
                        'Delete'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  oldListViewItem2(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: InkWell(
        onTap: () {
          // viewModel
          //     .updateNotifications(viewModel.oldNotificationList[index].id);
          // Get.to(() => HiringRequestView());
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                child: CachedNetworkImage(
                  height: 84,
                  width: 84,
                  imageUrl: Urls.imageUrl +
                      (viewModel.oldNotificationList[index].laborPhoto ?? ''),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
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
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      viewModel.getNotificationText(
                          viewModel.oldNotificationList[index]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${viewModel.oldNotificationList[index].createdAt}',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xffB2BDD0),
                      ),
                    ),
                    SizedBox(height: 4),
                    viewModel.oldNotificationList[index].type == "release"
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: CustomElevatedBtn(
                              text: 'Accept'.tr,
                              textColor: Colors.white,
                              btnColor: ThemeColors.mainColor,
                              onPress: () {
                                viewModel.acceptRequest(
                                    viewModel.newNotificationList[index]);
                              },
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Color(0xffB2BDD0),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        viewModel.deleteNotifications(
                            viewModel.oldNotificationList[index].id);
                      },
                      child: Text(
                        'Delete'.tr,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xff010A1B),
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
