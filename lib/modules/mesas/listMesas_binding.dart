import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:get/get.dart';

class ListMesasBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ListMesaController>(() => ListMesaController());
  }
}