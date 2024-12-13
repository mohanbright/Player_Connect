import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/alert_box.dart';
import 'package:provider/provider.dart';

class EditProfilePage4 extends StatefulWidget {
  const EditProfilePage4({Key? key}) : super(key: key);

  @override
  State<EditProfilePage4> createState() => _EditProfilePage4State();
}

class _EditProfilePage4State extends State<EditProfilePage4> {
  double _sliderValue = 1.0;

  List<Map<String, double>> predefinedRanges = [
    {'min': 1.0, 'max': 3.0},
    {'min': 3.0, 'max': 6.0},
    {'min': 6.0, 'max': 9.0},
    {'min': 9.0, 'max': 12.0},
    {'min': 12.0, 'max': 15.0},
    {'min': 15.0, 'max': 16.5},
  ];

  Map<String, double> _currentRange = {'min': 1.0, 'max': 3.0};

  void _updateRange(Map<String, double> selectedRange) {
    setState(() {
      _currentRange = selectedRange;
      _sliderValue = selectedRange['min']!;
    });
  }

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
                appBar: provider.buildAppBar(context, 4),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppFontSize.font12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.buildText(AppStrings.strHaveUtr),
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: RadioListTile(
                                contentPadding: const EdgeInsets.all(0),
                                visualDensity: VisualDensity.compact,
                                activeColor: AppColors.primaryColorSkyBlue,
                                title: const Text(AppStrings.strYes),
                                value: true,
                                groupValue: provider.isUtrRating,
                                onChanged: (value) {
                                  provider.getBoolUtrRating(value as bool);
                                  provider.isChanged = true;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: RadioListTile(
                                contentPadding: const EdgeInsets.all(0),
                                activeColor: AppColors.primaryColorSkyBlue,
                                title: const Text(AppStrings.strNo),
                                value: false,
                                groupValue: provider.isUtrRating,
                                onChanged: (value) {
                                  provider.getBoolUtrRating(value as bool);
                                  provider.isChanged = true;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            provider.buildText(provider.isUtrRating
                                ? AppStrings.strUtrRating
                                : AppStrings.strNtrpRating),
                            SizedBox(width: AppFontSize.font4),
                            provider.isUtrRating
                                ? const SizedBox()
                                : Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialogWidget(
                                          provider: provider,
                                        );
                                      },
                                    );
                                  },
                                  child: Image(
                                    image: const AssetImage(
                                        AppIconImages.helpIconImg),
                                    height: AppFontSize.font20,
                                    width: AppFontSize.font20,
                                  ),
                                ),
                                SizedBox(width: AppFontSize.font4),
                                Text(
                                  AppStrings.strNotSureRatingIs,
                                  style: AppFonts.mazzardFont(
                                    TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.infoPageCount,
                                      fontSize: AppFontSize.font12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            provider.isUtrRating
                                ? Text(
                              provider.userUtrRating.toString(),
                              style: AppFonts.poppinsFont(
                                TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14,
                                ),
                              ),
                            )
                                : Text(
                              provider.userNtrpRating.toString(),
                              style: AppFonts.poppinsFont(
                                TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font12),
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: predefinedRanges.map((range) {
                                  bool isSelected = _currentRange == range;

                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () => _updateRange(range),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primaryColorBlue
                                              : AppColors.secondaryColorGrey,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                        child: Text(
                                          '${range['min']} - ${range['max']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Selected Range: ${_currentRange['min']} - ${_currentRange['max']}',
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14)),
                            ),
                            Container(
                              // width: MediaQuery.of(context).size.width -
                              //     (AppFontSize.font24 + AppFontSize.font24),
                              child: CustomSlider(
                                value: _sliderValue,
                                min: _currentRange['min']!,
                                max: _currentRange['max']!,
                                onChanged: (double value) {
                                  setState(() {
                                    _sliderValue = value;
                                  });
                                },
                                onChangeEnd: (value) {
                                  provider.isUtrRating
                                      ? provider.userUtrRating = double.parse(
                                      _sliderValue.toStringAsFixed(1))
                                      : provider.userNtrpRating = double.parse(
                                      _sliderValue.toStringAsFixed(1));
                                  provider.isChanged = true;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            provider.buildText(AppStrings.strMaxDriveDistance),
                            SizedBox(
                              width: 100,
                              height: 25,
                              child: Text(
                                "${provider.userMaxDrivDis} ${AppStrings.strMiles}",
                                style: AppFonts.poppinsFont(
                                  TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColorBlack,
                                    fontSize: AppFontSize.font14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font12),
                        Container(
                          child: CustomSlider(
                            min: 0.0,
                            max: 50.0,
                            value: provider.userMaxDrivDis,
                            onChanged: (value) {
                              provider.userMaxDrivDis = value;
                              provider.isChanged = true;
                              setState(() {});
                            },
                            onChangeEnd: (value) {
                              provider.userMaxDrivDis =
                                  double.parse(value.toStringAsFixed(1));
                              provider.isChanged = true;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(height: AppFontSize.font30),
                        provider.buildText(AppStrings.strDesiredpartner),
                        SizedBox(height: AppFontSize.font12),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColorWhite,
                            border: Border.all(
                              color: AppColors.infoPageCount,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppFontSize.font12,
                            ),
                          ),
                          child: TextFormField(
                            controller: provider.desiredPartnerController,
                            maxLines: 7,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppStrings.strWhatLookingFor,
                              contentPadding:
                              const EdgeInsets.fromLTRB(14, 14, 10, 10),
                              hintStyle: TextStyle(
                                fontSize: AppFontSize.font14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.infoPageCount,
                              ),
                            ),
                            inputFormatters: [
                              TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                  if (newValue.text.isNotEmpty) {
                                    return TextEditingValue(
                                      text: newValue.text
                                          .substring(0, 1)
                                          .toUpperCase() +
                                          newValue.text.substring(1),
                                      selection: newValue.selection,
                                    );
                                  }
                                  return newValue;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppFontSize.font40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: AppButtons.elevatedButton(
                                  AppStrings.strBack.toUpperCase(),
                                  AppFonts.mazzardFont(
                                    TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font14,
                                    ),
                                  ),
                                  AppColors.primaryColorSkyBlue,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (provider.isChanged == true) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.editProfilePage5,
                                  );
                                  provider.isChanged = false;
                                } else {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.editProfilePage5,
                                  );
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: AppButtons.elevatedButton(
                                  AppStrings.strNext.toUpperCase(),
                                  AppFonts.mazzardFont(
                                    TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorWhite,
                                      fontSize: AppFontSize.font14,
                                    ),
                                  ),
                                  AppColors.primaryColorBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: provider.isLoading,
                child: const Scaffold(
                  backgroundColor: Colors.black26,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.value.toStringAsFixed(1);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            min: widget.min,
            max: widget.max,
            value: widget.value,
            activeColor: AppColors.primaryColorBlue,
            thumbColor: AppColors.secondaryColorBlack,
            inactiveColor: AppColors.infoPageCount,
            onChanged: (value) {
              widget.onChanged(value);
              _textEditingController.text = value.toStringAsFixed(0);
            },
            onChangeEnd: (value) {
              widget.onChangeEnd(value);
              _textEditingController.text = value.toStringAsFixed(0);
            },
          ),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 60.0,
          child: TextFormField(
            controller: _textEditingController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
            onChanged: (value) {
              setState(() {
                double parsedValue = double.tryParse(value) ?? widget.value;
                if (parsedValue > widget.max) {
                  parsedValue = widget.max;
                } else if (parsedValue < widget.min) {
                  parsedValue = widget.min;
                }
                widget.onChanged(parsedValue);
                widget.onChangeEnd(parsedValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
