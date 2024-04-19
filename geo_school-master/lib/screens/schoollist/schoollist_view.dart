import 'package:flutter/material.dart';
import 'package:geo_school/screens/login/school_list_model.dart';
import 'package:geo_school/screens/schoollist/schoollist_viewmodel.dart';
import 'package:get/get.dart';

class SchoolListView extends StatelessWidget {
  final SchoolListViewModel schoolListViewModel =
      Get.put(SchoolListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
// schoolListViewModel.dataList.clear();
            schoolListViewModel.loadOfflineData();
          });
        },
        child: listView(),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text('schoolsList'.tr),
      actions: [
        IconButton(
          onPressed: () {
            schoolListViewModel.loadOfflineData();
          },
          icon: Icon(
            Icons.sync,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget listView() {
    return Obx(
      () => (schoolListViewModel.dataList.isNotEmpty)
          ? ListView.builder(
              padding: EdgeInsets.fromLTRB(
                  Get.width * 0.04, 0, Get.width * 0.04, Get.height * 0.02),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: schoolListViewModel.dataList.length,
              itemBuilder: (context, int index) {
                return listItem(schoolListViewModel.dataList[index], index);
              },
            )
          : Center(
              child: Text('noSchool'.tr),
            ),
    );
  }

  Widget listItem(SchoolListModel model, int index) {
    return InkWell(
      onTap: () {
        schoolListViewModel.editSchool(model.id!);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Get.width * 0.023),
            padding: EdgeInsets.fromLTRB(Get.width * 0.037, Get.width * 0.025,
                Get.width * 0.045, Get.width * 0.030),
            decoration: BoxDecoration(
              color: Color(0xffF0F0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name?.capitalize ?? '',
                  style: TextStyle(
                    fontSize: Get.width * 0.027,
                    fontFamily: 'Poppins-Regular',
                    color: Color(0xff999999),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/school_icon.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      'status'.tr + ' :',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: 'Poppins-Regular',
                                        color: Color(0xff999999),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: approvalStatus(model.approved, model.modified),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'latitude'.tr + ' :',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        model.lat ?? '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'longitude'.tr + ' :',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        model.lng ?? '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'date'.tr + ' :',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        model.createdAt ?? '',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xff999999),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(top: 3),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Expanded(
                              //         flex: 1,
                              //         child: Text(
                              //           Lang.txt[34] + ' :',
                              //           style: TextStyle(
                              //             fontSize: 10,
                              //             fontFamily: 'Poppins-Regular',
                              //             color: Color(0xff999999),
                              //           ),
                              //         ),
                              //       ),
                              //       Expanded(
                              //         flex: 2,
                              //         child: Text(
                              //           (model.address == null)
                              //               ? ''
                              //               : model.address,
                              //           style: TextStyle(
                              //             fontSize: 10,
                              //             fontFamily: 'Poppins-Regular',
                              //             color: Color(0xff999999),
                              //           ),
                              //           overflow: TextOverflow.ellipsis,
                              //           maxLines: 2,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 15,
              right: 5,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      (model.modified == '0') ? Colors.red : Color(0xff16BC16),
                ),
                child: Icon(
                  (model.modified == '0') ? Icons.close : Icons.check,
                  color: Colors.white,
                  size: 10,
                ),
              )),
        ],
      ),
    );
  }

  Widget approvalStatus(String? approvedValue, String? modifiedValue) {
    if (approvedValue == '0' && modifiedValue == '0') {
      return Text(
        'notModified'.tr,
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'Poppins-Regular',
          fontWeight: FontWeight.w600,
          color: Colors.orange,
        ),
      );
    } else if (approvedValue == '0' && modifiedValue == '1') {
      return Text(
        'pending'.tr,
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'Poppins-Regular',
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      );
    } else if (approvedValue == '1' && modifiedValue == '1') {
      return Text(
        'approved'.tr,
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'Poppins-Regular',
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      );
    } else if (approvedValue == '2') {
      return Text(
        'rejected'.tr,
        style: TextStyle(
          fontSize: 9,
          fontFamily: 'Poppins-Regular',
          fontWeight: FontWeight.w600,
          color: Colors.red,
        ),
      );
    } else {
      return Container(height: 0);
    }
  }
}
