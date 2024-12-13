// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/new_password_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewPasswordProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppFontSize.font24, vertical: AppFontSize.font10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              Image(
                image: AssetImage(AppImages.appLogo),
                height: AppFontSize.font60,
                width: AppFontSize.font70,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppFontSize.font10),
              buildTextSpan(AppStrings.strNew, AppStrings.strPwd),
              SizedBox(height: AppFontSize.font20),
              Text(AppStrings.strPwd,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font10),
              Container(
                height: AppFontSize.font45,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColorWhite,
                    borderRadius:
                        BorderRadius.circular(AppFontSize.font12)),
                child: Center(
                  child: TextFormField(
                      obscureText: provider.isShowPassword,
                      controller: provider.passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppStrings.strPwd,
                          contentPadding:
                              EdgeInsets.fromLTRB(14, 10, 10, 10),
                          hintStyle: AppFonts.poppinsFont(TextStyle(
                              fontSize: AppFontSize.font14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.infoPageCount)),
                          suffixIcon: Align(
                              widthFactor: 1,
                              heightFactor: 1,
                              child: InkWell(
                                onTap: () {
                                  provider.setShowPassword();
                                },
                                child: Icon(
                                  provider.isShowPassword == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                ),
                              )))),
                ),
              ),
              SizedBox(height: AppFontSize.font20),
              Text(AppStrings.strConfirmPassword,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font10),
              Container(
                height: AppFontSize.font45,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColorWhite,
                    borderRadius:
                        BorderRadius.circular(AppFontSize.font12)),
                child: Center(
                  child: TextFormField(
                      obscureText: provider.isShowConfirmPassword,
                      controller: provider.confirmPasswordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppStrings.strConfirmPassword,
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
                                provider.setShowConfirmPassword();
                              },
                              child: Icon(
                                provider.isShowConfirmPassword == true
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20,
                              ),
                            )),
                      )),
                ),
              ),
              SizedBox(height: AppFontSize.font24),
              InkWell(
                  onTap: () {
                    if (provider.passwordController.text.trim().isEmpty) {
                      AppSnackBarToast.buildShowSnackBar(
                          context, AppStrings.strEnterPwd);
                    } else if (provider.passwordController.text
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
                    } else if (provider.passwordController.text
                            .trim()
                            .toString() !=
                        provider.confirmPasswordController.text
                            .trim()
                            .toString()) {
                      AppSnackBarToast.buildShowSnackBar(
                          context, AppStrings.strPassNotMatch);
                    } else {
                      AppSnackBarToast.buildShowSnackBar(
                          context, AppStrings.strNewPassChanged);
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.loginPage, (route) => false);
                    }
                  },
                  child: AppButtons.elevatedButton(
                      AppStrings.strDone.toUpperCase(),
                      AppFonts.poppinsFont(TextStyle(
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryColorWhite)),
                      AppColors.primaryColorBlue)),
              SizedBox(height: AppFontSize.font180),
              Text.rich(TextSpan(
                  text: AppStrings.strBackTo.toUpperCase(),
                  style: AppFonts.poppinsFont(TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack,
                      fontSize: AppFontSize.font14)),
                  children: <InlineSpan>[
                    TextSpan(
                        text: AppStrings.strLogin.toUpperCase(),
                        style: AppFonts.poppinsFont(TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColorBlue,
                            fontSize: AppFontSize.font14)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.loginPage, (route) => false);
                          })
                  ])),
              SizedBox(height: AppFontSize.font20),
            ],
          ),
        ),
          ),
        );
      },
    );
  }
}
