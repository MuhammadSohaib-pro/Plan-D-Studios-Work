import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geo_school/helper/languages.dart';
import 'package:geo_school/screens/splash/splash_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   // systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
  //   //systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  //   //statusBarColor: Colors.white,
  //   //statusBarBrightness: Brightness.light, //status bar brightness
  //   //statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      //  locale: Locale('en', 'US'),
      locale: Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: 'Geo School',
      theme: ThemeData(
        primaryColor: Color(0xff023330),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          titleSpacing: 25,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: 'Poppins-Regular'),
          color: Color(0xff1F4946),
        ),
      ),
      home: SplashView(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
