import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class NotificationPageProvider extends ChangeNotifier {
  bool isEmailNotification = false;
  bool isPhoneNotification = true;
  bool isAppNotification = true;

  setEmailNotification() {
    isEmailNotification = !isEmailNotification;
    notifyListeners();
  }

  setPhoneNotification() {
    isPhoneNotification = !isPhoneNotification;
    notifyListeners();
  }

  setAppNotification() {
    isAppNotification = !isAppNotification;
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
}
