class ComandaModel {
  int? id;
  String? itens;
  String? inicio_comanda;
  String? fim_comanda;
  int? mesa_idmesas;

  ComandaModel(
      this.id,
      this.itens,
      this.inicio_comanda,
      this.fim_comanda,
      this.mesa_idmesas);

  ComandaModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    itens = json['itens'];
    inicio_comanda = json['inicio_comanda'];
    fim_comanda = json['fim_comanda'];
    mesa_idmesas = json['mesa_idmesas'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['itens'] = this.itens;
    data['inicio_comanda'] = this.inicio_comanda;
    data['fim_comanda'] = this.fim_comanda;
    data['mesa_idmesas'] = this.mesa_idmesas;
    return data;
  }
}
