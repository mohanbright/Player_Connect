// ignore_for_file: await_only_futures

import 'package:player_connect/shared/constant/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  static String idKey = "ID Key";
  static String nameKey = "Name Key";
  static String emailKey = "Email Key";
  static String dobKey = "DOB Key";
  static String locationKey = "Location Key";
  static String phoneKey = "Phone Key";
  static String photoKey = "Photo Key";
  static String passwordKey = "Password Key";
  static String genderKey = "Gender Key";
  static String utrKey = "Utr Key";
  static String ntrpKey = "Ntrp Key";
  static String dominantHandKey = "Dominant Hand Key";
  static String playingStyleKey = "Playing Style Key";
  static String infoKey = "Info Key";
  static String authTokenKey = "Auth Token Key";
  static String fcmTokenKey = "Fcm Token Key";
  static String splashPageKey = "Splash Page Key";
  static String logKey = "Log Key";

  static String firstNameKey = "First Name Key";
  static String lastNameKey = "Last Name Key";
  static String aboutKey = "About Key";
  static String ageKey = "Age Key";
  static String countryKey = "Country Key";
  static String countryFlagKey = "Country Flag Key";
  static String heightKey = "Height Key";
  static String latitudeKey = "Latitude Key";
  static String longtitudeKey = "Longtitude Key";
  static String isUtrKey = "Is Utr Key";
  static String maxDisKey = "Max Dis Key";
  static String desPartKey = "Des Part Key";
  static String cmHeightKey = "Cm Height Key";
  static String isEmailNotifyKey = "Email Notify Key";
  static String isPhoneNotifyKey = "Phone Notify  Key";
  static String isAppNotifyKey = "App Notify Key";

  static Future<bool> saveUserID(String? userID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(idKey, userID!);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(idKey);
  }

  static Future<bool> saveUserName(String? userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nameKey, userName!);
  }

  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(nameKey);
  }

  static Future<bool> saveUserEmail(String? userEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(emailKey, userEmail!);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(emailKey);
  }

  static Future<bool> saveUserDob(String? userDob) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(dobKey, userDob!);
  }

  static Future<String?> getUserDob() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(dobKey);
  }

  static Future<bool> saveUserLocation(String? userLocation) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(locationKey, userLocation!);
  }

  static Future<String?> getUserLocation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(locationKey);
  }

  static Future<bool> saveUserPhone(String? userPhone) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(phoneKey, userPhone!);
  }

  static Future<String?> getUserPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(phoneKey);
  }

  static Future<bool> saveUserPhoto(String? userPhoto) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(photoKey, userPhoto!);
  }

  static Future<String?> getUserPhoto() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(photoKey);
  }

  static Future<bool> saveUserPassword(String? userPassword) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(passwordKey, userPassword!);
  }

  static Future<String?> getUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(passwordKey);
  }

  static Future<bool> saveUserGender(String? userGender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(genderKey, userGender!);
  }

  static Future<String?> getUserGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(genderKey);
  }

  static Future<bool> saveUserUtr(String? userUtr) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(utrKey, userUtr!);
  }

  static Future<String?> getUserUtr() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(utrKey);
  }

  static Future<bool> saveUserNtrp(String? userNtrp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ntrpKey, userNtrp!);
  }

  static Future<String?> getUserNtrp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ntrpKey);
  }

  static Future<bool> saveUserPlayingStyle(String? userPlayingStyle) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(playingStyleKey, userPlayingStyle!);
  }

  static Future<String?> getUserPlayingStyle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(playingStyleKey);
  }

  static Future<bool> saveUserInfo(String? userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(infoKey, userInfo!);
  }

  static Future<String?> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(infoKey);
  }

  static Future<bool> saveUserAuthToken(String? userAuthToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(authTokenKey, userAuthToken!);
  }

  static Future<String?> getUserAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(authTokenKey);
  }

  static Future<bool> saveUserFcmToken(String? userFcmToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(fcmTokenKey, userFcmToken!);
  }

  static Future<String?> getUserFcmToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(fcmTokenKey);
  }

  static Future<bool> saveUserSplashData(bool? isSplashPage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(splashPageKey, isSplashPage!);
  }

  static Future<bool?> getUserSplashData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(splashPageKey);
  }

  static Future<bool> saveUserLogData(bool? isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(logKey, isUserLoggedIn!);
  }

  static Future<bool?> getUserLogData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(logKey);
  }

  static Future<bool> saveUserFirstName(String? firstName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(firstNameKey, firstName!);
  }

  static Future<String?> getUserFirstName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(firstNameKey);
  }

  static Future<bool> saveUserLastName(String? lastName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(lastNameKey, lastName!);
  }

  static Future<String?> getUserLastName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(lastNameKey);
  }

  static Future<bool> saveUserCountryName(String? countryName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(countryKey, countryName!);
  }

  static Future<String?> getUserCountryName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(countryKey);
  }

  static Future<bool> saveUserCountryFlag(String? countryFlag) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(countryFlagKey, countryFlag!);
  }

  static Future<String?> getUserCountryFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(countryFlagKey);
  }

  static Future<bool> saveUserHeight(String? height) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(heightKey, height!);
  }

  static Future<String?> getUserHeight() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(heightKey);
  }

  static Future<bool> saveUserLatitude(String? latitude) async {
    print('Save User Latitude Issue :- $latitude');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(latitudeKey, latitude!);
  }

  static Future<String?> getUserLatitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(latitudeKey);
  }

  static Future<bool> saveUserLongitude(String? longitude) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(longtitudeKey, longitude!);
  }

  static Future<String?> getUserLongitude() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(longtitudeKey);
  }

  static Future<bool> saveUserAge(String? age) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(ageKey, age!);
  }

  static Future<String?> getUserAge() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(ageKey);
  }

  static Future<bool> saveUserHeightCm(String? cm) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(cmHeightKey, cm!);
  }

  static Future<String?> getUserHeightCm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(cmHeightKey);
  }

  static Future<bool> saveUserDriDis(String? driDis) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(maxDisKey, driDis!);
  }

  static Future<String?> getUserDriDis() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(maxDisKey);
  }

  static Future<bool> saveUserDesPart(String? desP) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(desPartKey, desP!);
  }

  static Future<String?> getUserDesPart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(desPartKey);
  }

  static Future<bool> saveUserIsUtr(bool? isUtr) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isUtrKey, isUtr!);
  }

  static Future<bool?> getUserIsUtr() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(isUtrKey);
  }

  static Future<bool> saveUserIsDominant(bool? userDominantHand) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(dominantHandKey, userDominantHand!);
  }

  static Future<bool?> getUserIsDominant() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(dominantHandKey);
  }

  static Future<bool> saveUserIsEmailNotify(bool? isEmailNotify) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isEmailNotifyKey, isEmailNotify!);
  }

  static Future<bool?> getUserIsEmailNotify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(isEmailNotifyKey);
  }

  static Future<bool> saveUserIsPhoneNotify(bool? isPhoneNotify) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isPhoneNotifyKey, isPhoneNotify!);
  }

  static Future<bool?> getUserIsPhoneNotify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(isPhoneNotifyKey);
  }

  static Future<bool> saveUserIsAppNotify(bool? isAppNotify) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isAppNotifyKey, isAppNotify!);
  }

  static Future<bool?> getUserIsAppNotify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(isAppNotifyKey);
  }
}

