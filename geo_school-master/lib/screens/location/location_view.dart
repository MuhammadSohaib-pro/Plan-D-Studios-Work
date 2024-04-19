import 'package:flutter/material.dart';
import 'package:geo_school/screens/location/location_viewmodel.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/custom_buttons.dart';
import 'package:get/get.dart';

class LocationView extends StatelessWidget {
  final LocationViewModel locationViewModel = Get.put(LocationViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Stack(
        children: [
          Column(
            children: [
              greenContainer(),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  latitudeValues(),
                  Container(
                    height: Get.height * 0.13,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.7,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  longitudeValues(),
                ],
              ),
              Spacer(),
              saveSchoolButton(),
            ],
          ),
          Loader()
        ],
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      title: Text('gpsCoordinates'.tr),
      actions: [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {
            if (locationViewModel.shareSheetOpen == false)
              locationViewModel.getAddress(context);
          },
          tooltip: 'share'.tr,
        )
      ],
    );
  }

  greenContainer() {
    return Container(
      height: Get.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff023330),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(110),
        ),
      ),
      child: Column(
        children: [
          locationPointer(),
          circularContainer(),
        ],
      ),
    );
  }

  Widget latitudeValues() {
    return Column(
      children: [
        Text(
          'latitude'.tr,
          style: TextStyle(
            fontSize: Get.width * 0.08,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
            fontFamily: 'Poppins-Regular',
          ),
        ),
        Obx(
          () => Text(
            locationViewModel.latitude.value,
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.w100,
              color: Color(0xff333333),
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ),
      ],
    );
  }

  Widget longitudeValues() {
    return Column(
      children: [
        Text(
          'longitude'.tr,
          style: TextStyle(
            fontSize: Get.width * 0.08,
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
            fontFamily: 'Poppins-Regular',
          ),
        ),
        Obx(
          () => Text(
            locationViewModel.longitude.value,
            style: TextStyle(
              fontSize: Get.width * 0.04,
              fontWeight: FontWeight.w100,
              color: Color(0xff333333),
              fontFamily: 'Poppins-Regular',
            ),
          ),
        ),
      ],
    );
  }

  Widget locationPointer() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          Get.width * 0.04, Get.height * 0.02, Get.width * 0.04, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.my_location,
            color: Colors.white,
            size: Get.width * 0.05,
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'thisIsLocationPointer'.tr,
                style: TextStyle(
                  fontSize: Get.width * 0.04,
                  color: Colors.white,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget circularContainer() {
    return Expanded(
      child: Obx(
        () => Container(
          padding: EdgeInsets.fromLTRB(Get.width * 0.08, Get.height * 0.03,
              Get.width * 0.08, Get.width * 0.12),
          decoration: BoxDecoration(
              border: Border.all(
                color: double.parse(locationViewModel.accuracy.value) < 50
                    ? Colors.green
                    : Colors.red,
                width: 3.5,
              ),
              shape: BoxShape.circle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                locationViewModel.accuracy.value + ' m',
                style: TextStyle(
                  fontSize: Get.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
              Text(
                'singleAccuracy'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.width * 0.05,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: 'Poppins-Regular',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveSchoolButton() {
    return Obx(
      () => Container(
        margin: EdgeInsets.fromLTRB(
            Get.width * 0.2, 0, Get.width * 0.2, Get.height * 0.03),
        child: CustomButton8(
          onPressed: (double.parse(locationViewModel.accuracy.value) < 50)
              ? () => locationViewModel.openForm()
              : () {},
          backgroundColor: Color(0xffFE9900),
          text: 'modifySchool'.tr,
        ),
      ),
    );
  }
}
