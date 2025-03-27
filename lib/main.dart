import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/Colors.dart';
import 'package:getrightmealnew/Controllers/AuthControllers/AccessTokenController.dart';
import 'package:getrightmealnew/Views/AppViews/CustomNavBar.dart';
import 'package:getrightmealnew/Views/AppViews/HomeScreen.dart';
import 'package:getrightmealnew/Views/OnBoardingViews/Screen1.dart';
import 'package:getrightmealnew/Views/SplashViews/SplashScreen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Helpers/NotificationHelper.dart';
import 'Views/AppViews/drawer.dart';
import 'firebase_options.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("👉 BG Notify: $message ");
  // await NotificationHelper.showNotification(message);

}

Future<void> permissionManager ()async{
  try{
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      print("Notification Permission already granted");
    } else if (status.isDenied) {
      // Request permission
      PermissionStatus newStatus = await Permission.notification.request();
      print("NEW SATTAUS");
      print(newStatus);

      final bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
        provisional: true,
        critical: true
      );
      if(result == false){
        await openAppSettings();
      }
    } else if (status.isPermanentlyDenied) {
      // Open app settings to allow manually
      print("openging");
      await openAppSettings();
      print("opened sesttings");
    }
  }catch(e){
    print("error ");
      print(e.toString());
  }
}
String fcmToken = '';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 // Google sign in

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await permissionManager();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: backgroundGrey,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);


  //
  // String? fcm = await FirebaseMessaging.instance.getToken();
  // fcmToken = fcm!;
  // print("FCM TOKEN : ");
  // print(fcm!);
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      print("REMOTE MESSAGE: ${remoteMessage?.data}");
      if (remoteMessage != null) {
        // body = NotificationHelper.convertNotification(remoteMessage.data);
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: true,
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
      var iOSInitialize = const DarwinInitializationSettings(
        requestAlertPermission: true, // Notification Center
        requestSoundPermission: true, // App Icon Badge
        requestBadgePermission: true, // Sound on arrival
          requestProvisionalPermission:true,
        requestCriticalPermission: true
      );
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
  } catch (_) {}

  runApp( MyApp());

  // runZonedGuarded(() {
  //
  // }, FirebaseCrashlytics.instance.recordError);
}
double w = 0;
double h = 0;
class MyApp extends StatelessWidget {
   MyApp({super.key});

  AccessTokenController accessTokenController = Get.put(AccessTokenController());
  // This widget is the root of your application.
   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
   static FirebaseAnalyticsObserver observer =
   FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    precacheImage(
        AssetImage('assets/onboarding2.jpg'),size: Size(1000, 200), context,onError: (error, stackTrace) {
      print("error at image caching");
      print(error);
    });

    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return GetMaterialApp(
      navigatorObservers: [observer], // Track screen navigation
      debugShowCheckedModeBanner: false,
      title: 'Get Right Meal',
      theme: ThemeData(

        scaffoldBackgroundColor: beige,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}
