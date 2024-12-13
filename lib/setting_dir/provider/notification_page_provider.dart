import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/services/notification_api_service.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';

class NotificationPageProvider extends ChangeNotifier {
  bool isEmailNotification = UserDetails.isEmailNotify ?? false;
  bool isPhoneNotification = UserDetails.isPhoneNotify ?? true;
  bool isAppNotification = UserDetails.isAppNotify ?? true;

  setEmailNotification() {
    isEmailNotification = !isEmailNotification;
    notifyListeners();
    LocalDataSaver.saveUserIsEmailNotify(isEmailNotification);
    notifyListeners();
  }

  setPhoneNotification() {
    isPhoneNotification = !isPhoneNotification;
    notifyListeners();
    LocalDataSaver.saveUserIsPhoneNotify(isPhoneNotification);
    notifyListeners();
  }

  setAppNotification() {
    isAppNotification = !isAppNotification;
    notifyListeners();
    LocalDataSaver.saveUserIsAppNotify(isAppNotification);
    notifyListeners();
  }

  Widget buildListTileData({title, trailingIconData}) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: ListTile(
          title: Text(
            title,
            style: AppFonts.mazzardFont(TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.font16,
                color: AppColors.primaryColorBlue)),
          ),
          trailing: trailingIconData,
        ),
      ),
    );
  }

  appNotificationData(context) {
    NotificationApiService.getInstance()
        .appNotificationDatas(context, isAppNotification ? 1 : 0);
  }
}
