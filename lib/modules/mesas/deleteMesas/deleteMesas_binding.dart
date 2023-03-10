import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_controller.dart';
import 'package:get/get.dart';

class DeleteMesasBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DeleteMesasController>(() => DeleteMesasController());

  }
}