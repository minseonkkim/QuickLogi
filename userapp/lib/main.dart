import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:quick_logi/screens/authentication/email_verify_screen.dart';
import 'package:quick_logi/screens/authentication/join_screen.dart';
import 'package:quick_logi/screens/authentication/login_screen.dart';
import 'package:quick_logi/screens/main_screen.dart';
import 'package:quick_logi/screens/profile_screen.dart';
import 'package:quick_logi/screens/request_info_select/date_select_screen.dart';
import 'package:quick_logi/screens/home_screen.dart';
import 'package:quick_logi/screens/request_info_select/freight_select_screen.dart';
import 'package:quick_logi/screens/request_info_select/place_select_screen.dart';
import 'package:quick_logi/screens/request_info_select_screen.dart';
import 'package:quick_logi/screens/request_list_screen.dart';
import 'package:quick_logi/screens/splash_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // 세부 내용이 필요한 경우 추가...
}

@pragma('vm:entry-point')
void backgroundHandler(NotificationResponse details) {
  // 액션 추가... 파라미터는 details.payload 방식으로 전달
}
void initializeNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    ),
    onDidReceiveNotificationResponse: (details) {
      // 액션 추가...
    },
    onDidReceiveBackgroundNotificationResponse: backgroundHandler,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          payload: message.data['test_paremeter1']);
      print("수신자 측 메시지 수신");
    }
  });

  RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
  if (message != null) {
    // 액션 부분 -> 파라미터는 message.data['test_parameter1'] 이런 방식으로...
  }
}

Future<void> main() async {
  //FirebaseMessaging.instance.requestPermission();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var messageString = "";

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }

  @override
  void initState() {
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickLogi',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/SplashScreen',
      getPages: [
        GetPage(
          name: '/SplashScreen',
          page: () => SplashScreen(),
        ),
        GetPage(name: '/MainScreen', page: () => MainScreen()),
        GetPage(name: '/HomeScreen', page: () => HomeScreen()),
        GetPage(name: '/RequestListScreen', page: () => RequestListScreen()),
        GetPage(name: '/ProfileScreen', page: () => ProfileScreen()),
        GetPage(
          name: '/RequestInfoSelectScreen',
          page: () => RequestInfoSelectScreen(),
        ),
        GetPage(
          name: '/PlaceSelectScreen',
          page: () => PlaceSelectScreen(),
        ),
        GetPage(
          name: '/DateSelectScreen',
          page: () => DateSelectScreen(),
        ),
        GetPage(
          name: '/FreightSelectScreen',
          page: () => FreightSelectScreen(),
        ),
        GetPage(
          name: '/LoginScreen',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/JoinScreen',
          page: () => JoinScreen(),
        ),
        GetPage(
          name: '/EmailVerifyScreen',
          page: () => EmailVerifyScreen(),
        ),
      ],
    );
  }
}
