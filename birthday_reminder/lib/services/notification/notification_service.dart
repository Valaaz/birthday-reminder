import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  final _notifications = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // When app is closed
    final launchDetails =
        await _notifications.getNotificationAppLaunchDetails();
    if (launchDetails != null && launchDetails.didNotificationLaunchApp) {
      onNotificationClick.add(launchDetails.payload);
    }

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _notifications.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  // static Future _notificationDetails() async {
  //   return const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'channel id',
  //       'channel name',
  //       channelDescription: 'channel description',
  //       importance: Importance.max,
  //       priority: Priority.max,
  //     ),
  //     iOS: IOSNotificationDetails(),
  //   );
  // }

  // static Future showNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  // }) async =>
  //     _notifications.show(
  //       id,
  //       title,
  //       body,
  //       await _notificationDetails(),
  //       payload: payload,
  //     );

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  Future<void> showNotificationPayload({
    required int id,
    required String title,
    required String body,
    required String payload,
  }) async {
    final details = await _notificationDetails();
    await _notifications.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      onNotificationClick.add(payload);
    }
  }
}
