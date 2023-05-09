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
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //para nao deixar o aplicativo em modo paisagem
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init('comandaapp'); // nome  para o storage do app
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main

 //inicio firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //pegando token do device
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

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
    print('Got a message whilst in the foreground!');
    print(message.data);
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  //fim firebase

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: _onSelectNotification);
  var androidChannel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      playSound: true
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidChannel);

  Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidChannel);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);
  }

  await requestPermissions();
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

Future<void> _onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  // Aqui você pode definir uma ação personalizada para ser executada quando o usuário clica na notificação, como abrir uma tela específica ou executar uma tarefa.
}