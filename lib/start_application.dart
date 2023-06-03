import 'package:comandaapp/routes/app_pages.dart';
import 'package:comandaapp/routes/app_routes.dart';
import 'package:comandaapp/service/firebase_messaging_service.dart';
import 'package:comandaapp/service/notification_service.dart';
import 'package:comandaapp/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StartApp extends StatefulWidget{
  @override
  State<StartApp> createState() => _StartApp();
}

class _StartApp extends State<StartApp>{
  @override
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
    checkNotifications();
  }

  initilizeFirebaseMessaging() async {
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Comanda App",
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      navigatorKey: Routes.navigatorKey,
    );
  }
}