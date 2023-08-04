// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class EditProfilePage1 extends StatefulWidget {
  const EditProfilePage1({Key? key}) : super(key: key);

  @override
  State<EditProfilePage1> createState() => _EditProfilePage1State();
}

class _EditProfilePage1State extends State<EditProfilePage1> {
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
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColorWhite,
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                      child: ListTile(
                        title: Text(AppStrings.strEmail,
                            style: AppFonts.poppinsFont(TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font14))),
                        subtitle: Row(
                          children: [
                            Text("abc@anydomain.com",
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryColorBlack,
                                    fontSize: AppFontSize.font14))),
                            SizedBox(width: AppFontSize.font14),
                            Image(
                                image: AssetImage(
                                    AppIconImages.successGreenIconImg),
                                height: AppFontSize.font14,
                                width: AppFontSize.font14),
                            SizedBox(width: AppFontSize.font4)
                          ],
                        ),
                        trailing: CircleAvatar(
                          backgroundColor: AppColors.bgColor,
                          radius: AppFontSize.font24,
                          child: Center(
                            child: Image(
                              image: AssetImage(AppIconImages.fbIconImg),
                              height: AppFontSize.font24,
                              width: AppFontSize.font12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: AppFontSize.font70,
                          width: AppFontSize.font70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImages.playerRecc)),
                              borderRadius:
                                  BorderRadius.circular(AppFontSize.font16)),
                        ),
                        SizedBox(width: AppFontSize.font20),
                        Text(AppStrings.strChangeProfilePic,
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font16))),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font18),
                    provider.buildText(AppStrings.strFirstName),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(
                        provider,
                        AppStrings.strFirstName,
                        provider.firstNameController,
                        1),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(AppStrings.strLastName),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(provider,
                        AppStrings.strLastName, provider.lastNameController, 1),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(AppStrings.strPhoneNumber),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(provider, "00000 00000",
                        provider.phoneNumController, 1),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(AppStrings.strTennisExp),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(
                        provider,
                        AppStrings.strWriteAboutU,
                        provider.textAreaController,
                        5),
                    SizedBox(height: AppFontSize.font20),
                    InkWell(
                      onTap: () {
                        if (provider.image == null) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strUploadProfilePic);
                        } else if (provider.firstNameController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strEnterFirstName);
                        } else if (provider.lastNameController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strEnterLastName);
                        } else if (provider.phoneNumController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strEnterPhone);
                        } else if (provider.textAreaController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strEnterAboutU);
                        } else {
                          Navigator.pushNamed(
                              context, AppRoutes.editProfilePage2);
                        }
                      },
                      child: AppButtons.elevatedButton(
                          AppStrings.strSave,
                          AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColorWhite,
                              fontSize: AppFontSize.font16)),
                          AppColors.primaryColorBlue),
                    )
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
