import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'dart:convert';
import '../model/get_user_profile_model.dart';

class MyProfileProvider with ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse(AppApiUtils.getUserProfileUrl),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken}',
        },
      );
// print("fetchUserProfile responseBody::${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final userProfileData = data['body'];
        _userProfile = UserProfile(
          id: userProfileData['id'],
          firstName: userProfileData['first_name'],
          lastName: userProfileData['last_name'],
          email: userProfileData['email'],
          phone: userProfileData['phone'],
          country: userProfileData['country'],
          countryCode: userProfileData['country_code'],
          loginTime: userProfileData['loginTime'],
          images: userProfileData['images'] ?? '',
          gender: userProfileData['gender'],
          dob: userProfileData['dob'],
          password: userProfileData['password'],
          role: userProfileData['role'],
          height: userProfileData['height'],
          about: userProfileData['about'],
          city: userProfileData['city'],
          desiredPartner: userProfileData['desired_partner'],
          ratingtype: userProfileData['ratingtype'],
          rating: userProfileData['rating'],
          playingStyle: userProfileData['playingstyle'],
          dominantHand: userProfileData['dominnant_hand'],
          countryFlag: userProfileData['country_flag'],
          createdAt: userProfileData['createdAt'],
          updatedAt: userProfileData['updatedAt'],
          locationRange: userProfileData['location_range'],
        );
        LocalDataSaver.saveUserPhoto(AppApiUtils.imageUrl+userProfileData["images"].toString());
        await fetchDataSPreferences();

        notifyListeners();
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (error) {
      rethrow;
    }
  }
}