// isUtrKey

Future fetchDataSPreferences() async {
  UserDetails.userID = await LocalDataSaver.getUserID();
  UserDetails.userName = await LocalDataSaver.getUserName();
  UserDetails.userEmail = await LocalDataSaver.getUserEmail();
  UserDetails.userDob = await LocalDataSaver.getUserDob();
  UserDetails.userLocation = await LocalDataSaver.getUserLocation();
  UserDetails.userPhone = await LocalDataSaver.getUserPhone();
  UserDetails.userPhoto = await LocalDataSaver.getUserPhoto();
  UserDetails.userPassword = await LocalDataSaver.getUserPassword();
  UserDetails.userGender = await LocalDataSaver.getUserGender();
  UserDetails.userUtr = await LocalDataSaver.getUserUtr();
  UserDetails.userNtrp = await LocalDataSaver.getUserNtrp();
  UserDetails.userPlayingStyle = await LocalDataSaver.getUserPlayingStyle();
  UserDetails.userInfo = await LocalDataSaver.getUserInfo();
  UserDetails.userAuthToken = await LocalDataSaver.getUserAuthToken();
  UserDetails.userFcmToken = await LocalDataSaver.getUserFcmToken();

  UserDetails.firstName = await LocalDataSaver.getUserFirstName();
  UserDetails.lastName = await LocalDataSaver.getUserLastName();
  UserDetails.userCountry = await LocalDataSaver.getUserCountryName();
  UserDetails.countryFlag = await LocalDataSaver.getUserCountryFlag();
  UserDetails.userHeight = await LocalDataSaver.getUserHeight();
  UserDetails.age = await LocalDataSaver.getUserAge();
  UserDetails.cmHeight = await LocalDataSaver.getUserHeightCm();
  UserDetails.userLocation = await LocalDataSaver.getUserLocation();
  UserDetails.userLatitude = await LocalDataSaver.getUserLatitude();
  UserDetails.userLongitude = await LocalDataSaver.getUserLongitude();
  UserDetails.isUtr = await LocalDataSaver.getUserIsUtr();
  UserDetails.desPart = await LocalDataSaver.getUserDesPart();
  UserDetails.driDis = await LocalDataSaver.getUserDriDis();
  // UserDetails.userRating = await LocalDataSaver.getUserDriDis();
  UserDetails.userDesiredPartner = await LocalDataSaver.getUserDesPart();
  UserDetails.userDominantHand = await LocalDataSaver.getUserIsDominant();
  UserDetails.isEmailNotify = await LocalDataSaver.getUserIsEmailNotify();
  UserDetails.isPhoneNotify = await LocalDataSaver.getUserIsPhoneNotify();
  UserDetails.isAppNotify = await LocalDataSaver.getUserIsAppNotify();
}

