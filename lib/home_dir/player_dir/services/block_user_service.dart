import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class BlockUserApiService {
  static BlockUserApiService? _instance;

  BlockUserApiService._internal();

  static BlockUserApiService getInstance() {
    _instance ??= BlockUserApiService._internal();
    return _instance!;
  }

/* ==============================================Block User Api================================================*/



  Future<bool> blockUser(BuildContext context, String blockedUserId) async {
    try {
      print('Data Blocking: - $blockedUserId, ${UserDetails.userAuthToken}');

      var response = await http.post(
        // Uri.parse(AppApiUtils.blockUserApi),
        Uri.parse('http://18.220.106.62:3000/block-user'),
        headers: {
          "Authorization": "Bearer ${UserDetails.userAuthToken!}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "blockedUserId": blockedUserId,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);

        var message = responseBody['message'] ?? 'No message received';

        print('Response Message: $message');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: responseBody['success'] == true ? Colors.green : Colors.red,
          ),
        );

        return responseBody['success'] == true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected response status: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }




  /* ============================================== UnBlock User Api================================================*/


  Future<bool> unblockUser(BuildContext context, String blockedUserId) async {
    try {
      print('Data Unblocking: - $blockedUserId, ${UserDetails.userAuthToken}');

      var response = await http.post(
        Uri.parse('http://18.220.106.62:3000/unblock-user'),
        headers: {
          "Authorization": "Bearer ${UserDetails.userAuthToken!}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "blockedUserId": blockedUserId,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('Response Headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        var message = responseBody['message'] ?? 'No message received';

        print('Response Message: $message');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: responseBody['success'] == true ? Colors.green : Colors.red,
          ),
        );

        return responseBody['success'] == true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected response status: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }


/* ==============================================Check Block Status Api===============================================*/

  Future<bool> isUserBlocked(String userId, String targetUserId) async {
    try {
      var response = await http.get(
        Uri.parse('${AppApiUtils.isBlockedApi}?userId=$userId&targetUserId=$targetUserId'),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['isBlocked'] as bool;
      } else {
        throw Exception('Failed to check block status');
      }
    } catch (e) {
      throw Exception('Failed to check block status');
    }
  }
}