import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taqat/helper/getx_helper.dart';
import 'package:taqat/helper/global_variables.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:taqat/screens/chat_list/chat_list_view.dart';
import 'package:taqat/screens/complete_profile/step_1/complete_profile1_view.dart';
import 'package:taqat/screens/dashboard/dashboard_viewmodel.dart';
import 'package:taqat/screens/hiring_request/hiring_request_view.dart';
import 'package:taqat/screens/my_labors/my_labors_view.dart';
import 'package:taqat/screens/notification/notification_view.dart';
import 'package:taqat/screens/pending_invoice/pending_invoice_view.dart';
import 'package:taqat/screens/search/search_view.dart';
import 'package:taqat/widgets/custom_buttons.dart';
import 'package:taqat/widgets/custom_card.dart';
import 'package:taqat/widgets/loader_view.dart';
import 'package:taqat/widgets/scrollable_column.dart';
import 'package:badges/badges.dart' as badges;

class DashboardView extends StatelessWidget {
  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ScrollableColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    chatBtn(),
                    notificationBtn(),
                    languageBtn(),
                  ],
                ),
                welcomeTxt(),
                emailTxt(),
                completeProfileBtn(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      addALaborBtn(),
                      hireALaborBtn(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                searchForLaborsBtn(),
                updateProfileBtn(),
                myLaborsBtn(),
                hiringRequestBtn(),
                pendingInvoiceBtn(),
                helpAndSupportBtn(),
                logoutBtn(),
              ],
            ),
            LoaderView()
          ],
        ),
      ),
    );
  }

  Widget chatBtn() {
    return GestureDetector(
      onTap: () {
        Get.to(() => ChatListView());
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: Icon(
          Icons.message,
          size: 24,
        ),
      ),
    );
  }

  Widget notificationBtn() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(
            top: 5,
            left: GlobalVariables.isLanguageChanged ? 0 : 5,
            right: GlobalVariables.isLanguageChanged ? 5 : 0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => NotificationView());
          },
          child: badges.Badge(
            badgeStyle: const BadgeStyle(
                badgeColor: Colors.red, padding: EdgeInsets.all(4)),
            position: BadgePosition.topEnd(top: -4, end: -4),
            showBadge: GlobalVariables.badgeCount.value == 0 ? false : true,
            badgeContent: Text(
              GlobalVariables.badgeCount.value.toString(),
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Icon(
                Icons.notifications_none_outlined,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget languageBtn() {
    return Container(
      margin: EdgeInsets.only(
          right: GlobalVariables.isLanguageChanged ? 0 : 10,
          top: 5,
          left: GlobalVariables.isLanguageChanged ? 10 : 0),
      child: PopupMenuButton(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Icon(
            Icons.language,
            size: 24,
          ),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () {
                GlobalVariables.isLanguageChanged = false;
                GetStorage().write('language', 'english');
                Get.updateLocale(Locale('en', 'US'));
              },
              child: Text(
                'English'.tr,
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
                GlobalVariables.isLanguageChanged = true;
                GetStorage().write('language', 'arabic');
                Get.updateLocale(Locale('ar', 'EG'));
              },
              child: Text(
                'Arabic'.tr,
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
    );
  }

  Widget welcomeTxt() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        child: Text(
          "${'Welcome'.tr} ${GlobalVariables.userModel.value.name ?? ''}",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: ThemeColors.black1,
          ),
        ),
      ),
    );
  }

  Widget emailTxt() {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 20),
      child: Text(
        '${GlobalVariables.userModel.value.email}',
        style: TextStyle(
          color: ThemeColors.grey2,
        ),
      ),
    );
  }

  Widget completeProfileBtn() {
    return Obx(
      () => (GlobalVariables.profileCompletion.value < 100)
          ? Container(
              margin: EdgeInsets.only(left: 24, right: 24, bottom: 20),
              height: 75,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff0C8A7B),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      completeYourProfileTxt(),
                      const SizedBox(height: 10),
                      clickHereToContinueTxt(),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      circularProgressBar(),
                      percentageTxt(),
                    ],
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget completeYourProfileTxt() {
    return Text(
      "Please Complete Your Profile".tr,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xffFFFFFF),
      ),
    );
  }

  Widget clickHereToContinueTxt() {
    return InkWell(
      onTap: () {
        Get.to(() => CompleteProfile1View());
      },
      child: Text(
        "Click Here to Continue".tr,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }

  Widget circularProgressBar() {
    return Obx(
      () => Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xff0C8A7B),
        child: CircularProgressIndicator(
          value: (GlobalVariables.profileCompletion.value / 100),
          backgroundColor: Color(0xffFFFFFF),
          strokeWidth: 6.5,
          color: Color(0xff11AE9C),
        ),
      ),
    );
  }

  Widget percentageTxt() {
    return Text(
      "${GlobalVariables.profileCompletion.value} %",
      style: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w900,
        color: Color(0xffFFFFFF),
      ),
    );
  }

  Widget addALaborBtn() {
    return Obx(
      () => CustomDashboardCard(
        icon: "assets/svg/addLabor.svg",
        title: "Add Labor".tr,
        text: '${viewModel.laborAdded.value}',
        onTap: () {
          viewModel.addLaborButton();
        },
      ),
    );
  }

  Widget hireALaborBtn() {
    return Obx(
      () => CustomDashboardCard(
        icon: "assets/svg/hireLabor.svg",
        title: "Hire Labor".tr,
        text: "${viewModel.hireCount}",
        onTap: () {},
      ),
    );
  }

  Widget searchForLaborsBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DashboardTextBtn(
        onPressed: () {
          Get.to(() => SearchView());
        },
        btnTitle: 'Search For Labors'.tr,
        btnIcon: Icons.search,
      ),
    );
  }

  Widget updateProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: DashboardTextBtn(
        onPressed: () {
          Get.to(() => CompleteProfile1View());
        },
        btnTitle: 'Update Your Profile'.tr,
        btnIcon: Icons.person,
      ),
    );
  }

  Widget myLaborsBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DashboardTextBtn(
        onPressed: () {
          if (GlobalVariables.profileCompletion.value == 100) {
            Get.to(() => MyLaborsView());
          } else {
            GetxHelper.showSnackBar(
                title: 'Error'.tr.tr,
                message: 'Please complete your profile first'.tr);
          }
        },
        btnTitle: 'My Labors'.tr,
        btnIcon: Icons.work_history_outlined,
      ),
    );
  }

  Widget hiringRequestBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: DashboardTextBtn(
        onPressed: () {
          Get.to(() => HiringRequestView());
        },
        btnTitle: 'Hiring Request'.tr,
        btnIcon: Icons.person_add_alt_1,
      ),
    );
  }

  Widget pendingInvoiceBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: DashboardTextBtn(
        onPressed: () {
          Get.to(() => PendingInvoiceView());
        },
        btnTitle: 'Pending Invoice'.tr,
        btnIcon: Icons.attach_money,
      ),
    );
  }

  Widget helpAndSupportBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: DashboardTextBtn(
        onPressed: () {},
        btnTitle: 'Help & Support'.tr,
        btnIcon: Icons.warning,
      ),
    );
  }

  Widget logoutBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      child: CustomTextBtn(
        height: 55,
        onPressed: () {
          viewModel.logout();
        },
        backgroundColor: Colors.white,
        foregroundColor: ThemeColors.red,
        child: Text(
          'Log out'.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ThemeColors.red,
          ),
        ),
      ),
    );
  }
}
