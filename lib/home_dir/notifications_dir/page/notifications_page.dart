import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/models/notifications_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationModel = Provider.of<NotificationModel>(context);
    // notificationModel.setupFirebaseMessaging(); // Initialize Firebase Messaging

    return Scaffold(
      appBar: AppBar(title: const Text('Push Notifications')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${AppStrings.strNotificationCount}: ${notificationModel.notifications.length}'),
            const SizedBox(height: 16),
            Switch(
              value: notificationModel.notificationsEnabled,
              onChanged: (value) {
                notificationModel.toggleNotifications();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                notificationModel.clearNotifications();
              },
              child: const Text(AppStrings.strClearNotifications),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notificationModel.notifications.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notificationModel.notifications[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
