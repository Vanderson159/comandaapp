import 'package:comandaapp/service/firebase_messaging_service.dart';
import 'package:comandaapp/service/notification_service.dart';
import 'package:comandaapp/start_application.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

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
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  //fim firebase

  //pegando token do device
  var token = await messaging.getToken();
  box.write('token_device', token.toString());
  //fim pegando token do device

  tz.initializeTimeZones();
  //scrcpy --tcpip=192.168.1.116:5555
  //scrcpy --select-usb
  runApp(
      MultiProvider(
        providers: [
          Provider<NotificationService>(
            create: (context) => NotificationService(),
          ),
          Provider<FirebaseMessagingService>(
            create: (context) => FirebaseMessagingService(context.read<NotificationService>()),
          ),
        ],
        child: StartApp(),
      )
  );
}