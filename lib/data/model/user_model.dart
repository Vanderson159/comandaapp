import 'package:comandaapp/data/model/estabelecimento_model.dart';

class UserModel {
  int? id;
  String? username;
  int? tipoUser;
  int? activated;
  int? estabelecimento_id;
  EstabelecimentoModel? estabelecimentoModel;

  UserModel({this.id, this.username, this.activated, this.estabelecimento_id, this.tipoUser});

  UserModel.fromJson(Map<String, dynamic> json) {
    estabelecimentoModel = json['estabelecimento'] != null ? EstabelecimentoModel.fromJson(json['estabelecimento']) : null;
    id = json['id'];
    username = json['username'];
    activated = json['activated'];
    estabelecimento_id = json['estabelecimento_id'];
    tipoUser = json['tipoUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.estabelecimentoModel != null) {
      data['estabelecimento'] = this.estabelecimentoModel!.toJson();
    }
    data['id'] = this.id;
    data['username'] = this.username;
    data['activated'] = this.activated;
    data['estabelecimento_id'] = this.estabelecimento_id;
    data['tipoUser'] = this.tipoUser;
    return data;
  }
}