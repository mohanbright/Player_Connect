// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class CreateProfilePage1 extends StatefulWidget {
  const CreateProfilePage1({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage1> createState() => _CreateProfilePage1State();
}

class _CreateProfilePage1State extends State<CreateProfilePage1> {
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
                    Text(AppStrings.strCompleteProfile,
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
                            //     BorderRadius.circular(AppFontSize.font4),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        provider.image == null
                            ? Container(
                                height: AppFontSize.font95,
                                width: AppFontSize.font95,
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColorLightGrey,
                                    borderRadius: BorderRadius.circular(
                                        AppFontSize.font18)),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    size: AppFontSize.font40,
                                    color: AppColors.infoPageCount,
                                  ),
                                ),
                              )
                            : Container(
                                height: AppFontSize.font95,
                                width: AppFontSize.font95,
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColorLightGrey,
                                    // color: AppColors.primaryColorSkyBlue,
                                    image: DecorationImage(
                                        image: FileImage(provider.image!),
                                        fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(
                                        AppFontSize.font18)),
                              ),
                        SizedBox(width: AppFontSize.font12),
                        InkWell(
                          onTap: () {
                            provider.cameraImage(context);
                          },
                          child: Text(AppStrings.strUploadProfilePic,
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryColorBlue,
                                  fontSize: AppFontSize.font16))),
                        ),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),
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
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColorWhite,
                          border: Border.all(
                              color: AppColors.secondaryColorBlack, width: 1),
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
                                    color: AppColors.infoPageCount, size: 20),
                                SizedBox(width: 4),
                                provider.countryCode == null
                                    ? SizedBox()
                                    : Text(
                                        provider.countryCode!,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontSize: AppFontSize.font14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryColorBlack)),
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
                    provider.buildText(AppStrings.strTextArea),
                    SizedBox(height: AppFontSize.font12),
                    provider.textFieldContainer(
                        provider,
                        AppStrings.strSomethingAboutU,
                        provider.textAreaController,
                        5),
                    SizedBox(height: AppFontSize.font12),
                    InkWell(
                      onTap: () async {
                        if (provider.image == null) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strUploadProfilePic);
                        } else if (provider.firstNameController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strFirstName);
                        } else if (provider.lastNameController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strLastName);
                        } else if (provider.countryCode == null) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strSelectCountryCode);
                        } else if (provider.phoneNumController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strPhoneNumber);
                        } else if (provider.textAreaController.text
                            .trim()
                            .isEmpty) {
                          AppSnackBarToast.buildShowSnackBar(
                              context, AppStrings.strEnterAboutU);
                        } else {
                          LocalDataSaver.saveUserPhoto(
                              provider.image.toString());
                          LocalDataSaver.saveUserFirstName(provider
                              .firstNameController.text
                              .trim()
                              .toString());
                          LocalDataSaver.saveUserLastName(provider
                              .lastNameController.text
                              .trim()
                              .toString());
                          LocalDataSaver.saveUserPhone(
                              "${provider.countryCode}${provider.phoneNumController.text.trim().toString()}");
                          LocalDataSaver.saveUserInfo(
                              provider.textAreaController.text.toString());
                          LocalDataSaver.saveUserCountryFlag(
                              provider.countryFlag.toString());
                          LocalDataSaver.saveUserCountryName(
                              provider.selectedCountry);
                          await fetchDataSPreferences();

                          provider.setProgressTask(2);
                          // provider.completeTaskValue = 2;
                          setState(() {});
                          provider.setProgressBar(0.4);

                          progressTaskValue = 0.4;
                          progressTaskDone = 2;
                          Navigator.pushNamed(
                              context, AppRoutes.createProfilePage2,
                              arguments: provider);
                        }
                      },
                      child: AppButtons.elevatedButton(
                          AppStrings.strContinue.toUpperCase(),
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
