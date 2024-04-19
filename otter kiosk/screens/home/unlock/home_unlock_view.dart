import '../../../libraries.dart';

class HomeUnlockView extends StatelessWidget {
  HomeUnlockView({super.key});

  final HomeUnlockViewModel viewModel = Get.put(HomeUnlockViewModel());
  final AdultProcessViewModel adultviewmodel = Get.put(AdultProcessViewModel());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: AppBar(
          title: lockAndMenuRow(),
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
        ),
        body: ScrollableColumn(
          children: [
            SizedBox(height: 20),
            bulletImage(),
            SizedBox(height: 20),
            waiverlist(),
            Expanded(child: SizedBox()),
            poweredByRow(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget lockAndMenuRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            lockDialog();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.primaryColor,
            ),
            child: Obx(() => Icon(
                  viewModel.lockcheck.value
                      ? Icons.lock_outline
                      : Icons.lock_open,
                  color: ThemeColors.white,
                )),
          ),
        ),
        GestureDetector(
          onTap: () {
            settingModalSheet();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.primaryColor,
            ),
            child: Icon(
              Icons.more_horiz,
              color: ThemeColors.white,
            ),
          ),
        )
      ],
    );
  }

  Future<dynamic> lockDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 202,
            width: 315,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 39,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: ThemeColors.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          size: 20,
                          color: ThemeColors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "TYPE IN 4 DIGIT CODE",
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 30),
                      CustomTextField(
                        isEnabledBorder: true,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            viewModel.concatPassword(value);
                          } else {
                            viewModel.deletingLastValue();
                          }
                        },
                      ),
                      CustomTextField(
                        isEnabledBorder: true,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            viewModel.concatPassword(value);
                          } else {
                            FocusScope.of(context).previousFocus();
                            viewModel.deletingLastValue();
                          }
                        },
                      ),
                      CustomTextField(
                        isEnabledBorder: true,
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                            viewModel.concatPassword(value);
                          } else {
                            FocusScope.of(context).previousFocus();
                            viewModel.deletingLastValue();
                          }
                        },
                      ),
                      CustomTextField(
                        isEnabledBorder: true,
                        onChanged: (value) {
                          if (value.length == 1) {
                            viewModel.concatPassword(value);
                          } else {
                            FocusScope.of(context).previousFocus();
                            viewModel.deletingLastValue();
                          }
                        },
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                  SizedBox(height: 12),
                  viewModel.lockcheck.value
                      ? CustomElevatedBtn(
                          height: 50,
                          width: 225,
                          foregroundColor: Colors.grey,
                          backgroundColor: ThemeColors.primaryColor,
                          onPressed: () {
                            Get.back();
                            // Get.back();
                            viewModel.lockcheck.value = false;
                            // Get.to(() => HomeLockView());
                          },
                          child: const Text(
                            'UNLOCK SCREEN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : CustomElevatedBtn(
                          height: 50,
                          width: 225,
                          foregroundColor: Colors.grey,
                          backgroundColor: ThemeColors.primaryColor,
                          onPressed: () {
                            Get.back();
                            // Get.back();
                            viewModel.lockcheck.value = true;
                            // Get.to(() => HomeLockView());
                          },
                          child: const Text(
                            'LOCK SCREEN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> settingModalSheet() {
    return showModalBottomSheet(
      shape: UnderlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: Get.context!,
      builder: (context) {
        return Container(
          height: 225,
          decoration: BoxDecoration(
            color: ThemeColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              BottomSheetItemRow(
                title: 'Sync to Organization',
                imageUrl: "assets/svg/sync.svg",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: 'Settings',
                imageUrl: "assets/svg/gearicon.svg",
                height: 24,
                onTap: () {
                  Get.back();
                  Get.to(() => SettingView());
                },
              ),
              BottomSheetItemRow(
                title: 'Offline Waivers',
                imageUrl: "assets/svg/iconhealth.svg",
                height: 23,
                onTap: () {
                  Get.back();
                  Get.to(() => OfflineWaiversView());
                },
              ),
              BottomSheetItemRow(
                title: 'Help',
                imageUrl: "assets/svg/help.svg",
                height: 23,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bulletImage() {
    return Container(
      height: 110,
      width: 110,
      child: Obx(() => GlobalVariables.showLoader.value
          ? SizedBox()
          : viewModel.showError != ''
              ? SizedBox()
              : Image.network(
                  GlobalVariables.organization.photoUrl!,
                  height: 110,
                  width: 110,
                )),
    );
  }

  Widget waiverlist() {
    return Container(
      width: Get.context!.isLandscape ? Get.width / 1.5 : null,
      height: 50.h,
      child: Obx(() => GlobalVariables.showLoader.value
          ? LoaderView()
          : viewModel.showError != ''
              ? showError(ontap: () {
                  viewModel.gethomedata();
                })
              : ListView.separated(
                  // physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Obx(() => SizedBox(
                          height: viewModel.lockcheck.value ? 7.5 : 15,
                        ));
                  },
                  itemCount: viewModel.homeunlockmodel.waivers!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                Get.context!.isTablet && Get.context!.isPortrait
                                    ? Get.width / 5.5
                                    : Get.context!.isPhone &&
                                            Get.context!.isLandscape
                                        ? 0
                                        : 0),
                        child: Obx(() => viewModel.lockcheck.value == false
                            ?
                            //for unlock
                            CustomTile1(
                                imageUrl: 'assets/svg/GunRange.svg',
                                title: viewModel
                                    .homeunlockmodel.waivers![index].event!.name
                                    .toString(),
                                ontap: () {
                                  adultviewmodel.getadultprocessdata(
                                      viewModel
                                          .homeunlockmodel.waivers![index].id!,
                                      viewModel.homeunlockmodel.waivers![index]
                                          .title);
                                  Get.to(() => AdultProcessView());
                                },
                                enabled:
                                    (viewModel.obsecure[index]) ? true : false,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.context!.isTablet &&
                                            Get.context!.isLandscape
                                        ? 40
                                        : 15),
                                icon: InkWell(
                                  onTap: () {
                                    viewModel.obsecure[index] =
                                        !viewModel.obsecure[index];
                                  },
                                  child: Icon(
                                    (viewModel.obsecure[index])
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: viewModel.obsecure[index]
                                        ? ThemeColors.primaryColor
                                        : ThemeColors.grey2,
                                  ),
                                ),
                              )
                            :
                            // for lock
                            viewModel.obsecure[index]
                                ? CustomTile1(
                                    imageUrl: 'assets/svg/GunRange.svg',
                                    title: viewModel.homeunlockmodel
                                        .waivers![index].event!.name
                                        .toString(),
                                    ontap: () {
                                      adultviewmodel.getadultprocessdata(
                                          viewModel.homeunlockmodel
                                              .waivers![index].id!,
                                          viewModel.homeunlockmodel
                                              .waivers![index].title!);
                                      Get.to(() => AdultProcessView());
                                    },
                                    enabled: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.context!.isTablet &&
                                                Get.context!.isLandscape
                                            ? 40
                                            : 15),
                                  )
                                : SizedBox()));
                  })),
    );
  }

  // Widget gunRangeTile() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //             ? Get.width / 5.5
  //             : 0),
  //     child: Obx(
  //       () => CustomTile1(
  //         imageUrl: 'assets/svg/GunRange.svg',
  //         title: "Gun Range Waiver",
  //         ontap: () {
  //           Get.to(() => AdultProcessView());
  //         },
  //         enabled: true,
  //         icon: InkWell(
  //           onTap: () {
  //             viewModel.obsecurePassword1.value =
  //                 !viewModel.obsecurePassword1.value;
  //           },
  //           child: Icon(
  //             (viewModel.obsecurePassword1.value)
  //                 ? Icons.visibility_outlined
  //                 : Icons.visibility_off_outlined,
  //             color: viewModel.obsecurePassword1.value
  //                 ? ThemeColors.primaryColor
  //                 : ThemeColors.grey2,
  //           ),
  //         ),
  //         padding: EdgeInsets.symmetric(
  //             horizontal:
  //                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
  //       ),
  //     ),
  //   );
  // }

  // Widget axeTile() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //             ? Get.width / 5.5
  //             : 0),
  //     child: Obx(
  //       () => CustomTile1(
  //         imageUrl: 'assets/svg/Axe.svg',
  //         ontap: () {
  //           Get.to(() => AdultProcessView());
  //         },
  //         enabled: true,
  //         icon: InkWell(
  //           onTap: () {
  //             viewModel.obsecurePassword2.value =
  //                 !viewModel.obsecurePassword2.value;
  //           },
  //           child: Icon(
  //             (viewModel.obsecurePassword2.value)
  //                 ? Icons.visibility_outlined
  //                 : Icons.visibility_off_outlined,
  //             color: viewModel.obsecurePassword2.value
  //                 ? ThemeColors.primaryColor
  //                 : ThemeColors.grey2,
  //           ),
  //         ),
  //         title: "Axe Throwing Waiver",
  //         padding: EdgeInsets.symmetric(
  //             horizontal:
  //                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
  //       ),
  //     ),
  //   );
  // }

  // Widget archeryTile() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.context!.isTablet && Get.context!.isPortrait
  //             ? Get.width / 5.5
  //             : 0),
  //     child: Obx(
  //       () => CustomTile1(
  //         imageUrl: 'assets/svg/Archery.svg',
  //         title: "Archery Waiver",
  //         ontap: () {
  //           Get.to(() => AdultProcessView());
  //         },
  //         enabled: true,
  //         icon: InkWell(
  //           onTap: () {
  //             viewModel.obsecurePassword3.value =
  //                 !viewModel.obsecurePassword3.value;
  //           },
  //           child: Icon(
  //             (viewModel.obsecurePassword3.value)
  //                 ? Icons.visibility_outlined
  //                 : Icons.visibility_off_outlined,
  //             color: viewModel.obsecurePassword3.value
  //                 ? ThemeColors.primaryColor
  //                 : ThemeColors.grey2,
  //           ),
  //         ),
  //         padding: EdgeInsets.symmetric(
  //             horizontal:
  //                 Get.context!.isTablet && Get.context!.isLandscape ? 300 : 15),
  //       ),
  //     ),
  //   );
  // }

  Widget poweredByRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Powered By"),
        SizedBox(width: 10),
        SvgPicture.asset(
          'assets/svg/logo1.svg',
          height: 25,
        ),
      ],
    );
  }
}
