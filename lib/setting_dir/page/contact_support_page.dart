// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/contact_suport_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:provider/provider.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({Key? key}) : super(key: key);

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ContactSupportPageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.secondaryColorWhite,
        iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
        centerTitle: true,
        title: Text(AppStrings.strContactSupport,
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
              provider.buildText(AppStrings.strQuery),
              SizedBox(height: AppFontSize.font12),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.secondaryColorWhite,
                    border: Border.all(
                        color: AppColors.infoPageCount, width: 1),
                    borderRadius:
                        BorderRadius.circular(AppFontSize.font12)),
                child: Center(
                  child: TextFormField(
                      controller: provider.queryController,
                      maxLines: 7,
                      style: AppFonts.poppinsFont(TextStyle(
                          fontSize: AppFontSize.font16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryColorBlack)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            AppStrings.strLoremIpsum,
                        contentPadding: EdgeInsets.fromLTRB(14, 14, 10, 10),
                        hintStyle: AppFonts.poppinsFont(TextStyle(
                            fontSize: AppFontSize.font16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.infoPageCount)),
                      )),
                ),
              ),
              SizedBox(height: AppFontSize.font150),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  AppSnackBarToast.buildShowSnackBar(
                      context, AppStrings.strYouRaisedQuery);
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
        );
      },
    );
  }
}
