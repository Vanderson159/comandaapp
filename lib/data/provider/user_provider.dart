import 'dart:convert';
import 'package:comandaapp/data/base_url.dart';
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

  Future insertDeviceToken(String idUser, String accesstoken, String tokenDevice) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try{
      var response = await http.post(Uri.parse(baseUrlDeviceToken), headers: {
        "Authorization": 'Bearer $token'
      },
          body: {
            "id" : idUser.toString(),
            "token_device": tokenDevice.toString(),
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

  Future insertUserToken(String idUser, String accesstoken) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }
    try{
      var response = await http.post(Uri.parse(baseUrlUserToken), headers: {
        "Authorization": 'Bearer $token'
      },
          body: {
            "id" : idUser.toString(),
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
}