class UserModel {
  int? id;
  String? username;
  int? tipoUser;
  int? activated;
  int? estabelecimento_id;

  UserModel({this.id, this.username, this.activated, this.estabelecimento_id, this.tipoUser});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    activated = json['activated'];
    estabelecimento_id = json['estabelecimento_id'];
    tipoUser = json['tipoUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['activated'] = this.activated;
    data['estabelecimento_id'] = this.estabelecimento_id;
    data['tipoUser'] = this.tipoUser;
    return data;
  }
}