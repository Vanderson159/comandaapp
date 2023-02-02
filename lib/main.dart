import 'package:comandaapp/routes/app_pages.dart';
import 'package:comandaapp/routes/app_routes.dart';
import 'package:comandaapp/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  //scrcpy --tcpip=192.168.1.116:5555
  //await GetStorage.init('comandaapp'); // nome  para o storage do app
  runApp(
      GetMaterialApp(
        title: "Comanda App",
        //debugShowCheckedModeBanner: false,
        theme: appThemeData,
        initialRoute: Routes.LOGIN,
        getPages: AppPages.routes,
        //initialBinding: ,
      )
  );
}