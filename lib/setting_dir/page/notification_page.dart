// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/notification_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationPageProvider>(
      create: (_) {
        return NotificationPageProvider();
      },
      child: Consumer<NotificationPageProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.secondaryColorWhite,
              // leading: InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Image(
              //     image: AssetImage(AppIconImages.backIconImg),
              //     height: AppFontSize.font24,
              //     width: AppFontSize.font24,
              //   ),
              // ),
              iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
              centerTitle: true,
              title: Text(AppStrings.strNotifications,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: Padding(
              padding: EdgeInsets.all(AppFontSize.font10),
              child: Column(
                children: [
                  provider.buildListTileData(
                      title: AppStrings.strEmail,
                      trailingIconData: Switch(
                          onChanged: (value) {
                            provider.setEmailNotification();
                          },
                          value: provider.isEmailNotification,
                          activeColor: AppColors.primaryColorBlue,
                          activeTrackColor: AppColors.primaryColorSkyBlue,
                          inactiveThumbColor: AppColors.primaryColorBlue,
                          inactiveTrackColor: AppColors.greyColor)),
                  provider.buildListTileData(
                      title: AppStrings.strPhone,
                      trailingIconData: Switch(
                          onChanged: (value) {
                            provider.setPhoneNotification();
                          },
                          value: provider.isPhoneNotification,
                          activeColor: AppColors.primaryColorBlue,
                          activeTrackColor: AppColors.primaryColorSkyBlue,
                          inactiveThumbColor: AppColors.primaryColorBlue,
                          inactiveTrackColor: AppColors.greyColor)),
                  provider.buildListTileData(
                      title: AppStrings.strAppNotifi,
                      trailingIconData: Switch(
                          onChanged: (value) {
                            provider.setAppNotification();
                          },
                          value: provider.isAppNotification,
                          activeColor: AppColors.primaryColorBlue,
                          activeTrackColor: AppColors.primaryColorSkyBlue,
                          inactiveThumbColor: AppColors.primaryColorBlue,
                          inactiveTrackColor: AppColors.greyColor)),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
