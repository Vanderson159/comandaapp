import 'package:comandaapp/modules/initial/initial_binding.dart';
import 'package:comandaapp/modules/initial/initial_view.dart';
import 'package:comandaapp/modules/initial2/initial2_binding.dart';
import 'package:comandaapp/modules/initial2/initial2_view.dart';
import 'package:comandaapp/modules/login/login_view.dart';
import 'package:get/get.dart';
import '../modules/login/login_binding.dart';
import 'app_routes.dart';

class AppPages{
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: ()=> InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.INITIAL2,
      page: ()=> InitialView2(),
      binding: Initial2Binding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: ()=> LoginView(),
      binding: LoginBinding(),
    ),
  ];
}