import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  final SplashViewModel splashViewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023330),
      body: Center(
        child: Image(
          image: AssetImage('assets/images/splash_image.png'),
        ),
      ),
    );
  }
}
