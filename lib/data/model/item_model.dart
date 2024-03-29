import 'dart:convert';

import 'package:get/get.dart';
class ItemModel{
  String nome = '';
  RxInt quantidade = 01.obs;
  int idMesa;

  ItemModel(this.nome, this.quantidade, this.idMesa);

  static listToJson(List<ItemModel> list){
    var mesaMap = list.map((e){
      return{
        "nome" : e.nome,
        "quantidade" : e.quantidade.value,
      };
    }).toList();
    String itensString = jsonEncode(mesaMap);
    return itensString;
  }
}