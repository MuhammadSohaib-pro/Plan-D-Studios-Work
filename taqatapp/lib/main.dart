import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taqat/Screens/splash/splash_view.dart';
import 'package:taqat/helper/fcm_notification_helper.dart';
import 'package:taqat/helper/languages/languages.dart';
import 'package:taqat/helper/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FCMNotificationHelper.registerNotification();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: [
        Locale("en","US"),
      ],
       localizationsDelegates: [
         CountryLocalizations.delegate,
       ],
      debugShowCheckedModeBanner: false,
      title: 'Taqat',
      theme: ThemeData(
        fontFamily: 'Urbanist',
        primarySwatch: Palette.palette1,
        scaffoldBackgroundColor: ThemeColors.bgColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.bgColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: ThemeColors.black1,
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: ThemeColors.black1,
          ),
        ),
      ),
      home: SplashView(),
    );
  }
}
