import 'package:comandaapp/modules/initial/initial_binding.dart';
import 'package:comandaapp/modules/initial/initial_view.dart';
import 'package:comandaapp/modules/login/login_view.dart';
import 'package:comandaapp/modules/mesas/addMesas/addMesas_binding.dart';
import 'package:comandaapp/modules/mesas/addMesas/addMesas_view.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_binding.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_view.dart';
import 'package:comandaapp/modules/mesas/listMesas_binding.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:get/get.dart';
import '../modules/login/login_binding.dart';
import '../modules/mesas/deleteMesas/deleteMesas_binding.dart';
import '../modules/mesas/deleteMesas/deleteMesas_view.dart';
import 'app_routes.dart';

class AppPages{
  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: ()=> InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: ()=> LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.LISTMESAS,
      page: ()=> ListMesaView(),
      binding: ListMesasBinding(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: ()=> MesaDetails(titulo: ''),
      binding: MesaDetailsBinding(),
    ),
    GetPage(
      name: Routes.DELETEMESAS,
      page: ()=> DeleteMesasView(),
      binding: DeleteMesasBinding(),
    ),
    GetPage(
      name: Routes.ADDMESAS,
      page: ()=> AddMesasView(),
      binding: AddMesasBinding(),
    ),
  ];
}