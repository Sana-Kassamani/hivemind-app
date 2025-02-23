import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/providers/alerts.provider.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:provider/provider.dart';

// // make sure app is still running in bg
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await FirebaseApi.instance.setupFlutterNotifications();
//   await FirebaseApi.instance.showNotification(message);
// }

class FirebaseApi {
  FirebaseApi._();
  static final FirebaseApi instance = FirebaseApi._();

  // instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize({context}) async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // request permission
    await requestPermission();

    // setup message handlers
    await setupMessageHandlers(context);

    // get FCM token
    final token = await _firebaseMessaging.getToken();
    print("FCM token: $token");
  }

  Future<void> allowNotifications({context}) async {
    await FirebaseApi.instance.initialize(context: context);
  }

  Future<String?> getToken() async {
    // get FCM token
    final token = await _firebaseMessaging.getToken();
    return token;
  }

  Future<void> requestPermission() async {
    // request permission from user
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );
    print("Permission status :${settings.authorizationStatus}");
  }

  Future<void> setupMessageHandlers(context) async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
      _handleMessage(message, context);
    });

    //background message
    FirebaseMessaging.onMessageOpenedApp.listen((message) => {});

    // opened app
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      // _handleMessage(initialMessage, context);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            channelDescription:
                'This channel is used for important notifications.', // description
            importance: Importance.high,
            priority: Priority.high,
            icon: "@mipmap/ic_launcher",
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void _handleMessage(RemoteMessage message, context) {
    // save message in provider
    print("Hello from handleMessage");
    Provider.of<Alerts>(context, listen: false).add(message: message);
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android setup
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializeSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // ios setup
    final initializationSettingsDarwin = DarwinInitializationSettings(
      // handle ios foreground notifications
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final initializationSettings = InitializationSettings(
      android: initializeSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    //Flutter notification setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }
}

void navigateToAlertsPage({context}) {
  if (Provider.of<Auth>(context, listen: false).user.getUserType ==
      UserTypes.Owner) {
    navigatorKey.currentState?.pushNamed("/alertsOwner");
  } else if (Provider.of<Auth>(context, listen: false).user.getUserType ==
      UserTypes.Beekeeper) {
    navigatorKey.currentState?.pushNamed("/alertsBeekeeper");
  } else {}
}
