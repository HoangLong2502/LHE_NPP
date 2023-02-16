import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Channels {
  static const AndroidNotificationChannel channel_1 =
      AndroidNotificationChannel(
    'channel test', 'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
}