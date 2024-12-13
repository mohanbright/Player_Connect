// ignore_for_file: prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> getFcmToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    LocalDataSaver.saveUserFcmToken(token.toString());
    await fetchDataSPreferences();
  }

  getLoggedData() {
    // NotificationService.onMessageOpen(context);

    LocalDataSaver.getUserSplashData().then((splashValue) {
      if (splashValue != false) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, AppRoutes.playerInfoPage);
        });
      } else {
        LocalDataSaver.getUserLogData().then((logValue) async {
          fetchDataSPreferences();
          if (logValue == true) {
            await UserOnlineApiService.getInstance().isUserOnline(1);
            Future.delayed(Duration(seconds: 1), () {
              pageSelected = 0;
              Navigator.pushReplacementNamed(context, AppRoutes.dashBoardPage);
            });
          } else {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    getLoggedData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    deviceHeight(MediaQuery.of(context).size.height);
    // NotificationService.initialized(context);
    // NotificationService.getInitialMessage();
    // NotificationService.onMessage();
    // NotificationService.onMessageOpen(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: AssetImage(AppImages.splashPageLogo),
              height: AppFontSize.font50,
            ),
            SizedBox(height: height / 3),
            Text(AppStrings.strFrom,
                style: AppFonts.poppinsFont(TextStyle(
                    fontSize: AppFontSize.font16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColorBlack))),
            SizedBox(height: AppFontSize.font20),
            Image(
                image: AssetImage(AppImages.splashCoachConnect),
                height: AppFontSize.font32,
                width: width / 2),
            SizedBox(height: AppFontSize.font20),
          ],
        ),
      ),
    );
  }
}
