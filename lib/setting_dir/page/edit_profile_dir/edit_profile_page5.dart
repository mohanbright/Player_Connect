// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
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
    return Consumer<EditProfileProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
          Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: provider.buildAppBar( context, 5),
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
                                    PlayerStyleDialogWidget(provider: provider));
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
                    // provider.textFieldContainer(
                    //     provider,
                    //     AppStrings.strPlayingStyle,
                    //     provider.playingStyleController,
                    //     1),

                    Stack(
                      children: [
                        Container(
                          // height: AppFontSize.font45,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColorWhite,
                              border: Border.all(
                                  color: AppColors.secondaryColorBlack,
                                  width: 1),
                              borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                          child: Center(
                            child: TextFormField(
                                onTap: () {
                          provider.        openDropdown(context);

                                },
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
                                      color: AppColors.secondaryColorBlack)),
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
                              ].map<DropdownMenuItem<String>>((String value) {
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
                              provider.isChanged = true;
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
                              provider.isChanged = true;
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
                                      fontSize: AppFontSize.font14)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () {
                            provider.editUserProfileData(context,5);

                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strDone.toUpperCase(),
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
                backgroundColor: Colors.black26,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
