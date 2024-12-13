// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

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
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String email = args?['email']! ?? '';
    final String socialId = args?['socialId']! ?? '';
    final String socialType = args?['socialType']! ?? '';

    print('Social Data Create 5 : $email $socialId $socialType');
    return Consumer<CreateProfileProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppFontSize.font24,
                        vertical: AppFontSize.font20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
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
                                backgroundColor:
                                    AppColors.secondaryColorLightGrey,
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
                                    builder: (context) =>
                                        PlayerStyleDialogWidget(
                                            provider: provider));
                                PlayerStyleDialogWidget(provider: provider);
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
                                    fontSize: AppFontSize.font12)))
                          ],
                        ),
                        SizedBox(height: AppFontSize.font12),
                        Stack(
                          children: [
                            Container(
                              // height: AppFontSize.font45,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColorWhite,
                                  border: Border.all(
                                      color: AppColors.secondaryColorBlack,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(
                                      AppFontSize.font12)),
                              child: Center(
                                child: TextFormField(
                                    onTap: () {},
                                    controller: provider.playingStyleController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      // hintText: AppStrings.strSelect,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      hintStyle: AppFonts.poppinsFont(TextStyle(
                                          fontSize: AppFontSize.font14,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              AppColors.secondaryColorBlack)),
                                    )),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  // value: selectedValue,

                                  onChanged: (newValue) {
                                    setState(() {
                                      provider.playingStyleController =
                                          TextEditingController(
                                              text: newValue.toString());
                                    });
                                  },
                                  items: [
                                    "All Court",
                                    "Agressive Baseliner",
                                    "Serve and Volley",
                                    "Counter-Puncher",
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strBack.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColorBlue,
                                          fontSize: AppFontSize.font14)),
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
                                  provider.createProfileData(
                                      context, email, socialId, socialType);
                                }
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strNext.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorWhite,
                                          fontSize: AppFontSize.font14)),
                                      AppColors.primaryColorBlue)),
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
                    backgroundColor: Colors.black38,
                    body: Center(child: CircularProgressIndicator()),
                  ))
            ],
          ),
        );
      },
    );
  }
}
