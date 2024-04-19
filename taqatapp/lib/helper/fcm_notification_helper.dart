import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/helper/local_notification_helper.dart';

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  showLocalNotification(id: 1, message: message);
  CommonFunctions.getNotificationCount();
}

class FCMNotificationHelper {
  static void registerNotification() async {
    LocalNotification service = LocalNotification();
    service.initializeLocalNotifications();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) {
      print(value);
    });

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Future.delayed(const Duration(seconds: 3), () {
          String messageType= message.data["notification_type"];
          localNotificationOnTabAction(messageType);
        });
      }
    });

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        String messageType=  message.data["notification_type"];
        localNotificationOnTabAction(messageType);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        showLocalNotification(id: 1, message: message);
        CommonFunctions.getNotificationCount();
      });
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }
}
