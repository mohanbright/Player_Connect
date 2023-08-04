// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/player_style_dialog_widget.dart';
import 'package:provider/provider.dart';

class EditProfilePage5 extends StatefulWidget {
  const EditProfilePage5({Key? key}) : super(key: key);

  @override
  State<EditProfilePage5> createState() => _EditProfilePage5State();
}

class _EditProfilePage5State extends State<EditProfilePage5> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (_) {
        return EditProfileProvider();
      },
      child: Consumer<EditProfileProvider>(
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
              title: Text(AppStrings.strEditProfile,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppFontSize.font12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppFontSize.font12),
                    Row(
                      children: [
                        provider.buildText(AppStrings.strPlayingStyle),
                        SizedBox(width: AppFontSize.font4),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    PlayerStyleDialogWidget());
                          },
                          child: Image(
                            image: AssetImage(AppIconImages.helpIconImg),
                            height: AppFontSize.font20,
                            width: AppFontSize.font20,
                          ),
                        ),
                        SizedBox(width: AppFontSize.font4),
                        Text(AppStrings.strFindOutPlayingStyle,
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.infoPageCount,
                                fontSize: AppFontSize.font14)))
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(
                        provider,
                        AppStrings.strPlayingStyle,
                        provider.playingStyleController,
                        1),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(""),
                    SizedBox(height: AppFontSize.font12),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            visualDensity: VisualDensity.compact,
                            activeColor: AppColors.primaryColorSkyBlue,
                            title: Text(AppStrings.strLeft),
                            value: true,
                            groupValue: provider.isDiamondHand,
                            onChanged: (value) {
                              provider.getBoolDiamondHand(value as bool);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            activeColor: AppColors.primaryColorSkyBlue,
                            title: Text(AppStrings.strRight),
                            value: false,
                            groupValue: provider.isDiamondHand,
                            onChanged: (value) {
                              provider.getBoolDiamondHand(value as bool);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font200),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strBack.toUpperCase(),
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.dashBoardPage, (route) => false);
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strDone.toUpperCase(),
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorWhite,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorBlue)),
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
}
