import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialController extends GetxController{
  int cont = 00;
  String nomeRestaurante = 'PAPA GULA';
  String labelDialog = 'Adicione quantas mesas estarão disponíveis em seu estabelecimento!';
  TextEditingController contadorController = TextEditingController();

  void incrementar(){
    cont++;
    update();
  }

  void inserirMesas(){

  }

  void decrementar(){
    if(cont < 1){
      cont = 0;
      update();
    }else{
      cont--;
      update();
    }
  }
}