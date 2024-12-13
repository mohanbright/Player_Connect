import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/contact_suport_page_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:provider/provider.dart';

class ReportDialog extends StatelessWidget {
  ReportDialog(String? userName, String? userId, int? reportedUserId,
      {Key? key})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer<ContactSupportPageProvider>(
        builder: (context, provider, child) {
          return AlertDialog(
            backgroundColor: AppColors.bgColor,
            title: Text(
              'Report User',
              style: AppFonts.mazzardFont(TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColorBlue,
                  fontSize: AppFontSize.font16)),
            ),
            content: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppFontSize.font10,
                    horizontal: AppFontSize.font20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppFontSize.font8),
                    provider.buildText(AppStrings.strQuery),
                    SizedBox(height: AppFontSize.font12),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                              hintText: 'Report User',
                              contentPadding:
                                  const EdgeInsets.fromLTRB(14, 14, 10, 10),
                              hintStyle: AppFonts.poppinsFont(TextStyle(
                                  fontSize: AppFontSize.font16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.infoPageCount)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a report';
                              }
                              return null;
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop();
                    AppSnackBarToast.buildShowSnackBar(
                        context, 'You have reported the User');
                  }
                },
                child: Text(
                  AppStrings.strDone,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColorBlue)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
