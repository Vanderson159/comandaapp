import 'dart:convert';
import 'package:comandaapp/data/base_url.dart';
import 'package:comandaapp/data/provider/http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';

class AuthApiClient {
  String erro = 'ERRO NO AUTH API CLIENT';
  final http = IOClient(HttpOverridesProvider.overrides());

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var response = await http.post(Uri.parse(baseUrlLogin),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        Get.defaultDialog(
            title: "Login",
            content: Text(
                "${jsonDecode(response.body)['error']} : Usuário Inválido"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed('/login');
                },
                child: const Text('OK'),
              ),
            ]);
      }
    } catch (err) {
      Get.defaultDialog(
          title: "Falha",
          content: Text(
              "$err"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/login');
              },
              child: const Text('OK'),
            ),
          ]);
    }
    return json.decode(erro);
  }

  Future<Map<String, dynamic>> register(
      String username, String password) async {
    try {
      var response = await http.post(Uri.parse(baseUrlRegister),
          body: {"username": username, "password": password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        debugPrint('erro -get: ${response.body}');
      }
    } catch (err) {
      print(err);
    }
    return json.decode(erro);
  }
}
