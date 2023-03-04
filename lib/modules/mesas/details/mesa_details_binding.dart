

import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:get/get.dart';

class MesaDetailsBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MesaDetailsController>(() => MesaDetailsController());
    Get.lazyPut<MesaDetailsController>(() => MesaDetailsController());
  }

}