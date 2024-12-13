// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player_connect/setting_dir/services/editProfileService.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

import '../../shared/auth/routes.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController emailController =
      TextEditingController(text: UserDetails.userEmail);
  TextEditingController firstNameController =
      TextEditingController(text: UserDetails.firstName);
  TextEditingController lastNameController =
      TextEditingController(text: UserDetails.lastName);
  TextEditingController phoneNumController =
      TextEditingController(text: UserDetails.userPhone);
  TextEditingController textAreaController =
      TextEditingController(text: UserDetails.userInfo);
  TextEditingController dobController =
      TextEditingController(text: UserDetails.userDob!.split(" ").first);
  TextEditingController locationController =
      TextEditingController(text: UserDetails.userLocation);
  TextEditingController feetHeightController =
      TextEditingController(text: UserDetails.userHeight!.split("'").first);
  TextEditingController inchFeetController = TextEditingController(
      text: UserDetails.userHeight!.split("''").first.split("'").last);
  TextEditingController desiredPartnerController =
      TextEditingController(text: UserDetails.userDesiredPartner);
  TextEditingController playingStyleController =
      TextEditingController(text: UserDetails.userPlayingStyle);

  String selectedGender = int.parse(UserDetails.userGender.toString()) == 0
      ? "Male"
      : int.parse(UserDetails.userGender.toString()) == 1
          ? "Female"
          : "Others";

  bool isUtrRating = UserDetails.isUtr!;
  bool isDiamondHand =
      UserDetails.userDominantHand.toString() == "Left" ? true : false;
  DateTime selectedDate = DateTime.now();
  String? userDob;

  String? userImg = UserDetails.userPhoto!;
  File? image;

  double userUtrRating = 4;
  double userNtrpRating = 3;
  double userMaxDrivDis = 10;
  bool expanded = false;
  int ratingListIndex = -1;
  bool isLocationLoading = false;
  String? _currentAddress = UserDetails.userLocation;
  Position? _currentPosition;
  String selectedCountry = "United States of America";
  String countryCode = "+1";
  String countryFlag = "flags/usa.png";
  bool isLoading = false;
  int age = int.parse(UserDetails.userDob!.split(" ").last);
  String? userCmHeight;
  bool isChanged = false;
  bool isPhotoChanged = false;

  getRatingIndex(int index) {
    if (ratingListIndex == index) {
      ratingListIndex = -1;
      notifyListeners();
    } else {
      ratingListIndex = index;
      notifyListeners();
    }
    notifyListeners();
  }

  getBoolUtrRating(value) {
    isUtrRating = value;
    notifyListeners();
  }

  getBoolDiamondHand(value) {
    isDiamondHand = value;
    notifyListeners();
  }

  setUserUtrRating(double value) {
    userUtrRating = value;
    notifyListeners();
  }

  List ntrpList = [
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0,
    5.5,
    6.0,
  ];

  List descriptionList = [
  "This player is just starting to play terms.",
  "This player has had limited experience with stroke development and is still working primarily on getting the ball play. This player is not yet ready to compete.",
  "This player needs on-court experience, with an emphasis on play. This player struggles to find an appropriate contact point, needs stroke development/lessons and is not yet familiar with basic positions for singles and doubles.",
  "This player is learning to judge where the oncoming ball is going and how much swing is needed to return it consistently. Movement to the ball and recovery are often not efficient. Can sustain a backcourt rally of slow pace with other players of similar ability and is beginning to develop strokes.This player is becoming more familiar with the basic positions for singles and doubles, and is ready to play social matches, leagues and low-level tournaments.Potential limitations: grip weaknesses; limited swing and inconsistent toss on serve; limited transitions to the net.",
  "This player is fairly consistent when hitting medium-paced shots, but is not comfortable with all strokes and lacks accuracy when trying for directional control, depth, pace or altering distance of shots. Most common double formation is one up, one back.Potential limitations: inconsistency when applying or handling pace; difficulty handling shots outside of their strike zone;  can be uncomfortable at the net.",
  "This player has achieved stroke dependability with directional control on moderate shots, but still lacks depth, variety and the ability to alter distance of shots. The effective use of lobs, Overheads, approach shots, and volleys is limited. This player is more comfortable at the net, has improved court awareness, and is developing teamwork in doubles.Potential strengths: Players can generally rally from the baseliner opposite a net player. Players at this level may start utilize mental skills related to concentration, tactics and strategy.",
  "This player has dependable strokes with directional control and the ability to alter depth of shots on both forehand and backhand sides during moderately paced play. This player has the ability to use lobs, overheads, approach shots, and volleys with success. This player occasionally force errors when serving. Points may be lost due to impatience. Teamwork in doubles is evident.Potentials strengths: dependable second serve; recognizes opportunities to finish points.",
  "This player can vary the use of pace and spins, has effective court coverage, can control depth of shots, and is able to develop game plans according to strengths and weaknesses. This player can hit the first serve with power and accuracy and can place the second serve. This player tends to Overhit on difficult shots. Aggressive net play is common in doubles.Potential strengths: points are frequently won off the serve or return of serve; able to offset weaknesses; may have a weapon around which their game can be built.",
  "This player has good shot anticipation and frequently has an outstanding shot or attribute around which his or her game can be structured. This player can regularly hit winners or force errors off of short balls and put away volleys. He or she can successfully execute lobs, drop shots, half volleys, overheads, and has good depth and spin on most second serves.Potential strengths : covers and disguises weaknesses well; can hit offensive volleys and half-volleys from mid-court; can employ physical or mental fitness as a weapon.",
  "This player has developed pace and/or consistency as a major weapon. This player can vary strategies and styles of play in competitive situations and hit dependable shots in stress situations.Strengths: can hit offensively at any time; can vary strategies and styles of play in competitive situations; first and second serves can be depended upon in stress situations.",
  "The 6.0 player typically has had intensive training for national tournaments or top level collegiate competition, and has obtained a national ranking. The 6.5 and 7.0 are world-class players.",
  ];


  List playingStyleList = [
    1,
    2,
    3,
    4,
  ];

  List playingStyleTitlesList = [
    "Aggressive Baseliner",
    "Counter-Puncher",
    "Serve and Volley",
    "All Court",
  ];

  List playingStyleDescriptionList = [
    "This style of play is all about powerful groundstrokes. Forehand and backhand from the service line by these players can be devastatingly fast. They play an attacking style of the game, unlike the defenders. These players do not prefer playing near the net as volleys and shot balls are not their strengths. International players use the geometry of the court and chalk out a sharp strategy to attack their opponent player. Players with this style dictate the game and are known for their unforced errors as they are risk-takers. They make the opponent run around the court with their shots.",
    "Players with this style of game are great defenders. Consistent defense is the primary skill these players have. They are also called pushers for their defensive play. They never hit winners aggressively but are fast in terms of court coverage. They are really good with lobs and have great movement and agility. These players need to work on their stamina and form. They are quite tough to play against as they have great placement techniques.",
    "This playing style is mostly seen in players who are tall. The strengths of these players are their serves and their shot balls. They mostly finish the points at the net in the first few rallies themselves. Players with this style of game thrive on grass courts and hence are a rarity. An ace serve and accurate footwork are two things players have with this style of game.",
    "These players are comfortable with all kinds of shots and play strategically based on the kind of player the opponent is. They play shots that exploit the opponent’s weaknesses. Instead of mastering a particular shot, all-court players learn to use every shot efficiently to their advantage. This makes them tough opponents.",
   ];


  Widget buildText(title) {
    return Text(title,
        style: AppFonts.mazzardFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColorBlack,
            fontSize: AppFontSize.font14)));
  }




  Widget textFieldContainer(
      EditProfileProvider provider, hintText, controller, maxLines,
      {prefix}) {
    bool isFirstChange = true;

    return Container(
      // height: AppFontSize.font45,
      decoration: BoxDecoration(
          color: AppColors.secondaryColorWhite,
          border: Border.all(color: AppColors.secondaryColorBlack, width: 1),
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Center(
        child:
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.fromLTRB(14, 10, 10, 11),
            hintStyle: TextStyle(
              fontSize: AppFontSize.font14,
              fontWeight: FontWeight.w400,
              color: AppColors.infoPageCount,
            ),
          ),
          onChanged: (value) {
            if (isFirstChange) {
              if (value.isNotEmpty) {
                String capitalized = value.substring(0, 1).toUpperCase() +
                    value.substring(1).toLowerCase();
                if (value != capitalized) {
                  controller.value = controller.value.copyWith(
                    text: capitalized,
                    selection: TextSelection.collapsed(offset: capitalized.length),
                  );
                }
              }
              isFirstChange = false;

            }
          },
        ),




      ),
    );
  }

  Widget genderContainer(img, text) {
    return InkWell(
      onTap: () {
        selectedGender = text;
        notifyListeners();
      },
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: AppFontSize.font100,
        width: AppFontSize.font100,
        decoration: BoxDecoration(
            color: selectedGender == text
                ? AppColors.primaryColorSkyBlue
                : AppColors.secondaryColorLightGrey,
            borderRadius: BorderRadius.circular(AppFontSize.font32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage(img),
                height: AppFontSize.font45,
                width: AppFontSize.font45,
              ),
            ),
            SizedBox(height: AppFontSize.font8),
            Text(text,
                style: AppFonts.poppinsFont(TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColorBlack,
                    fontSize: AppFontSize.font14)))
          ],
        ),
      ),
    );
  }

  Future selectDobDate(context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: "Select DOB",
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
      var dateTime = DateTime.parse(selectedDate.toString());
      var formatDate = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
      dobController = TextEditingController(text: formatDate);
      var ageDiff = DateTime.now().year - selectedDate.year;
      age = ageDiff;
      notifyListeners();
    }
  }

  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppSnackBarToast.buildShowSnackBar(context,
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppSnackBarToast.buildShowSnackBar(
            context, 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AppSnackBarToast.buildShowSnackBar(context,
          'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      notifyListeners();
      getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // Future<void> getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     _currentAddress =
  //         '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //     locationController.text = _currentAddress!;
  //     notifyListeners();
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String city = place.locality ?? place.subLocality ?? 'Unknown location';
        String country = place.country ?? 'Unknown country';

        LocalDataSaver.saveUserLatitude(position.latitude.toString());
        LocalDataSaver.saveUserLongitude(position.longitude.toString());
        fetchDataSPreferences();

        print(UserDetails.userLatitude);
        print(UserDetails.userLongitude);

        // Combine city and country into a single string
        _currentAddress = '$city, $country';
        locationController.text = _currentAddress!;
        notifyListeners();
        fetchDataSPreferences();
      } else {
        debugPrint("No placemarks found");
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
    }
  }


  Future<void> profileImage(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () async {
                            getImageFile(ImageSource.camera, context);
                          },
                          child: Icon(Icons.photo_camera))),
                  Expanded(
                      child: InkWell(
                          onTap: () async {
                            getImageFile(ImageSource.gallery, context);
                          },
                          child: Icon(Icons.photo_library_outlined))),
                ],
              ),
            ),
          );
        });
  }


  Future<void> getImageFile(ImageSource source, BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile == null) {
        AppSnackBarToast.buildShowSnackBar(context, "No image selected");
        return;
      }

      debugPrint("Picked file path: ${pickedFile.path}");

      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop your image',
            aspectRatioLockEnabled: false,
          ),
        ],
        maxWidth: 200,
        maxHeight: 200,
      );

      if (croppedImage != null) {
        final File imageFile = File(croppedImage.path);
        image = imageFile;
        userImg = imageFile.path;
        debugPrint("Cropped image path: ${croppedImage.path}");
        fetchDataSPreferences();
        isPhotoChanged = true;
      } else {
        AppSnackBarToast.buildShowSnackBar(context, "Image cropping failed");
      }

      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      Navigator.pop(context);
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      debugPrint("Image picking failed: $e");
    }
  }





  void initCountry(context) async {
    final country = await getDefaultCountry(context);
    countryFlag = country.flag;
    selectedCountry = country.name.toString();
    notifyListeners();
  }

  void showCountryPicker(context) async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      countryFlag = country.flag;
      countryCode = country.callingCode;
      selectedCountry = country.name.toString();
      // phoneNumController.text=country.callingCode;
      notifyListeners();
    }
  }

  getHeightCm() {
    if (feetHeightController.text.trim().isNotEmpty &&
        inchFeetController.text.trim().isNotEmpty) {
      double heightInCm =
          (double.parse(feetHeightController.text.trim()) * 30.48) +
              (double.parse(inchFeetController.text.trim()) * 2.54);
      userCmHeight = heightInCm.toString();
      notifyListeners();
    }
  }

  editUserProfileData(context, index) async {
    isLoading = true;
    notifyListeners();
    try{
      await EditProfileService.getInstance().editProfile(
        context,
        index,
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text,
        selectedCountry,
        phoneNumController.text.trim(),
        isPhotoChanged == true ? image! : File("null"),
        "${dobController.text} $age",
        "${feetHeightController.text}'${inchFeetController.text}'' ($userCmHeight cm)",
        countryFlag.toString(),
        selectedGender.toString() == "Male"
            ? 0
            : selectedGender.toString() == "Female"
            ? 1
            : 2,
        isUtrRating ? 0 : 1,
        isUtrRating ? userUtrRating.toString() : userNtrpRating.toString(),
        locationController.text,
        textAreaController.text,
        desiredPartnerController.text,
        playingStyleController.text,
        isDiamondHand ? "Left" : "Right",
        int.parse(userMaxDrivDis.toStringAsFixed(0)),
      );
      isLoading = false;
      notifyListeners();
    }catch(e){
      print(e);
      isLoading = false;
      notifyListeners();
    } finally{
      isLoading = false;
      notifyListeners();
    }

  }

  AppBar buildAppBar(BuildContext context, int index) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: AppColors.secondaryColorWhite,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColorBlue,
              borderRadius: BorderRadius.circular(12)),
          child: InkWell(
              onTap: () {
                if (index == 2) {
                  getHeightCm();
                  editUserProfileData(context, index);

                  pageSelected = 0;
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.dashBoardPage, (route) => false);
                } else {
                  editUserProfileData(context, index);

                  pageSelected = 0;
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.dashBoardPage, (route) => false);


                }
              },
              child: Center(child: Text("Done",
    style: AppFonts.mazzardFont(TextStyle(
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryColorWhite,
    fontSize: AppFontSize.font12),),

              ))),
        ),
      ),
      iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
      centerTitle: true,
      title: Text(AppStrings.strEditProfile,
          style: AppFonts.mazzardFont(TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font16))),
    );
  }

  void openDropdown(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        AppFontSize.font20,
        AppFontSize.font180,
        AppFontSize.font20,
        AppFontSize.font20,
      ),
      items: [
        PopupMenuItem(value: "All court", child: Text("All court")),
        PopupMenuItem(
            value: "Agressive baseliner", child: Text("Agressive baseliner")),
        PopupMenuItem(
            value: "Serve and volley", child: Text("Serve and volley")),
        PopupMenuItem(value: "Counter-puncher", child: Text("Counter-puncher")),
      ],
    ).then((value) {
      if (value != null) {
        playingStyleController = TextEditingController(text: value.toString());
        notifyListeners();
      }
    });
  }
}
