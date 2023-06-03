import 'package:comandaapp/routes/app_routes.dart';
import 'package:comandaapp/service/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;
  FirebaseMessagingService(this._notificationService);
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    // _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('=======================================');
    debugPrint('TOKEN: $token');
    debugPrint('=======================================');
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      //salva o data para ser utilizado no notification service
      if(message.data != null){
        box.write('data', message.data);
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  // _onMessageOpenedApp() async{
  //   FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  // }
  //
  // _goToPageAfterMessage(message) {
  //   final String route = message.data['route'] ?? '';
  //   if (route.isNotEmpty) {
  //     Routes.navigatorKey?.currentState?.pushNamed(route, arguments: message.data);
  //   }
  // }
}