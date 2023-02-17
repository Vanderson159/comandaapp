import 'package:comandaapp/modules/initial/initial_controller.dart';
import 'package:comandaapp/modules/mesas/addMesas/addMesas_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InitialController>(() => InitialController());
    Get.lazyPut<AddMesasController>(() => AddMesasController());
  }

}