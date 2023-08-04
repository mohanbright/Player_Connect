// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  String selectedValue = "Something was broken";
  TextEditingController reasonQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        title: Text(AppStrings.strDeleteAccount,
            style: AppFonts.mazzardFont(TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.systemColorRed,
                fontSize: AppFontSize.font18))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppFontSize.font10, horizontal: AppFontSize.font14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.strOnceAccountDeleted,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack,
                      fontSize: AppFontSize.font14))),
              SizedBox(height: AppFontSize.font16),
              Text(AppStrings.strMayIKnowReason,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack,
                      fontSize: AppFontSize.font14))),
              SizedBox(height: AppFontSize.font16),
              buildRadioListTile(AppStrings.strSomethingBroken),
              buildRadioListTile(AppStrings.strNotReceivingPlaying),
              buildRadioListTile(AppStrings.strPrivacyConcern),
              buildRadioListTile(AppStrings.strOther),
              SizedBox(height: AppFontSize.font16),
              Text(AppStrings.strOtherReason,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font8),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.secondaryColorWhite,
                    border:
                        Border.all(color: AppColors.infoPageCount, width: 1),
                    borderRadius: BorderRadius.circular(AppFontSize.font12)),
                child: Center(
                  child: TextFormField(
                      controller: reasonQueryController,
                      maxLines: 7,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppStrings.strWriteQuery,
                        contentPadding: EdgeInsets.fromLTRB(14, 14, 10, 10),
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
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(AppStrings.strDeleteAccount),
                      content: Text(AppStrings.strSureToDeleteAcc),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strAccountDeletedSucc);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.loginPage, (route) => false);
                            },
                            child: Text(AppStrings.strYes)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text(AppStrings.strNo)),
                      ],
                    ),
                  );
                },
                child: AppButtons.elevatedButton(
                    AppStrings.strDeleteAccount,
                    AppFonts.poppinsFont(TextStyle(
                        fontSize: AppFontSize.font16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColorWhite)),
                    AppColors.systemColorRed),
              )
            ],
          ),
        ),
      ),
    ));
  }

  RadioListTile<String> buildRadioListTile(title) {
    return RadioListTile(
      contentPadding: EdgeInsets.all(0),
      visualDensity: VisualDensity.compact,
      activeColor: AppColors.primaryColorSkyBlue,
      title: Text(
        title,
        style: AppFonts.poppinsFont(TextStyle(
            fontSize: AppFontSize.font16,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColorBlack)),
      ),
      value: title,
      groupValue: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = title;
        });
      },
    );
  }
}
