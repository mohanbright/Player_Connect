// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/setting_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/user_info.dart';
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
  void initState() {
    fetchDataSPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingPageProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.bgColor,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: AppColors.secondaryColorWhite,
                iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
                centerTitle: true,
                title: Text(AppStrings.strSettings,
                    style: AppFonts.mazzardFont(TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColorBlue,
                        fontSize: AppFontSize.font16))),
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
                          leading: Container(
                            height: AppFontSize.font40,
                            width: AppFontSize.font40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppFontSize.font50)),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(AppFontSize.font50),
                              child: CachedNetworkImage(
                                  imageUrl: UserDetails.userPhoto.toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          title: Text(UserDetails.userName.toString(),
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColorBlue,
                                  fontSize: AppFontSize.font14))),
                          trailing: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                      context, AppRoutes.editProfilePage1)
                                  .whenComplete(() {
                                fetchDataSPreferences();
                                setState(() {});
                              });
                            },
                            child: Text(AppStrings.strEdit,
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColorSkyBlue,
                                    fontSize: AppFontSize.font14))),
                          ),
                        ),
                      ),
                      buildCard(provider, AppStrings.strNotifications, 0),
                      buildCard(provider, AppStrings.strChangePassword, 1),
                      buildCard(provider, AppStrings.strContactSupport, 2),
                      buildCard(provider, AppStrings.strSignOut, 3),
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
                                fontSize: AppFontSize.font14))),
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
            ),
            Visibility(
                visible: provider.isLoading,
                child: Scaffold(
                    backgroundColor: Colors.black12,
                    body: Center(child: CircularProgressIndicator())))
          ],
        );
      },
    );
  }

  Widget buildCard(SettingPageProvider provider, title, index) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      color: AppColors.secondaryColorWhite,
      child: ListTile(
        onTap: () {
          fetchDataSPreferences();
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
                                    Navigator.of(ctx).pop();
                                    provider.logOutReqPlayer(context);

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
