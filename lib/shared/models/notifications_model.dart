import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationModel extends ChangeNotifier {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool notificationsEnabled = true;
  List<String> notificationsList = [];

  NotificationModel() {
    _setupFirebaseMessaging();
  }

  void toggleNotifications() {
    notificationsEnabled = !notificationsEnabled;
    notifyListeners();
  }

  List<String> get notifications => notificationsList;

  void addNotification(String message) {
    notificationsList.add(message);
    notifyListeners();
  }

  void clearNotifications() {
    notificationsList.clear();
    notifyListeners();
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notifications
      final notificationMessage = message.notification?.body ?? '';
      addNotification(notificationMessage);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification when the app is already open
      final notificationMessage = message.notification?.body ?? '';
      addNotification(notificationMessage);
    });
  }
}
