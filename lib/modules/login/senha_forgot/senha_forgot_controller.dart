import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SenhaForgotController extends GetxController{
  String teste = 'BRANCO';
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main

  @override
  void onInit() async{
    if(Get.arguments != null){
      teste = Get.arguments;
    }
    super.onInit();
  }
}