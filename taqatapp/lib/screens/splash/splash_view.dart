import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taqat/screens/splash/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final SplashViewModel viewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0C8A7B),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                Container(
                  height: Get.height * .745,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    //color: Colors.red,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.05),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .668,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    //color: Colors.amber,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.1),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .596,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    //color: Colors.red,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.2),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .521,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(200)),
                    //color: Colors.green,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.4),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .446,
                  width: Get.width * .915,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    //color: Colors.grey,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.6),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .374,
                  width: Get.width * .769,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    //color: Colors.blue,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.8),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .300,
                  width: Get.width * .614,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    //color: Colors.brown,
                    border:
                        Border.all(color: const Color(0xff0E9888), width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .23,
                  width: Get.width * .47,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    //color: Colors.tealAccent,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.3),
                        width: 1.0),
                  ),
                ),
                Container(
                  height: Get.height * .17,
                  width: Get.width * .349,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    //color: Colors.deepPurple,
                    border: Border.all(
                        color: const Color(0xff0E9888).withOpacity(0.1),
                        width: 1.0),
                  ),
                ),
                Image.asset("assets/images/splash_image.png",height: 67,width: 214,)
              ],
            ),
          ),
           Text(
            "Loading...".tr,
            style: TextStyle(
              
              color: Color(0xffCDCFCE),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
