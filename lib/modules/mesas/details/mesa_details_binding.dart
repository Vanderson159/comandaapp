import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:get/get.dart';

class MesaDetailsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MesaDetailsController>(() => MesaDetailsController());
    Get.lazyPut<ListMesaController>(() => ListMesaController());
  }

}