import 'package:comandaapp/modules/login/senha_forgot/senha_forgot_controller.dart';
import 'package:get/get.dart';

class SenhaForgotBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SenhaForgotController>(() => SenhaForgotController());
  }
}