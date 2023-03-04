import 'dart:convert';

import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/comanda_provider.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
var listItens = <ItemModel>[].obs; //LISTA QUE ARMAZENA OS ITENS ADICIONADOS ENTAO TEM QUE DELETAR ELA NA HORA DE ENVIAR ELES PQ SE NAO VAI ACONTECER O MESMO BUG DO ADICIONAR
class MesaDetailsController extends GetxController{
  ComandaApiClient comandaApiClient = ComandaApiClient();
  ListMesaController listMesaController = ListMesaController();
  TextEditingController itemPedido =  TextEditingController();
  final formKeyDetail = GlobalKey<FormState>(); //formkey do formulario de mesa detail
  RxBool attWidget = false.obs;
  RxBool listaVazia = true.obs;

  void cleanList(){
    ItemModel.listToJson(listItens);
    listItens.clear();
  }

  void adicionarItem(ItemModel itemModel){
    listItens.add(itemModel);
    Get.back();
  }

  void printarItens(){
    listItens.forEach((element) {
      print(element.nome);
      print(element.quantidade);
    });
  }

  void encerrarPedido(int id){
    comandaApiClient.inserirItensToComanda(ItemModel.listToJson(listItens).toString(), listMesaController.tokenAccess(), id);
  }
}