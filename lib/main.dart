// ignore_for_file: prefer_const_constructors, avoid_print

// import 'package:firebase_core/firebase_core.dart';

// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/home_dir/my_profile_dir/provider/my_profile_provider.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/login_dir/provider/connect_with_provider.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/login_dir/provider/forgot_password_provider.dart';
import 'package:player_connect/login_dir/provider/login_provider.dart';
import 'package:player_connect/login_dir/provider/new_password_provider.dart';
import 'package:player_connect/login_dir/provider/sign_up_provider.dart';
import 'package:player_connect/setting_dir/provider/change_pass_page_provider.dart';
import 'package:player_connect/setting_dir/provider/contact_suport_page_provider.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/setting_dir/provider/notification_page_provider.dart';
import 'package:player_connect/setting_dir/provider/setting_page_provider.dart';
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/models/notification_chat_message_model.dart';
import 'package:player_connect/shared/models/notifications_model.dart';
import 'package:player_connect/shared/page/splash_page.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:provider/provider.dart';
import 'firebaseOption.dart';
import 'shared/constant/app_details.dart';

final List<NotificationChatMessageModel> chatMessagesNotificationList = [];

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.data}');

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var android = AndroidNotificationDetails(
    'channel id',
    'channel name',
  );

  var platform = NotificationDetails(
    android: android,
  );

  // await flutterLocalNotificationsPlugin.show(
  //     0, message.notification?.title, message.notification?.body, platform,
  //     payload: 'New notification');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: "Coachconnecter",
  );

  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  final settings = await FirebaseMessaging.instance.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else {
    print('User declined permission');
  }

  getInitialMessage();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received a message while in the foreground: ${message.messageId}");
  });

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColorBlue,
  ));

  runApp(MyApp());
}

void getInitialMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print("Initial message: ${initialMessage.messageId}");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  AppLifecycleState? _notification;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    await fetchDataSPreferences();
    setState(() {
      _notification = state;
    });

    switch (state) {
      case AppLifecycleState.resumed:
        await UserOnlineApiService.getInstance().isUserOnline(1);
        print("State of app in resumed:$_notification");
        break;
      case AppLifecycleState.inactive:
        await UserOnlineApiService.getInstance().isUserOnline(0);
        print("State of app in inactive:$_notification");
        break;
      case AppLifecycleState.paused:
        await UserOnlineApiService.getInstance().isUserOnline(0);
        print("State of app in paused:$_notification");
        break;
      case AppLifecycleState.detached:
        await UserOnlineApiService.getInstance().isUserOnline(0);
        print("State of app in detached:$_notification");
        break;
      // case AppLifecycleState.hidden:
      //   await UserOnlineApiService.getInstance().isUserOnline(0);
      //   print("State of app in detached:$_notification");
      //   break;

      // TODO: Handle this case.
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return LoginProvider();
      },
      child: ChangeNotifierProvider(
        create: (_) {
          return SignUpProvider();
        },
        child: ChangeNotifierProvider(
          create: (_) {
            return NewPasswordProvider();
          },
          child: ChangeNotifierProvider(
            create: (_) {
              return ForgotPasswordProvider();
            },
            child: ChangeNotifierProvider(
              create: (_) {
                return ConnectWithProvider();
              },
              child: ChangeNotifierProvider(
                create: (_) {
                  return ChatProvider();
                },
                child: ChangeNotifierProvider(
                  create: (_) {
                    return ConnectProvider();
                  },
                  child: ChangeNotifierProvider(
                    create: (_) {
                      return MyProfileProvider();
                    },
                    child: ChangeNotifierProvider(
                      create: (_) {
                        return PlayerProvider();
                      },
                      child: ChangeNotifierProvider(
                        create: (_) {
                          return EditProfileProvider();
                        },
                        child: ChangeNotifierProvider(
                          create: (_) {
                            return ChangePassPageProvider();
                          },
                          child: ChangeNotifierProvider(
                            create: (_) {
                              return ContactSupportPageProvider();
                            },
                            child: ChangeNotifierProvider(
                              create: (_) {
                                return NotificationPageProvider();
                              },
                              child: ChangeNotifierProvider(
                                create: (_) {
                                  return SettingPageProvider();
                                },
                                child: ChangeNotifierProvider(
                                  create: (_) {
                                    return CreateProfileProvider();
                                  },
                                  child: ChangeNotifierProvider(
                                    create: (_) {
                                      return NotificationModel();
                                    },
                                    child: ChangeNotifierProvider(
                                      create: (_) {
                                        return RoutesProvider();
                                      },
                                      child: MaterialApp(
                                        title: AppDetails.appName,
                                        debugShowCheckedModeBanner: false,
                                        routes: routes,
                                        home: SplashPage(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
