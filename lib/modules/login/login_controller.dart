import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:comandaapp/data/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  final repository = Get.find<AuthRepository>(); //pega o auth repository iniciado no bind
  final formKey = GlobalKey<FormState>(); //formkey do formulario de login
  AuthModel? auth;
  final box = GetStorage('guardaapp'); //instancia definida no arquivo main

  TextEditingController usernameCtrl =  TextEditingController();
  TextEditingController passwordCtrl =  TextEditingController();

  RxBool showPassword = false.obs;
  RxBool loading = false.obs;

  void login() async{
    if(formKey.currentState!.validate()){
      loading.value = true;
      auth = await repository.login(usernameCtrl.text, passwordCtrl.text);
      UserModel? userStorage = auth!.user;

      if(!auth.isNull){
        box.write('auth', auth);
        box.write('userStorage', userStorage);
        Get.offAllNamed('/');
      }
      loading.value = false;
    }
  }

  void limpar(){
    usernameCtrl.text = '';
    passwordCtrl.text = '';
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

}