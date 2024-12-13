// ignore_for_file: unused_local_variable, file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class NotificationApiService {
  static NotificationApiService? _instance;

  NotificationApiService._internal();

  static NotificationApiService getInstance() {
    _instance ??= NotificationApiService._internal();
    return _instance!;
  }

  Future? appNotificationDatas(context, id) async {
    try {
      var response = await http.put(
        Uri.parse(AppApiUtils.notificationStatusApi),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          // 'Content-Type': 'application/json',
        },
        body: {
          "isNotification": id.toString(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        final jsonResponse = jsonDecode(response.body);
      } else {
        print(response.body);
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      print(e);
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
