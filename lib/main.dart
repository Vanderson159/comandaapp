import 'package:comandaapp/routes/app_pages.dart';
import 'package:comandaapp/routes/app_routes.dart';
import 'package:comandaapp/theme/app_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  await GetStorage.init('comandaapp'); // nome  para o storage do app
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  var token = await messaging.getToken();
  box.write('token_device', token.toString());

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  tz.initializeTimeZones();
  //scrcpy --tcpip=192.168.1.116:5555
  runApp(
      GetMaterialApp(
        title: "Comanda App",
        debugShowCheckedModeBanner: false,
        theme: appThemeData,
        initialRoute: Routes.LOGIN,
        getPages: AppPages.routes,
        //initialBinding: ,
      )
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}