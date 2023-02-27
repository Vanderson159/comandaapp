import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MesaItemController extends GetxController{

  TextEditingController contadorController = TextEditingController();
  RxInt qtd = 00.obs;

  void incrementar(){
    qtd.value++;
    update();
  }

  void decrementar(){
    if(qtd.value < 1){
      qtd.value = 00;
      update();
    }else{
      qtd.value--;
      update();
    }
  }

}