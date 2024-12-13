// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
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
    return Consumer<EditProfileProvider>(
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
                backgroundColor: AppColors.bgColor,
                appBar: provider.buildAppBar(context, 1),
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
                                Expanded(
                                  child: Text(
                                      provider.emailController.text.toString(),
                                      maxLines: 2,
                                      style: AppFonts.poppinsFont(TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryColorBlack,
                                          fontSize: AppFontSize.font14))),
                                ),
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
                            provider.isPhotoChanged == false
                                ? Container(
                                    height: AppFontSize.font70,
                                    width: AppFontSize.font70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppFontSize.font18)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppFontSize.font18),
                                      child: CachedNetworkImage(
                                          imageUrl: provider.userImg!,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Center(child: Icon(Icons.error)),
                                          fit: BoxFit.fill),
                                    ),
                                  )
                                : Container(
                                    height: AppFontSize.font70,
                                    width: AppFontSize.font70,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(provider.image!),
                                            fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(
                                            AppFontSize.font18)),
                                  ),
                            SizedBox(width: AppFontSize.font20),
                            InkWell(
                              onTap: () {
                                provider.profileImage(context);
                              },
                              child: Text(AppStrings.strChangeProfilePic,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font16))),
                            ),
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
                        provider.textFieldContainer(
                            provider,
                            AppStrings.strLastName,
                            provider.lastNameController,
                            1),
                        SizedBox(height: AppFontSize.font12),
                        provider.buildText(AppStrings.strPhoneNumber),
                        SizedBox(height: AppFontSize.font12),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColorWhite,
                              border: Border.all(
                                  color: AppColors.secondaryColorBlack,
                                  width: 1),
                              borderRadius:
                                  BorderRadius.circular(AppFontSize.font12)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  provider.showCountryPicker(context);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(Icons.phone,
                                        color: AppColors.infoPageCount,
                                        size: 20),
                                    SizedBox(width: 4),
                                    provider.countryCode.isEmpty
                                        ? SizedBox()
                                        : Text(
                                            provider.countryCode,
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontSize:
                                                        AppFontSize.font14,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryColorBlack)),
                                          ),
                                    SizedBox(width: 4),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                    controller: provider.phoneNumController,
                                    textAlignVertical: TextAlignVertical.top,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      provider.isChanged = true;
                                    },
                                    keyboardType: TextInputType.phone,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontSize: AppFontSize.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryColorBlack)),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "00000 00000",
                                      // contentPadding: EdgeInsets.fromLTRB(0, 2, 12, 0),
                                      hintStyle: AppFonts.poppinsFont(TextStyle(
                                          fontSize: AppFontSize.font14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.infoPageCount)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppFontSize.font12),
                        provider.buildText(AppStrings.strTennisExp),
                        SizedBox(height: AppFontSize.font12),
                        provider.textFieldContainer(
                            provider,
                            AppStrings.strYourTennisExperience,
                            provider.textAreaController,
                            5),
                        SizedBox(height: AppFontSize.font20),
                        InkWell(
                          onTap: () {
                            if (provider.isChanged == true) {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfilePage2);
                              provider.isChanged = false;
                            } else {
                              Navigator.pushNamed(
                                  context, AppRoutes.editProfilePage2);
                            }
                          },
                          child: AppButtons.elevatedButton(
                              AppStrings.strNext.toUpperCase(),
                              AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorWhite,
                                  fontSize: AppFontSize.font14)),
                              AppColors.primaryColorBlue),
                        )
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