clearDataSPreferences() async {
  UserDetails.userID = null;
  UserDetails.userName = null;
  UserDetails.userEmail = null;
  UserDetails.userDob = null;
  UserDetails.userLocation = null;
  UserDetails.userPhone = null;
  UserDetails.userPhoto = null;
  UserDetails.userPassword = null;
  UserDetails.userGender = null;
  UserDetails.userUtr = null;
  UserDetails.userNtrp = null;
  UserDetails.userDominantHand = null;
  UserDetails.userPlayingStyle = null;
  UserDetails.userInfo = null;
  UserDetails.userAuthToken = null;
  UserDetails.userFcmToken = null;
}

Future removeDataSPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove("ID Key");
  await preferences.remove("Name Key");
  await preferences.remove("Email Key");
  await preferences.remove("DOB Key");
  await preferences.remove("Location Key");
  await preferences.remove("Phone Key");
  await preferences.remove("Photo Key");
  await preferences.remove("Password Key");
  await preferences.remove("Gender Key");
  await preferences.remove("Utr Key");
  await preferences.remove("Ntrp Key");
  await preferences.remove("Dominant Hand Key");
  await preferences.remove("Playing Style Key");
  await preferences.remove("Info Key");
  await preferences.remove("Log Key");
  await preferences.remove("Auth Token Key");
  await preferences.remove("Fcm Token Key");
  await preferences.remove("First Name Key");
  await preferences.remove("Last Name Key");
  await preferences.remove("About Key");
  await preferences.remove("Age Key");
  await preferences.remove("Country Key");
  await preferences.remove("Country Flag Key");
  await preferences.remove("Height Key");
  await preferences.remove("Is Utr Key");
  await preferences.remove("Max Dis Key");
  await preferences.remove("Des Part Key");
  await preferences.remove("Cm Height Key");
  await preferences.remove("Email Notify Key");
  await preferences.remove("Phone Notify Key");
  await preferences.remove("App Notify Key");
  await preferences.clear();
}
