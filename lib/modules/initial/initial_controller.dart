import 'package:comandaapp/data/model/estabelecimento_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController{
  final box = GetStorage('comandaapp');
  int cont = 00;
  late String nomeRestaurante;
  String labelDialog = 'Adicione quantas mesas estarão disponíveis em seu estabelecimento!';
  TextEditingController contadorController = TextEditingController();
  RxBool showAdicionarMesa = true.obs;
  String acaoBtnLabel = 'Adicionar Mesas';

  void inserirMesas(){
    showAdicionarMesa.value = false;
    acaoBtnLabel = 'Finalizar';
    labelDialog = 'Para adicionar novas mesas, selecione Adicionar Mesa na aba Disponíveis.';
    update();
  }

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