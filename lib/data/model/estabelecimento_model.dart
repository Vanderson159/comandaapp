class EstabelecimentoModel {
  int? id;
  int? cnpj;
  String? nome;
  String? email;
  String? telefone;

  EstabelecimentoModel(
      {this.id, this.cnpj, this.nome, this.email, this.telefone});

  EstabelecimentoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cnpj = json['cnpj'];
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cnpj'] = this.cnpj;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    return data;
  }
}