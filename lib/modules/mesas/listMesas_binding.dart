import 'package:comandaapp/modules/mesas/addMesas/addMesas_controller.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:get/get.dart';

class ListMesasBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ListMesaController>(() => ListMesaController());
    Get.lazyPut<AddMesasController>(() => AddMesasController());
    Get.lazyPut<MesaDetailsController>(() => MesaDetailsController());
  }
}