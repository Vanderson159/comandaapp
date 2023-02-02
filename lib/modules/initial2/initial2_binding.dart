import 'package:comandaapp/modules/initial2/initial2_controller.dart';
import 'package:get/get.dart';

class Initial2Binding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<Initial2Controller>(() => Initial2Controller());
  }

}