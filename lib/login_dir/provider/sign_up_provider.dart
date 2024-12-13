// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/login_dir/services/login_api_service.dart';
import 'package:player_connect/login_dir/services/signUp_api_service.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

import '../../shared/auth/routes.dart';
import '../../shared/constant/colors.dart';
import '../../shared/constant/font_size.dart';
import '../../shared/constant/fonts.dart';
import 'package:http/http.dart' as http;

class SignUpProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = true;
  bool isLoading = false;
  final String apiKey = 'oQRFt2Uk6QtBqQege9QFvDEdV';
  final String apiSecretKey =
      'NyigIwTXT2SLPIE9AV8QoPPakpuTplE0mASVoG6dam8SD5IsvP';
  final FirebaseAuth auth = FirebaseAuth.instance;

  setShowPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  bool emailValid(email) {
    bool emailValid = RegExp(
            r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])')
        .hasMatch(email);
    return emailValid;
  }

  getFcmToken() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) async => {
          LocalDataSaver.saveUserFcmToken(value),
          await fetchDataSPreferences(),
          print("==========$value"),
          notifyListeners(),
        });
  }

  Map<String, String> _buildAuthorizationHeader() {
    final credentials = '$apiKey:$apiSecretKey';
    final encodedCredentials = base64Encode(utf8.encode(credentials));
    final header = {'Authorization': 'Basic $encodedCredentials'};
    return header;
  }


  Future<void> signInOrSignUpGoogle(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await getFcmToken();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final String email = googleSignInAccount.email;
        final String socialId = googleSignInAccount.id;

        final bool userExists = await checkUser(context,email);

        print('User Exist Value :- $userExists');

        if (userExists) {
          await LoginApiService.getInstance()
              .loginSocialData(context, "0", socialId, email)
              ?.whenComplete(() {
            isLoading = false;
            notifyListeners();
          });
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.verifiedPage,
                (route) => false,
            arguments: {
              'email': email,
              'socialId': socialId,
              'socialType': '0',
            },
          ).whenComplete(() {
            isLoading = false;
            notifyListeners();
          });
        }
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkUser(BuildContext context, String email) async {
    final response = await http.post(
      Uri.parse('http://18.220.106.62:3000/user_Exist'),
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData['success'] == 1 && responseData['body'] != null) {
        final bool userExists = responseData['body']['userExists'];
        return userExists;
      } else {
        return false;
      }
    } else {
      throw Exception('Failed to check user existence');
    }
  }



  Future<void> facebookSignInOrSignUp(BuildContext context) async {
    final fb = FacebookLogin();

    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! Your ID: ${profile?.userId}');

        // Get email (if the user grants permission)
        final email = await fb.getUserEmail();
        if (email != null) {
          print('And your email is $email');

          // Check if the user exists
          final bool userExists = await checkUser(context, email);

          print('User Exist Value :- $userExists');

          // If user exists, log them in
          if (userExists) {
            await LoginApiService.getInstance()
                .loginSocialData(context, "1", profile!.userId.toString(), email)
                ?.whenComplete(() {
              isLoading = false;
              notifyListeners();
            });
          } else {
            // New user - Navigate to the profile creation page
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.verifiedPage,
                  (route) => false,
              arguments: {
                'email': email,
                'socialId': profile!.userId.toString(),
                'socialType': '1',  // 1 for Facebook
              },
            ).whenComplete(() {
              isLoading = false;
              notifyListeners();
            });
          }
        } else {
          dialogBoxApp(context, profile!.userId.toString(), "1");
        }
        break;

      case FacebookLoginStatus.cancel:
      // User canceled login
        print('User canceled login');
        break;

      case FacebookLoginStatus.error:
      // Error occurred during login
        print('Error while logging in: ${res.error}');
        break;
    }
  }


  Future<void> twitterSignInOrSignUp(BuildContext context) async {
    final twitterLogin = TwitterLogin(
      apiKey: apiKey,
      apiSecretKey: apiSecretKey,
      redirectURI: 'https://example.com/', // Your redirect URI
    );

    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
      // Login success
        print('====== Login success ======');
        print('Auth Token: ${authResult.authToken}');
        print('Auth Token Secret: ${authResult.authTokenSecret}');

        // Fetch user email (if provided by Twitter)
        final email = authResult.user!.email;
        if (email != null && email.isNotEmpty) {
          print('User email: $email');

          // Check if the user exists in your system
          final bool userExists = await checkUser(context, email);

          print('User Exist Value: $userExists');

          // If user exists, log them in
          if (userExists) {
            await LoginApiService.getInstance()
                .loginSocialData(context, "2", authResult.user!.id.toString(), email)
                ?.whenComplete(() {
              isLoading = false;
              notifyListeners();
            });
          } else {
            // If the user does not exist, navigate to profile creation page
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.verifiedPage,
                  (route) => false,
              arguments: {
                'email': email,
                'socialId': authResult.user!.id.toString(),
                'socialType': '2', // 2 for Twitter
              },
            ).whenComplete(() {
              isLoading = false;
              notifyListeners();
            });
          }
        } else {
          // If no email provided by Twitter, handle accordingly (show a dialog or error)
          dialogBoxApp(context, authResult.user!.id.toString(), "2");
        }
        break;

      case TwitterLoginStatus.cancelledByUser:
      // User canceled login
        print('====== Login canceled by user ======');
        break;

      case TwitterLoginStatus.error:
      // Error occurred during login
        print('====== Login error ======');
        break;

      case null:
      // Handle case where authResult is null
        print('====== Login failed due to null result ======');
        break;
    }
  }




  Future<void> appleSignInOrSignUp(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final appleId = credential.userIdentifier;
      String email = credential.email ?? '';
      String firstName = credential.givenName ?? '';
      String lastName = credential.familyName ?? '';

      print('--- Apple Sign-In Details ---');
      print('Email: $email');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('User Identifier: $appleId');
      print('---------------------------------');

      if (email.isEmpty || firstName.isEmpty || lastName.isEmpty) {
        await _promptUserForDetails(context, (providedEmail, providedFirstName, providedLastName) {
          email = providedEmail;
          firstName = providedFirstName;
          lastName = providedLastName;
        });
      }

      final bool userExists = await checkUser(context, email);

      print('User Exists: $userExists');

      if (userExists) {
        LoginApiService.getInstance()
            .loginSocialData(context, "3", appleId, '')
            ?.whenComplete(() {
          isLoading = false;
          notifyListeners();
        });
      } else {
        final profileProvider = Provider.of<CreateProfileProvider>(context, listen: false);
        profileProvider.socialId = appleId;
        profileProvider.socialType = "3";
        profileProvider.emailController.text = email;
        profileProvider.firstNameController.text = firstName;
        profileProvider.lastNameController.text = lastName;

        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.verifiedPage,
              (route) => false,
          arguments: {
            'email': email,
            'socialId': appleId,
            'socialType': '3',
          },
        );
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      isLoading = false;
      notifyListeners();
      print('Error: $e');
    }
  }


  // Future<void> appleSignUp(BuildContext context) async {
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //
  //     String email = credential.email ?? '';
  //     String firstName = credential.givenName ?? '';
  //     String lastName = credential.familyName ?? '';
  //     String userIdentifier = credential.userIdentifier ?? '';
  //
  //     if (email.isEmpty || firstName.isEmpty || lastName.isEmpty) {
  //       await _promptUserForDetails(context,
  //           (providedEmail, providedFirstName, providedLastName) {
  //         email = providedEmail;
  //         firstName = providedFirstName;
  //         lastName = providedLastName;
  //       });
  //     }
  //
  //     print('--- Apple Sign-In Details ---');
  //     print('Email: $email');
  //     print('First Name: $firstName');
  //     print('Last Name: $lastName');
  //     print('User Identifier: $userIdentifier');
  //     print('Authorization Code: ${credential.authorizationCode}');
  //     print('Identity Token: ${credential.identityToken}');
  //     print('---------------------------------');
  //
  //     // SignUpApiService.getInstance().loginSocialData(
  //     //   context,
  //     //   "3",
  //     //   userIdentifier,
  //     //   email,
  //     // );
  //
  //     final profileProvider =
  //         Provider.of<CreateProfileProvider>(context, listen: false);
  //     profileProvider.socialId = userIdentifier;
  //     profileProvider.socialType = "3";
  //     profileProvider.emailController.text = email;
  //     profileProvider.firstNameController.text = firstName;
  //     profileProvider.lastNameController.text = lastName;
  //
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       AppRoutes.verifiedPage,
  //       (route) => false,
  //       arguments: {
  //         'email': email,
  //         'socialId': userIdentifier,
  //         'socialType': '3',
  //       },
  //     );
  //   } on SignInWithAppleException catch (e) {
  //     print('Apple Sign-In Error: $e');
  //   } catch (e) {
  //     print('General Error: $e');
  //   }
  // }

  Future<void> _promptUserForDetails(BuildContext context,
      Function(String, String, String) onDetailsProvided) async {
    TextEditingController emailController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 16,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Provide Your Details',
                  style: AppFonts.poppinsFont(TextStyle(
                    fontSize: AppFontSize.font18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.infoPageCount,
                  )),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.infoPageCount,
                    )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.infoPageCount,
                    )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.infoPageCount,
                    )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onDetailsProvided(
                          emailController.text.trim(),
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                        );
                      },
                      child: Text(
                        'Submit',
                        style: AppFonts.poppinsFont(TextStyle(
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColorBlue,
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  dialogBoxApp(context, id, type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please enter email"),
            content: TextFormField(
              onChanged: (value) {},
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Please enter email",
                labelText: "Email Address",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No")),
              TextButton(
                  onPressed: () {
                    if (emailController.text.trim().isEmpty) {
                      AppSnackBarToast.buildShowSnackBar(
                          context, "Please enter email address");
                      Navigator.pop(context);
                    } else {
                      // Navigator.pop(context);
                      Provider.of<CreateProfileProvider>(context, listen: false)
                          .emailController
                          .text = emailController.text;
                      SignUpApiService.getInstance().loginSocialData(
                          context, type, id, emailController.text);
                      emailController.clear();
                      notifyListeners();
                    }
                  },
                  child: Text("Yes")),
            ],
          );
        });
  }
}
