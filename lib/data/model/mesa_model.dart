import 'dart:convert';
import 'package:comandaapp/data/model/item_model.dart';
import 'package:get/get.dart';

class MesaModel{
  int id = 0;
  int? numero;
  int? estabelecimento_id;
  bool? disponivel;
  RxBool? isCheck = false.obs;
  ItemModel itemModel = ItemModel('', 0.obs, 0);

  MesaModel(this.id, this.numero, this.estabelecimento_id, this.disponivel, this.isCheck);

  String toString(){
    return 'Mesa ${this.numero}';
  }
  
  MesaModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    numero = json['numero'];
    estabelecimento_id = json['estabelecimento_id'];
    disponivel = json['disponivel'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['numero'] = this.numero;
    data['estabelecimento_id'] = this.estabelecimento_id;
    data['disponivel'] = this.disponivel;
    return data;
  }

  static listToJson(List<MesaModel> list){
    var mesaMap = list.map((e){
      return{
        "id" : e.id,
        "numero" : e.numero,
        "estabelecimento_id" : e.estabelecimento_id,
        "disponivel" : e.disponivel,
      };
    }).toList();
    String mesasString = jsonEncode(mesaMap);
    return mesasString;
  }
}