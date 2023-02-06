import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:comandaapp/data/repository/auth_repository.dart';
import 'package:comandaapp/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{
  final repositoryAuth = Get.find<AuthRepository>(); //pega o auth repository iniciado no bind
  final repositoryUser = Get.find<UserRepository>(); //pega o user repository iniciado no bind
  final formKey = GlobalKey<FormState>(); //formkey do formulario de login
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main

  AuthModel? auth;
  UserModel? userModel;

  TextEditingController usernameCtrl =  TextEditingController();
  TextEditingController passwordCtrl =  TextEditingController();

  RxBool showPassword = false.obs;
  RxBool loading = false.obs;

  void login() async{
    if(formKey.currentState!.validate()){
      loading.value = true;
      auth = await repositoryAuth.login(usernameCtrl.text, passwordCtrl.text);
      userModel = await repositoryUser.showUser(auth!.user!.id!.toInt(), auth!.accessToken.toString());

      if(!auth.isNull){
        box.write('auth', auth);
        box.write('userStorage', userModel);
        Get.offAllNamed('/');
      }
      loading.value = false;
    }
  }


  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

}