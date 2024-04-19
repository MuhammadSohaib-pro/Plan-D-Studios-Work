import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/helper/urls.dart';
import 'package:taqat/screens/add_labor/step_1/add_labor1_view.dart';
import 'package:taqat/screens/labor_details/labor_details_view.dart';
import 'package:taqat/screens/my_labors/my_labors_viewmodel.dart';
import 'package:taqat/widgets/custom_bottom_sheet_item_row.dart';
import 'package:taqat/widgets/loader_view.dart';

class MyLaborsView extends StatelessWidget {
  MyLaborsView({super.key});

  final MyLaborsViewModel viewModel = Get.put(MyLaborsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Stack(
          children: [
            listView(),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(title: Text("My Labors".tr));
  }

  Widget listView() {
    return Obx(
      () => viewModel.mainList.isNotEmpty
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: viewModel.mainList.length,
              itemBuilder: (context, index) {
                return listViewItem(index);
              },
            )
          : Center(
              child: Text('No Item Found'.tr),
            ),
    );
  }

  Widget listViewItem(int index) {
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
            selectImageBottomSheet(index);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageContainer(index),
                const SizedBox(width: 13),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.mainList[index].title ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          color: ThemeColors.grey2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 12),
                        child: Text(
                          viewModel.mainList[index].fullname ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.black1,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${'OMR'.tr} ${viewModel.mainList[index].monthlySalary ?? ""}/${'m'.tr}",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors.grey2,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                viewModel.mainList[index].nationality ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ThemeColors.grey2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  selectImageBottomSheet(int index) {
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
                      'Select Option'.tr,
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
                title: 'View Detail'.tr,
                icon: CupertinoIcons.profile_circled,
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(
                    () => LaborDetailsView(),
                    arguments: {
                      'data': viewModel.mainList[index],
                      'hireBtnFalg':true,
                    },
                  );
                },
              ),
              BottomSheetItemRow(
                title: 'Edit Labor'.tr,
                icon: CupertinoIcons.pencil,
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() => AddLabor1View(), arguments: {
                    "isUpdate": true,
                    "data": viewModel.mainList[index]
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget imageContainer(int index) {
    return CachedNetworkImage(
      height: 84,
      width: 84,
      imageUrl: Urls.imageUrl + viewModel.mainList[index].laborPhoto.toString(),
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
