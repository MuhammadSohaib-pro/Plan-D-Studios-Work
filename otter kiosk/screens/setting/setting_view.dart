import 'package:kiosk/screens/setting/setting_viewmodel.dart';

import '../../libraries.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  var viewModel = Get.put(SettingViewModel());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: appBar(),
        body: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            screenSaverTxt(),
            screenSaverTile(),
            photoCaptureTxt(),
            photoCaptureTile(),
            usernameTxt(),
            emailTile(),
            supportTxt(),
            helpTile(),
            termAndServiceTile(),
            deviceIdTxt(),
            deviceIdTile(),
            appVersionTxt(),
            versionTile(),
            logOutTxt(),
            logOutTile(),
            deleteAcountTile(),
            Get.context!.isTablet && Get.context!.isLandscape
                ? Expanded(child: SizedBox())
                : SizedBox(height: 30),
            poweredByRow(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        "Settings",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget screenSaverTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 20, bottom: 10),
      child: Text(
        "Screensaver",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget screenSaverTile() {
    return CustomTile2(
      imageUrl: "assets/svg/screensaver.svg",
      title: "Screensaver",
      ontap: () {
        Get.to(() => ScreenSaverView());
      },
      icon: Padding(
        padding: const EdgeInsets.only(right: 23.0),
        child: InkWell(
          child: Icon(
            Icons.arrow_forward,
            color: ThemeColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget photoCaptureTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 20, bottom: 10),
      child: Text(
        "Photo Capture",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget photoCaptureTile() {
    return CustomTile2(
      imageUrl: "assets/svg/info.svg",
      title: "Turn on automatic photo capture",
      icon: Padding(
        padding: const EdgeInsets.only(right: 17.0),
        child: Obx(() => Switch(
              activeColor: ThemeColors.primaryColor,
              value: GlobalVariables.photocapture.value,
              onChanged: (value) {
                GlobalVariables.photocapture.value = value;
              },
            )),
      ),
    );
  }

  Widget usernameTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 20, bottom: 10),
      child: Text(
        "Username",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget emailTile() {
    return CustomTile2(
      imageUrl: "assets/svg/team.svg",
      title: "Ben@huckadventures.com",
    );
  }

  Widget supportTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10, bottom: 10),
      child: Text(
        "Support",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget helpTile() {
    return CustomTile2(
      imageUrl: "assets/svg/team.svg",
      title: "Help",
      ontap: () {},
    );
  }

  Widget termAndServiceTile() {
    return CustomTile2(
      imageUrl: "assets/svg/team.svg",
      title: "Terms of Service",
      ontap: () {},
    );
  }

  Widget deviceIdTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10, bottom: 10),
      child: Text(
        "Device ID",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget deviceIdTile() {
    return CustomTile2(
      imageUrl: "assets/svg/mobile.svg",
      title: "59cf234097344920374",
    );
  }

  Widget appVersionTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10, bottom: 10),
      child: Text(
        "App Version",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget versionTile() {
    return CustomTile2(
      imageUrl: "assets/svg/info.svg",
      title: "Version 1.0.04",
    );
  }

  Widget logOutTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10, bottom: 10),
      child: Text(
        "Log out",
        style: TextStyle(
          fontSize: 16,
          color: ThemeColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget logOutTile() {
    return CustomTile2(
      imageUrl: "assets/svg/logout.svg",
      title: "Log out of account",
      ontap: () {
        Get.defaultDialog(
          titlePadding: EdgeInsets.only(top: 30),
          contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 30),
          title: 'Confirm Logout',
          middleText: "Are you sure, You want to logout",
          textCancel: 'No',
          textConfirm: 'Yes',
          onConfirm: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setBool('checklogin', false);
            Get.offAll(() => LoginView());
          },
          confirmTextColor: ThemeColors.white,
        );
      },
    );
  }

  Widget deleteAcountTile() {
    return CustomTile2(
      imageUrl: "assets/svg/load.svg",
      title: "Delete account",
      ontap: () {},
    );
  }

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
