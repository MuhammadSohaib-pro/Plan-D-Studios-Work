import 'package:flutter/material.dart';
import 'package:geo_school/screens/bottom_navigation/bottomnavigation_viewmodel.dart';
import 'package:get/get.dart';

class BottomNavigationView extends StatelessWidget {
  final BottomNavigationViewModel bottomNavigationViewModel =
      Get.put(BottomNavigationViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return bottomNavigationViewModel.onBackPressed(context);
      },
      child: Scaffold(
        body: Center(
          child: Obx(() => bottomNavigationViewModel
              .selectView(bottomNavigationViewModel.selectedIndex.value)),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Obx(
      () => BottomNavigationBar(
        elevation: 50,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        iconSize: 27,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.orange,
        currentIndex: bottomNavigationViewModel.selectedIndex.value,
        onTap: (index) {
          bottomNavigationViewModel.selectedIndex.value = index;
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'location'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: 'map'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.save_outlined), label: 'save'.tr),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.share_outlined), label: Lang.txt[51]),
        ],
      ),
    );
  }
}
