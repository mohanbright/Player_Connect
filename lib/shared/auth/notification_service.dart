// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_details_page.dart';
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/page/dashboard_page.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:provider/provider.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future reqPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    );
  }

  static void getInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("New Notification");
        print("new Notification:${message.data}");
      }
    });
  }

  static onMessageOpen(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Opened app from data: ${message.data}');
      print('Opened app from notification: ${message.notification?.title}');
      print('Opened app from notification: ${message.notification?.body}');
      UserOnlineApiService.getInstance().isUserOnline(1);
      if (message.notification?.title.toString() == "New Friend Request") {
        pageSelected = 2;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DashBoardPage()));
      } else if (message.notification?.title.toString() ==
          "Friend Request Accepted") {
        pageSelected = 1;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DashBoardPage()));
      } else if (message.notification?.title.toString() ==
          "New Message Received") {
        print('Opened app for message from data=======>: ${message.data}');
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => ChatDetailsPage(
                        name: ChatPlayerListing(
                      receiverFirstName: message.data["first_name"],
                      lastMessage: message.data["last_name"],
                      receiverImages: message.data["images"],
                      receiverCity: message.data["city"],
                      receiverId: int.parse(message.data["sender_id"]),
                      senderId: int.parse(UserDetails.userID.toString()),
                      receiverIsOnline: 1,
                      senderIsOnline: 1,
                    ))))
            .then((value) {
          Provider.of<RoutesProvider>(context, listen: false)
              .getCurrentClassName(context);
        });
      }
    });
  }

  static onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message data: ${message.data}');
      // print('Received message: ${message.notification!.android!.channelId}');
      createAndDisplayNotification(message);
    });
  }

  static void initialized(context) {
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: initializationSettingsDarwin);

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print("notificationResponse.payload::${notificationResponse.payload}");
      if (notificationResponse.payload != null) {
        print(
            "Router idValue ${notificationResponse.notificationResponseType.name}");
        if (notificationResponse.payload == "New Message Received") {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ChatDetailsPage(
          //             name: ChatPlayerListing(
          //           id: int.parse(UserDetails.userID.toString()),
          //           receiverFirstName: message.data["first_name"],
          //           lastMessage: notificationResponse.data["last_name"],
          //           receiverImages: message.data["images"],
          //           receiverCity: message.data["city"],
          //           receiverId: int.parse(message.data["sender_id"]),
          //           senderId: int.parse(UserDetails.userID.toString()),
          //         ))));

          pageSelected = 1;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashBoardPage()));
        } else if (notificationResponse.payload == "New Friend Request") {
          pageSelected = 2;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashBoardPage()));
        } else if (notificationResponse.payload == "Friend Request Accepted") {
          pageSelected = 1;
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DashBoardPage()));

          // Navigator.pushNamed(context, AppRoutes.HomePage);
        }
      }
    });
  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      print("message.data[first_name]::${message.data["sender_id"]}");
      final notificationPayload = {
        'title': '${message.notification!.title}',
        "first_name": message.data["first_name"],
        "last_name": message.data["last_name"],
        "images": message.data["images"],
        "city": message.data["city"],
        "sender_id": int.parse(message.data["sender_id"]),
      };

      // notificationList.contains(0);
      // ChatPlayerListing chatPlayerListing=ChatPlayerListing();

      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            AppDetails.appChannelId,
            AppDetails.appChannelName,
            // importance: Importance.high,
            importance: Importance.defaultImportance,
            priority: Priority.high,
            fullScreenIntent: true,
          ),
          iOS: DarwinNotificationDetails(
              presentBadge: true,
              presentBanner: true,
              presentAlert: true,
              presentSound: true,
              subtitle: message.notification!.title));
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: notificationPayload.toString(),
      );
    } on Exception catch (e) {
      print("createAndDisplayNotification error: $e");
    }
  }
}
