import 'package:flutter/material.dart';
import 'package:geo_school/widgets/Loader.dart';
import 'package:geo_school/widgets/custom_buttons.dart';
import 'package:get/get.dart';

class ThankYouView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  color: Colors.pink,
                  width: double.infinity,
                  height: Get.height,
                ),
                Container(
                  color: Color(0xff1E4945).withOpacity(0.7),
                  width: double.infinity,
                  height: Get.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.3,
                        padding: EdgeInsets.symmetric(horizontal: 85),
                        child: Image(
                          image: AssetImage('assets/images/vector_girl.png'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          'yourLocationHasBeenSubmitted'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins-Regular',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      homeButton(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Loader()
        ],
      ),
    );
  }

  Widget homeButton() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      width: Get.width * 0.8,
      height: 55,
      child: CustomButton8(
        onPressed: () {
          Get.back();
        },
        backgroundColor: Color(0xffFE9900),
        text: 'goToTheNextSchool'.tr,
      ),
    );
  }
}
