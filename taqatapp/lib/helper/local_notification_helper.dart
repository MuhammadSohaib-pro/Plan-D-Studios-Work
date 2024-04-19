import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:taqat/helper/common_functions.dart';
import 'package:taqat/screens/message/message_viewmodel.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  localNotificationOnTabAction(notificationResponse.payload);
}

final localNotifications = FlutterLocalNotificationsPlugin();

class LocalNotification {
  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    await localNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: true,
            requestBadgePermission: true,
            requestAlertPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            notificationCategories: [
          const DarwinNotificationCategory(
            'demoCategory',
            actions: [],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          )
        ]);

    LinuxInitializationSettings initializationSettingsLinux =
        const LinuxInitializationSettings(
            defaultActionName: 'Open notification');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            linux: initializationSettingsLinux);

    await localNotifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {
      String? messageType =  notificationResponse.payload;
      localNotificationOnTabAction(messageType);
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  // this function is applicable to iOS versions older than 10.
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}
}

Future<void> showLocalNotification({
  required int id,
  required RemoteMessage message,
}) async {
  final platformChannelSpecifics = await _notificationDetails();
  String title = message.notification?.title ?? '';
  String body = message.notification?.body ?? '';

  print('firebase response');
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data.toString());

  bool showNotification = true;

  if (message.data['from_id'] != null) {
    String newUserid = message.data['from_id'];
    try {
      MessageViewModel messageViewModel = Get.find();
      if (messageViewModel.userId == newUserid){
        showNotification = false;
      }
    } catch (e) {
      print(e);
    }
  }


  if(!showNotification){
    return;
  }
  String notificationType= "";
  if (message.data.containsKey("notification_type")) {
    // The map contains the key "notification_type"
    // You can access its value using data["notification_type"]
    notificationType = message.data["notification_type"];
    print("Notification type is: $notificationType");
  } else {
    // The map does not contain the key "notification_type"
    print("Notification type not found.");
  }
  await localNotifications.show(
    id,
    title,
    body,
    platformChannelSpecifics,
    payload:notificationType,
  );
}

Future<NotificationDetails> _notificationDetails() async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      const AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true,
    groupKey: 'com.example.flutter_push_notifications',
    channelDescription: 'channel description',
    priority: Priority.max,
    icon: 'app_icon',
    ticker: 'ticker',
    channelShowBadge: true,
    colorized: true,
    color: Color(0xff0c8a7b),
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableLights: true,
      showBadge: true,
      playSound: true);

  await localNotifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(threadIdentifier: "thread1");

  final details = await localNotifications.getNotificationAppLaunchDetails();
  if (details != null && details.didNotificationLaunchApp) {}
  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

  return platformChannelSpecifics;
}
