// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/player_style_dialog_widget.dart';
import 'package:provider/provider.dart';

class CreateProfilePage5 extends StatefulWidget {
  const CreateProfilePage5({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage5> createState() => _CreateProfilePage5State();
}

class _CreateProfilePage5State extends State<CreateProfilePage5> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateProfileProvider>(
      create: (_) {
        return CreateProfileProvider();
      },
      child: Consumer<CreateProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppFontSize.font24,
                    vertical: AppFontSize.font20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(AppImages.appLogo),
                      height: AppFontSize.font50,
                      width: AppFontSize.font60,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: AppFontSize.font24),
                    Text(AppStrings.strTellAboutGame,
                        style: AppFonts.mazzardFont(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColorBlue,
                            fontSize: AppFontSize.font16))),
                    SizedBox(height: AppFontSize.font20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            // value: provider.completeProgressBar,
                            value: progressTaskValue,
                            color: AppColors.primaryColorSkyBlue,
                            minHeight: AppFontSize.font8,
                            backgroundColor: AppColors.secondaryColorLightGrey,
                            // borderRadius:
                            // BorderRadius.circular(AppFontSize.font4),
                          ),
                        ),
                        SizedBox(width: AppFontSize.font14),
                        Text.rich(TextSpan(
                            // text: '${provider.completeTaskValue}',
                            text: '$progressTaskDone',
                            style: AppFonts.poppinsFont(TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font16)),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '/5',
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColorBlue,
                                    fontSize: AppFontSize.font16)),
                              )
                            ])),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font20),
                    Row(
                      children: [
                        provider.buildText(AppStrings.strPlayingStyle),
                        SizedBox(width: AppFontSize.font4),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => PlayerStyleDialogWidget(),
                            );
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
                    provider.buildText(AppStrings.strDiamondHand),
                    SizedBox(height: AppFontSize.font12),
                    Row(
                      children: [
                        Container(
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
                        Container(
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
                    SizedBox(height: AppFontSize.font180),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  "BACK",
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () async {
                            if (provider.playingStyleController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterPlayingStyle);
                            } else {
                              LocalDataSaver.saveUserPlayingStyle(
                                  provider.playingStyleController.text);
                              LocalDataSaver.saveUserIsDominant(
                                  provider.isDiamondHand);
                              await fetchDataSPreferences();
                              Navigator.pushNamed(
                                  context, AppRoutes.connectWithPage);
                              provider.createProfileData(context);
                            }
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strNext.toUpperCase(),
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
