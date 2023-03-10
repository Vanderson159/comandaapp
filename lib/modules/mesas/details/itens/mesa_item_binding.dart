import 'package:comandaapp/modules/mesas/details/itens/mesa_item_controller.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:get/get.dart';

class MesaItemBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MesaItemController>(() => MesaItemController());
    Get.lazyPut<MesaDetailsController>(() => MesaDetailsController());
  }
}