import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/data/repository/auth_repository.dart';
import 'package:comandaapp/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController{

  final repositoryAuth = Get.find<AuthRepository>(); //pega o auth repository iniciado no bind
  final repositoryUser = Get.find<UserRepository>(); //pega o user repository iniciado no bind
  final formKey = GlobalKey<FormState>(); //formkey do formulario de login
  final box = GetStorage('comandaapp'); //instancia definida no arquivo main
  MesaApiClient mesaApiClient = MesaApiClient();

  AuthModel? auth;
  UserModel? userModel;

  TextEditingController usernameCtrl =  TextEditingController();
  TextEditingController passwordCtrl =  TextEditingController();

  RxBool showPassword = false.obs;
  RxBool loading = false.obs;
  RxBool isButtonActive = false.obs;

  void login() async{
    if(formKey.currentState!.validate()){
      loading.value = true;
      auth = await repositoryAuth.login(usernameCtrl.text, passwordCtrl.text);
      userModel = await repositoryUser.showUser(auth!.user!.id!.toInt(), auth!.accessToken.toString());

      if(!auth.isNull){
        box.write('auth', auth);
        box.write('userStorage', userModel);
        mesaApiClient.verificaMesas(auth!.accessToken.toString()).then((value){
          if(value > 0){
            print('EXISTE MESAS ${value}');
            Get.offAllNamed('/listMesas');
          }else{
            print('NAO EXISTE MESAS');
            Get.offAllNamed('/');
          }
        });
      }
      loading.value = false;
    }
  }

  Color activeButton(active){
    if(active){
      return Colors.black;
    }
    else{
      return Colors.grey.shade200;
    }
  }

}