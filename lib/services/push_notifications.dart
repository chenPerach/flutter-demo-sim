import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {

  PushNotificationsManager(){
    print("here");
    init();
  }
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    String token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: ${token}");
    var settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    switch(settings.authorizationStatus){
      case AuthorizationStatus.denied:
        print("User denide permission");
        break;
      case AuthorizationStatus.authorized:
        print("User authorized permission");

        FirebaseMessaging.onMessage.listen((message) {
          print("got a message in forground!");

          if(message.notification != null)
            print("Message has notification: ${message.notification}");
        });
        break;
      case AuthorizationStatus.provisional:
        print("User denide permission");
        break;
    }

  }
}
