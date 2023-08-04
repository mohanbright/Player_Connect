// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/page/splash_page.dart';

import 'shared/constant/app_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppDetails.appName,
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: SplashPage(),
    );
  }
}
