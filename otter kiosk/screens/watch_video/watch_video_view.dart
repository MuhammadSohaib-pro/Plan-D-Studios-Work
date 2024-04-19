import 'dart:io';

import '../../libraries.dart';
import 'package:pod_player/pod_player.dart';

class WatchVideoView extends StatelessWidget {
  WatchVideoView({super.key});

  final WatchVideoViewModel viewModel = Get.put(WatchVideoViewModel());

  final AdultProcessViewModel adultviewModel =
      Get.find<AdultProcessViewModel>();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: appBar(),
          body: GlobalVariables.datamodel.videoUrl == null
              ? Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeColors.grey5,
                        borderRadius: BorderRadius.circular(15)),
                    height: 50.h,
                    width: 80.w,
                    child: Center(child: Text('Video url is Empty'.tr)),
                  ),
                )
              : ScrollableColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      color: Colors.amber,
                      // height:
                      //     Get.context!.isTablet && Get.context!.isLandscape ||
                      //             Get.context!.isPortrait
                      //         ? 400
                      //         : 300,
                      width: double.infinity,
                      margin: Get.context!.isTablet && Get.context!.isLandscape
                          ? EdgeInsets.symmetric(horizontal: 160)
                          : Get.context!.isTablet && Get.context!.isPortrait
                              ? EdgeInsets.symmetric(
                                  horizontal: Get.width / 5.5)
                              : EdgeInsets.symmetric(horizontal: 30),
                      child: PodVideoPlayer(
                        controller: viewModel.controller,
                      ),
                    ),
                    // videoContainer(),
                    SizedBox(height: 30),
                    alreadyWatchVideoBtn(),
                    SizedBox(height: 20),
                  ],
                ),
        );
      },
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: forwardBackBtnRow(),
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
    );
  }

  Widget forwardBackBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.grey2,
            ),
            child: Icon(
              Icons.arrow_back,
              color: ThemeColors.white,
            ),
          ),
        ),
        GlobalVariables.photocapture.value
            ? Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ThemeColors.errorRedColor,
                    ),
                    child: Text(
                      'By using this kiosk you consent to have your picture taken.'
                          .tr,
                      maxLines: 4,
                      style: TextStyle(color: ThemeColors.white),
                    )),
              )
            : SizedBox(),
        GestureDetector(
          onTap: () {
            if (GlobalVariables.photocapture.value) {
              imagecapture();
            }
            GlobalVariables.datamodel.includeTripDate!
                ? Get.to(() => TripDateView())
                : adultviewModel.participatingTypeBtn.value == "Minor(s)" ||
                        adultviewModel.participatingTypeBtn.value ==
                            "Adult + Minor(s)"
                    ? Get.to(() => MinorParticipantView())
                    : Get.to(() => AdultParticipantView());
          },
          child: Container(
            margin: EdgeInsets.all(10),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ThemeColors.fullLightPrimary,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: ThemeColors.white,
            ),
          ),
        )
      ],
    );
  }

  // Widget videoContainer() {
  Widget alreadyWatchVideoBtn() {
    return CustomElevatedBtn(
      height: 50,
      width: 250,
      backgroundColor: Colors.grey.shade300,
      child: Text(
        "Already watched the Video?".tr,
        style: TextStyle(
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () async {
        alreadyWatchVideoDialog();
      },
    );
  }

  Future<dynamic> alreadyWatchVideoDialog() {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return Dialog(
          alignment: Alignment.center,
          shape: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 300,
            width: 315,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  color: ThemeColors.redColor,
                ),
                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.lock,
                          color: ThemeColors.white,
                          size: 30,
                        ),
                        radius: 30,
                        backgroundColor: ThemeColors.redColor,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          "Have you already watched this video?".tr,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 18,
                            color: ThemeColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Text(
                    "By clicking “YES,” do you confirm that you and all participants in your group involved in this activity have watched the entire video?"
                        .tr,
                    maxLines: 6,
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedBtn(
                        height: 45,
                        width: 100,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          "NO".tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: ThemeColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CustomElevatedBtn(
                        height: 45,
                        width: 100,
                        backgroundColor: ThemeColors.redColor,
                        child: Text(
                          "YES".tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: ThemeColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  imagecapture() async {
    debugPrint('in');
    if (!viewModel.photocontroller.value.isInitialized) {
      debugPrint('a');
      return null;
    }
    if (viewModel.photocontroller.value.isTakingPicture) {
      return null;
    }
    try {
      await viewModel.photocontroller.setFlashMode(FlashMode.off);
      image = await viewModel.photocontroller.takePicture();
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
    print(Image.file(File(image!.path)));
  }
}
