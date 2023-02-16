import 'dart:convert';

class MesaModel{
  int? idmesas;
  int? numero;
  int? estabelecimento_id;

  MesaModel(this.idmesas, this.numero, this.estabelecimento_id);

  String toString(){
    return 'Mesa ${this.numero}';
  }

  MesaModel.fromJson(Map<String, dynamic> json){
    idmesas = json['idmesas'];
    numero = json['numero'];
    estabelecimento_id = json['estabelecimento_id'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idmesas'] = this.idmesas;
    data['numero'] = this.numero;
    data['estabelecimento_id'] = this.estabelecimento_id;
    return data;
  }

  static listToJson(List<MesaModel> list){
    var mesaMap = list.map((e){
      return{
        "numero" : e.numero,
      };
    }).toList();
    String mesasString = jsonEncode(mesaMap);
    return mesasString;
  }
}