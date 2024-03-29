import 'dart:convert';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:comandaapp/data/base_url.dart';
import 'package:http/io_client.dart';

List<MesaModel> mesasDisponiveis = [];

class MesaApiClient{
  final http = IOClient(HttpOverridesProvider.overrides());
  final box = GetStorage('guardaapp');
  String erro = 'ERRO NO MESA API CLIENT';

  Future verificaMesas(String accesstoken) async {
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try {
      var response = await http.get(Uri.parse('$baseUrl/verificaMesas'),
          headers: {"Authorization": 'Bearer $token'});
      if (response.statusCode == 200) {
        var teste = jsonDecode(response.body);
        int countMesas = teste[0]['COUNT(mesa_id)'];
        return countMesas;
      } else {
        return 0;
      }
    } catch (err) {
      Get.defaultDialog(
        title: "Erro na verificacao das mesas",
        content: Text("$err"),
      );
    }
  }

  Future insertMesas(List<MesaModel> mesas, int idEstabelecimento, String accesstoken) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse(baseUrlMesa), headers: {
        "Authorization": 'Bearer $token'
      }, body: {
         "estabelecimento_id" : idEstabelecimento.toString(),
         "listMesa": MesaModel.listToJson(mesas).toString(),
         "numeroMesas": mesas.length.toString(),
      });
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch (err) {
      return 0;
    }

  }

  Future<List<MesaModel>> listarMesas(String accesstoken, int ocupada) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try{
      var response = await http.get(Uri.parse(baseUrlMesa),
          headers: {"Authorization": 'Bearer $token'});
      if(response.statusCode == 200){
        List list = json.decode(response.body);
        List<MesaModel>? mesas = [];
        for (var i = 0; i < list.length; i++) {
          MesaModel aux = MesaModel.fromJson(list[i]);
          if(ocupada == 0){
            if(aux.disponivel == true){
              mesas.add(MesaModel.fromJson(list[i]));
              mesasDisponiveis.add(MesaModel.fromJson(list[i]));
            }
          }
          if(ocupada == 1){
            if(aux.disponivel == false){
              mesas.add(MesaModel.fromJson(list[i]));
            }
          }
        }

        return mesas;
      }else{
        Get.defaultDialog(
            title: "Erro ao listar mesas",
            content: Text(
                "${jsonDecode(response.body)['error']} : Falha ao listar"));
      }
    }catch (err){
      Get.defaultDialog(
        title: "Erro na listagem das mesas",
        content: Text("$err"),
      );
    }
    return json.decode(erro);
  }

  Future indisponibilizar(String accesstoken, MesaModel mesaModel) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try{
      var response = await http.put(Uri.parse('${baseUrlMesa}/${mesaModel.mesa_id}'), headers: {
        "Authorization": 'Bearer $token'
      }, body: {
        "numero" : mesaModel.numero.toString(),
        "estabelecimento_id" : mesaModel.estabelecimento_id.toString(),
        "disponivel" : 0.toString()
      });
      if (response.statusCode == 200) {
        print(response.body);
        return 1;
      } else {
        return 0;
      }
    }catch(err){
      return 0;
    }
  }

  Future deletarMesas(List<MesaModel> mesas, String accesstoken) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse('${baseUrl}/deletarMesas'), headers: {
        "Authorization": 'Bearer $token'
      },
          body: {
            "listMesa": MesaModel.listToJson(mesas).toString(),
            "numeroMesas": mesas.length.toString(),
          });
      print(response.body);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch (err) {
      return 0;
    }
  }
}