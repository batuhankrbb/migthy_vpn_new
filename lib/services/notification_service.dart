import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mightyvpn/main.dart';

class CloudMessageHelper {
  static var shared = CloudMessageHelper();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    print('User granted permission: ${settings.authorizationStatus}');

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    globalStore.hasComeFromNotification = true;
    mixpanel?.track("Notification Clicked");
  }

  Future<void> subscribe() async {
    await FirebaseMessaging.instance.subscribeToTopic('vpn-non-premium');
  }

  Future<void> unsubscribe() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('vpn-non-premium');
  }
}
