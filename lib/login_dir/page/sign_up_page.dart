// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/login_dir/provider/sign_up_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/privacy_policy_widget.dart';
import 'package:player_connect/shared/widget/terms_condition_widget.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    // return Consumer<SignUpProvider>(builder: (context, provider, child) {
    return Consumer<CreateProfileProvider>(builder: (context, provider, child) {
      return Consumer<SignUpProvider>(builder: (context, signProvider, child) {
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
                        vertical: AppFontSize.font10),
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
                        buildTextSpan(AppStrings.strSign, AppStrings.strUp),
                        SizedBox(height: AppFontSize.font14),
                        Text(AppStrings.strEmail,
                            style: AppFonts.poppinsFont(TextStyle(
                                fontSize: AppFontSize.font12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColorBlack))),
                        SizedBox(height: AppFontSize.font10),
                        textFieldContainer(provider, provider.emailController,
                            AppStrings.strEnterEmail),
                        SizedBox(height: AppFontSize.font14),
                        Text(AppStrings.strPwd,
                            style: AppFonts.poppinsFont(TextStyle(
                                fontSize: AppFontSize.font12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColorBlack))),
                        SizedBox(height: AppFontSize.font10),
                        textFieldContainer(
                            provider,
                            provider.passwordController,
                            AppStrings.strEnterPwd),
                        SizedBox(height: AppFontSize.font24),
                        Text.rich(
                          TextSpan(
                              text: AppStrings.strRead,
                              style: AppFonts.poppinsFont(TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14)),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: AppStrings.strTermsConditions,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorBlue,
                                        fontSize: AppFontSize.font14)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) =>
                                              TermsConditionWidget(),
                                        );
                                      }),
                                TextSpan(
                                  text: ' & ',
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14)),
                                ),
                                TextSpan(
                                    text: AppStrings.strPrivacyPolicy,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorBlue,
                                        fontSize: AppFontSize.font14)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) =>
                                              PrivacyPolicyWidget(),
                                        );
                                      }),
                              ]),
                        ),
                        SizedBox(height: AppFontSize.font20),
                        InkWell(
                          onTap: () {
                            bool isValid = provider.emailValid(
                                provider.emailController.text.trim());
                            if (provider.emailController.text.trim().isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterEmail);
                            } else if (isValid == false) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterValidEmail);
                            } else if (provider.passwordController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterPwd);
                            } else if (provider.passwordController.text
                                    .trim()
                                    .length <
                                8) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterMin8Digit);
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.verifiedPage);
                            }
                          },
                          child: AppButtons.elevatedButton(
                              AppStrings.strSignUp.toUpperCase(),
                              AppFonts.poppinsFont(TextStyle(
                                  fontSize: AppFontSize.font14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorWhite)),
                              AppColors.primaryColorBlue),
                        ),
                        SizedBox(height: AppFontSize.font22),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                color: AppColors.infoPageCount,
                                height: 1,
                                width:
                                    MediaQuery.of(context).size.width / 10.5),
                            SizedBox(width: AppFontSize.font4),
                            Text(AppStrings.strSignUpWithSocial,
                                textAlign: TextAlign.end,
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontSize: AppFontSize.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.infoPageCount))),
                            SizedBox(width: AppFontSize.font4),
                            Container(
                                color: AppColors.infoPageCount,
                                height: 1,
                                width:
                                    MediaQuery.of(context).size.width / 10.5),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () {
                                    // signProvider.dialogBoxApp(context, "1", "Z6umrOGgA5fFfGokqhPcwXVjeN42");
                                    signProvider.facebookSignInOrSignUp(context);
                                  },
                                  child: mediaImage(AppImages.fbLogoImg)),



                              InkWell(
                                  onTap: () {
                                    // signProvider.dialogBoxApp(context, "1", "Z6umrOGgA5fFfGokqhPcwXVjeN42");
                                    signProvider.appleSignInOrSignUp(context);
                                  },
                                  child: Container(
                                    height: AppFontSize.font60,
                                    width: AppFontSize.font60,
                                    decoration: BoxDecoration(
                                        color: AppColors.secondaryColorWhite,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500))),
                                    child: Center(
                                      child: Image(
                                        image:
                                            AssetImage(AppImages.appleLogoImg),
                                        height: AppFontSize.font40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                              ),
                              InkWell(
                                  onTap: () {
                                    signProvider.getFcmToken();
                                    signProvider.signInOrSignUpGoogle(context);
                                  },
                                  child: mediaImage(AppImages.googleLogoImg)),
                              InkWell(
                                  onTap: () {
                                    signProvider.twitterSignInOrSignUp(context);
                                  },
                                  child: mediaImage(AppImages.twitterXLogoImg)),
                            ]),
                        SizedBox(height: AppFontSize.font30),
                        Text.rich(TextSpan(
                            text: AppStrings.strAlReadyAccount,
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
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          AppRoutes.loginPage,
                                          (route) => false);
                                    })
                            ])),
                        SizedBox(height: AppFontSize.font4),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: signProvider.isLoading,
                  child: Scaffold(
                      backgroundColor: Colors.black45,
                      body: Center(
                        child: CircularProgressIndicator(),
                      )))
            ],
          ),
        );
      });
    });
  }

  Widget mediaImage(imgName) {
    return Image(
      image: AssetImage(imgName),
      height: AppFontSize.font60,
      width: AppFontSize.font60,
      fit: BoxFit.fill,
    );
  }

  Widget textFieldContainer(
      CreateProfileProvider provider, controller, hintText) {
    return Container(
      height: AppFontSize.font45,
      decoration: BoxDecoration(
          color: AppColors.secondaryColorWhite,
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Center(
        child: TextFormField(
            obscureText: controller == provider.emailController
                ? false
                : provider.isShowPassword,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: EdgeInsets.fromLTRB(14, 10, 10, 10),
                hintStyle: AppFonts.poppinsFont(TextStyle(
                    fontSize: AppFontSize.font14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.infoPageCount)),
                suffixIcon: controller == provider.passwordController
                    ? Align(
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
                        )
                )
                    : Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: Colors.white,
                        ),
                      ))),
      ),
    );
  }
}
