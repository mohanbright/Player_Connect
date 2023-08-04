// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/forgot_password_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProvider>(
      create: (_) {
        return ForgotPasswordProvider();
      },
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppFontSize.font24,
                    vertical: AppFontSize.font10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppFontSize.font10),
                    Image(
                      image: AssetImage(AppImages.appLogo),
                      height: AppFontSize.font60,
                      width: AppFontSize.font75,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: AppFontSize.font12),
                    buildTextSpan(AppStrings.strCant, AppStrings.strIsLogin),
                    SizedBox(height: AppFontSize.font20),
                    Text(AppStrings.strEmail,
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
                            controller: provider.emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppStrings.strEnterEmail,
                              contentPadding:
                                  EdgeInsets.fromLTRB(14, 10, 10, 10),
                              hintStyle: AppFonts.poppinsFont(TextStyle(
                                  fontSize: AppFontSize.font14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.infoPageCount)),
                            )),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font20),
                    InkWell(
                        onTap: () {
                          if (provider.emailController.text.isEmpty) {
                            AppSnackBarToast.buildShowSnackBar(
                                context, AppStrings.strEnterEmail);
                          } else {
                            Navigator.pushNamed(
                                context, AppRoutes.newPasswordPage);
                          }
                        },
                        child: AppButtons.elevatedButton(
                            AppStrings.strSend.toUpperCase(),
                            AppFonts.poppinsFont(TextStyle(
                                fontSize: AppFontSize.font16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColorWhite)),
                            AppColors.primaryColorBlue)),
                    SizedBox(height: AppFontSize.font300),
                    Text.rich(TextSpan(
                        text: AppStrings.strBackTo,
                        style: AppFonts.poppinsFont(TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryColorBlack,
                            fontSize: AppFontSize.font16)),
                        children: <InlineSpan>[
                          TextSpan(
                              text: AppStrings.strLogin.toUpperCase(),
                              style: AppFonts.poppinsFont(TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColorBlue,
                                  fontSize: AppFontSize.font16)),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                })
                        ])),
                    SizedBox(height: AppFontSize.font32),
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
