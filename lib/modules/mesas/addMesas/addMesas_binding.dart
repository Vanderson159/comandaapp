import 'package:comandaapp/modules/mesas/addMesas/addMesas_controller.dart';
import 'package:get/get.dart';

class AddMesasBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddMesasController>(() => AddMesasController());
  }
}