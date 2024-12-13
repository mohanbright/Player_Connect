// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/change_pass_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:provider/provider.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangePassPageProvider>(
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
            title: Text(AppStrings.strChangePassword,
                style: AppFonts.mazzardFont(TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColorBlue,
                    fontSize: AppFontSize.font16))),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppFontSize.font10, horizontal: AppFontSize.font20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppFontSize.font8),
                  titleText(AppStrings.strCurrentPassword),
                  SizedBox(height: AppFontSize.font8),
                  textFieldContainer(
                      provider,
                      provider.currentPasswordController,
                      AppStrings.strCurrentPassword,
                      provider.isShowCurrentPassword,
                      0),
                  SizedBox(height: AppFontSize.font18),
                  titleText(AppStrings.strNewPassword),
                  SizedBox(height: AppFontSize.font8),
                  textFieldContainer(provider, provider.newPasswordController,
                      AppStrings.strNewPassword, provider.isShowNewPassword, 1),
                  SizedBox(height: AppFontSize.font18),
                  titleText(AppStrings.strConfirmPassword),
                  SizedBox(height: AppFontSize.font8),
                  textFieldContainer(
                      provider,
                      provider.confirmPasswordController,
                      AppStrings.strConfirmPassword,
                      provider.isShowConfirmPassword,
                      2),
                  SizedBox(height: AppFontSize.font200),
                  InkWell(
                    onTap: () {
                      if (provider.currentPasswordController.text
                          .trim()
                          .isEmpty) {
                        AppSnackBarToast.buildShowSnackBar(
                            context, AppStrings.strEnterCurrPass);
                      } else if (provider.newPasswordController.text
                          .trim()
                          .isEmpty) {
                        AppSnackBarToast.buildShowSnackBar(
                            context, AppStrings.strEnterNewPass);
                      } else if (provider.newPasswordController.text
                              .trim()
                              .length <
                          8) {
                        AppSnackBarToast.buildShowSnackBar(
                            context, AppStrings.strEnterMin8Digit);
                      } else if (provider.confirmPasswordController.text
                          .trim()
                          .isEmpty) {
                        AppSnackBarToast.buildShowSnackBar(
                            context, AppStrings.strEnterConfirmPass);
                      } else if (provider.newPasswordController.text
                              .trim()
                              .toString() !=
                          provider.confirmPasswordController.text
                              .trim()
                              .toString()) {
                        AppSnackBarToast.buildShowSnackBar(
                            context, AppStrings.strPassNotMatch);
                      } else {
                        provider.changePass(
                            context);

                        // Navigator.pop(context);
                      }
                    },
                    child: AppButtons.elevatedButton(
                        AppStrings.strDone,
                        AppFonts.poppinsFont(TextStyle(
                            fontSize: AppFontSize.font14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryColorWhite)),
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
                    backgroundColor: Colors.black45,
                    body: Center(
                      child: CircularProgressIndicator(),
                    )))
          ],
        );
      },
    );
  }

  Widget titleText(title) {
    return Text(title,
        style: AppFonts.poppinsFont(TextStyle(
            fontSize: AppFontSize.font14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColorBlack)));
  }

  Widget textFieldContainer(ChangePassPageProvider provider, controller,
      hintText, showPassword, index) {
    return Container(
      height: AppFontSize.font45,
      decoration: BoxDecoration(
          color: AppColors.secondaryColorWhite,
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Center(
        child: TextFormField(
            obscureText: showPassword,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: EdgeInsets.fromLTRB(14, 10, 10, 10),
                hintStyle: AppFonts.poppinsFont(TextStyle(
                    fontSize: AppFontSize.font14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.infoPageCount)),
                suffixIcon: Align(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: InkWell(
                      onTap: () {
                        index == 0
                            ? provider.setShowCurrentPassword()
                            : index == 1
                                ? provider.setShowNewPassword()
                                : provider.setShowConfirmPassword();
                      },
                      child: Icon(
                        showPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                      ),
                    )))),
      ),
    );
  }
}
