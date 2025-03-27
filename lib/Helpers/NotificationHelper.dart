import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/AppUrls.dart';
import 'package:getrightmealnew/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../Models/NotificationModelBody.dart';

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveBackgroundNotificationResponse: (NotificationResponse response)async{
            print('onDidReceiveBackgroundNotificationResponse');
            print(response.toString());
        },
        onDidReceiveNotificationResponse: (NotificationResponse response) async {
          try {
            print("onDidReceiveNotificationResponse");
            print(response.payload);

          } catch (e) {
            print(e.toString());

          }
          return;
        });

    await FirebaseMessaging.onMessage.listen((RemoteMessage message)async {
      print("ON MESSAGE LISTEN");
      debugPrint("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.data}");
     await NotificationHelper.showNotification(
          message, );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)async {
      debugPrint("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {

      } catch (e) {
        print(e.toString());
      }
    });
  }

  static Future showNotification(RemoteMessage message) async {
    print("Inside show notification method");
    print("message received : "+message.toString());
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      largeIcon: DrawableResourceAndroidBitmap("notification_icon"),
      styleInformation: MediaStyleInformation(
        htmlFormatContent: true,
        htmlFormatTitle: false,
      ),
      playSound: true,
    );

    await flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification!.title,
        message.notification!.body,
        payload: message.data.toString(),
        NotificationDetails(
          android: androidDetails,
        ));
  }
  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBodyModel convertNotification(Map<String, dynamic> data) {
    print("COOONVERTTER");
    print(data);

    if (data['type'] == 'general') {
      return NotificationBodyModel(notificationType: NotificationType.general);
    } else if (data['type'] == 'order_status') {
      return NotificationBodyModel(
          notificationType: NotificationType.order,
          orderId: int.parse(data['order_id']));
    }
    else if (data['access_token'] !=null){
      return NotificationBodyModel(
          notificationType: NotificationType.login,
          token: data['access_token']
      );
    }

    else {

      return NotificationBodyModel(
        notificationType: NotificationType.message,
        deliverymanId: data['sender_type'] == 'delivery_man' ? 0 : null,
        adminId: data['sender_type'] == 'admin' ? 0 : null,
        restaurantId: data['sender_type'] == 'vendor' ? 0 : null,
        conversationId: int.tryParse(data['conversation_id'].toString()),
        reservationId: data['reservation_id'].toString(),
      );
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print("ON baackgroubd notifiaton");
  debugPrint("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  // await NotificationHelper.showNotification(message);



}