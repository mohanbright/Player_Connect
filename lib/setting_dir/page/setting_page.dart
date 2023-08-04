// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/setting_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/privacy_policy_widget.dart';
import 'package:player_connect/shared/widget/terms_condition_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return SettingPageProvider();
      },
      child: Consumer(
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
              title: Text(AppStrings.strSettings,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppFontSize.font10),
                child: Column(
                  children: [
                    Card(
                      color: AppColors.secondaryColorWhite,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                      child: ListTile(
                        leading: CircleAvatar(
                            radius: AppFontSize.font18,
                            backgroundImage: AssetImage(AppImages.playerRecc)),
                        title: Text("John Isner",
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font14))),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editProfilePage1);
                          },
                          child: Text(AppStrings.strEdit,
                              style: AppFonts.poppinsFont(TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColorSkyBlue,
                                  fontSize: AppFontSize.font14))),
                        ),
                      ),
                    ),
                    buildCard(AppStrings.strNotifications, 0),
                    buildCard(AppStrings.strChangePassword, 1),
                    buildCard(AppStrings.strContactSupport, 2),
                    buildCard(AppStrings.strSignOut, 3),
                    SizedBox(height: AppFontSize.font20),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.deleteAccountPage);
                      },
                      child: Text(AppStrings.strDeleteAccount,
                          style: AppFonts.mazzardFont(TextStyle(
                              color: AppColors.systemColorRed,
                              fontWeight: FontWeight.w400,
                              fontSize: AppFontSize.font16))),
                    ),
                    SizedBox(height: AppFontSize.font150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => TermsConditionWidget(),
                            );
                          },
                          child: Text(
                            AppStrings.strTermsConditions,
                            style: AppFonts.poppinsFont(TextStyle(
                                color: AppColors.primaryColorBlue,
                                fontWeight: FontWeight.w400,
                                fontSize: AppFontSize.font14)),
                          ),
                        ),
                        SizedBox(width: AppFontSize.font20),
                        CircleAvatar(
                            radius: 4, backgroundColor: AppColors.greyColor),
                        SizedBox(width: AppFontSize.font20),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => PrivacyPolicyWidget(),
                            );
                          },
                          child: Text(
                            AppStrings.strPrivacyPolicy,
                            style: AppFonts.poppinsFont(TextStyle(
                                color: AppColors.primaryColorBlue,
                                fontWeight: FontWeight.w400,
                                fontSize: AppFontSize.font14)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget buildCard(title, index) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      color: AppColors.secondaryColorWhite,
      child: ListTile(
        onTap: () {
          index == 0
              ? Navigator.pushNamed(context, AppRoutes.notificationPage)
              : index == 1
                  ? Navigator.pushNamed(context, AppRoutes.changePassPage)
                  : index == 2
                      ? Navigator.pushNamed(
                          context, AppRoutes.contactSupportPage)
                      : showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text(AppStrings.strIsLogOut),
                            content: Text(AppStrings.strSureToLogOut),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    AppSnackBarToast.buildShowSnackBar(
                                        context, AppStrings.strLogOutSuccess);
                                    Navigator.of(ctx).pop();
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        AppRoutes.loginPage, (route) => false);
                                  },
                                  child: Text(AppStrings.strYes)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(AppStrings.strNo)),
                            ],
                          ),
                        );
        },
        title: Text(title,
            style: AppFonts.mazzardFont(TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColorBlue,
                fontSize: AppFontSize.font14))),
        trailing: index == 3
            ? null
            : Image(
                image: AssetImage(AppIconImages.shortArrowIconImg),
                height: AppFontSize.font12,
                width: AppFontSize.font8),
      ),
    );
  }
}
