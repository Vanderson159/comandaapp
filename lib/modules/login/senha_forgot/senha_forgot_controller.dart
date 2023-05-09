import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SenhaForgotController extends GetxController{
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main
  String teste = '';

  @override
  void onInit() {
    var aux = box.read('idMesa');
    teste = aux.toString();
    super.onInit();
  }
}