import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '/common/util/localNotiPlugin.dart';
import 'channels.dart';

class NotiService {

	//------------- Handle Event Noti when Device on Background mode ----------
  static Future<void> firebaseMessagingBackroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    await showLocalNoti(localNotificationsPlugin.flutterLocalNotificationsPlugin, message);
    // print(message);
  }
	
	//-------------- Initialize Noti service -----------------
  static Future<void> intinializeNotiService() async {
    await Firebase.initializeApp();
		
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = localNotificationsPlugin.flutterLocalNotificationsPlugin;
		// icon notification
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: androidInitialize,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
		
		// create a new chanel for android, must add channel id in android/app/src/main/AndroidManifest.xml
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.example.lhe_npp.urgent', // id
      'High Importance Notifications', // title
      description:
          'Thông báo terminated', // description
      importance: Importance.max,
    );
		
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
		
		// setting notification
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

		// request permission for device
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
		
		// event listening when have noti when device on fore
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      await showLocalNoti(flutterLocalNotificationsPlugin, message);
    });
  }

	// ------------ event to show local noti pop model -----------
  static Future showLocalNoti(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RemoteMessage message
  ) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(

			// import channels.dart
      Channels.channel_1.id,
      Channels.channel_1.name,
      importance: Channels.channel_1.importance,
      priority: Priority.high,
      ticker: 'ticker',
      icon: android?.smallIcon
    );

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification!.title,
      notification.body,
      notificationDetails,
      payload: 'item x',
    );
  }
	
	// ---------- get device token to push notification ----------
  static Future getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessage.getToken();
    print(deviceToken);
    return (deviceToken == null) ? '' : deviceToken;
  }
}