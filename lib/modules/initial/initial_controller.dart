import 'package:comandaapp/data/model/estabelecimento_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController{
  final box = GetStorage('comandaapp');
  int cont = 00;
  String nomeRestaurante = 'PAPA GULA';
  String labelDialog = 'Adicione quantas mesas estarão disponíveis em seu estabelecimento!';
  TextEditingController contadorController = TextEditingController();

  UserModel userLogado(){
     UserModel userModel = box.read('userStorage');
     return userModel;
  }

  EstabelecimentoModel? estabelecimento(){
    UserModel userModel = box.read('userStorage');
    EstabelecimentoModel? estabelecimentoModel = userModel.estabelecimentoModel;
    return estabelecimentoModel;
  }

  String nomeEstabelecimento(){
    String? nome = estabelecimento()!.nome;
    if(nome!.isNotEmpty){
      return nome;
    }
    return '';
  }

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