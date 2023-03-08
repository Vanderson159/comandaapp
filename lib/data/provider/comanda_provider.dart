import 'dart:convert';
import 'package:comandaapp/data/base_url.dart';
import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ComandaApiClient{
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp');

  Future abrirComanda(MesaModel mesaModel, String accesstoken, var dateTime) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse(baseUrlComanda), headers: {
        "Authorization": 'Bearer $token'
      }, body: {
        "itens" : "",
        "inicio_comanda": dateTime.toString(),
        "fim_comanda": "",
        "mesa_idmesas": mesaModel.id.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch(err){
      return 0;
    }
  }

  Future inserirItensToComanda(String jsonListItens, String accesstoken, int id) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse('${baseUrl}/itensToComanda'), headers: {
        "Authorization": 'Bearer $token'
      }, body: {
        "jsonItens" : jsonListItens,
        "idMesa" : id.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        print('SUCESSO');
        return 1;
      } else {
        return 0;
      }
    }catch(err){
      return 0;
    }
  }

  Future getItensComanda(String accesstoken, int idMesa) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try{
      var response = await http.post(Uri.parse('${baseUrl}/getItensComanda'),
          headers: {"Authorization": 'Bearer $token'},
          body: {"id" : idMesa.toString()},
      );
      if(response.statusCode == 200){
        List list = json.decode(response.body);
        for(int i = 0; i < list.length; i++){
          int quantidade = list[i]['quantidade'];
          ItemModel item = ItemModel(list[i]['nome'], quantidade.obs, 0);
          listItens.add(item);
        }
        return 1;
      }
    }catch(err){
      print('ERRo');
    }
  }

  Future fecharComanda(String accesstoken, int idMesa, String fim_comanda) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse('${baseUrl}/encerrarComanda'),
          headers: {
            "Authorization": 'Bearer $token'
          }, body: {
            "id" : idMesa.toString(),
            "fim_comanda" : fim_comanda.toString(),
          });
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch(err){
      return 0;
    }
  }
}