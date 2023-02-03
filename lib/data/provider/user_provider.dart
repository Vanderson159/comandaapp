import 'dart:convert';

import 'package:comandaapp/data/base_url.dart';
import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserApiClient{
  final http.Client httpClient = http.Client();
  final box = GetStorage('comandaapp');
  String erro = 'ERRO NO AUTH API CLIENT';

  Future showUser(int idUser, String accessToken) async{
    String token = '';
    if (accessToken.isNotEmpty) {
      token = accessToken;
    }
    try{
      var response = await http.get(Uri.parse('${baseUrlUser}/${idUser}'), headers: {
        "Authorization": 'Bearer ' + token
      });
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        Get.defaultDialog(
            title: "Busca de User",
            content: Text(
                "${jsonDecode(response.body)['error']} : Falha ao Buscar User"));
      }
    } catch (err){
      Get.defaultDialog(
        title: "Erro na busca de user",
        content: Text("$err"),
      );
    }
  }
}