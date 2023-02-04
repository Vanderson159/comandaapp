import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/estabelecimento_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/model/user_model.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController{
  final box = GetStorage('comandaapp');
  int contMesa = 00;
  int totalMesa = 1;
  late String nomeRestaurante;
  String labelDialog = 'Adicione quantas mesas estarão disponíveis em seu estabelecimento!';
  TextEditingController contadorController = TextEditingController();
  String acaoBtnLabel = 'Adicionar Mesas';
  List<MesaModel> listMesa = [];
  MesaApiClient mesaApiClient = MesaApiClient();
  RxBool loadingSend = false.obs;
  RxBool showAdicionarMesa = true.obs;
  RxBool enabledFuncBtn = true.obs;

  int? estabelecimentoId(){
    UserModel userModel = box.read('userStorage');
    EstabelecimentoModel? estabelecimentoModel = userModel.estabelecimentoModel;
    if(estabelecimentoModel!.id != null){
      return estabelecimentoModel.id;
    }
    return 0;
  }

  void inserirMesas(int contMesa){
    loadingSend.value = true;
    AuthModel auth = box.read('auth');
    String accesstoken = auth.accessToken.toString();
    int? idEstabelecimento = estabelecimentoId();

    do{
      MesaModel mesaAux = MesaModel(0, totalMesa, idEstabelecimento);
      listMesa.add(mesaAux);
      totalMesa++;
    }while(totalMesa <= contMesa);

    mesaApiClient.insertMesas(listMesa, idEstabelecimento!, accesstoken).then((value) => {
      if(value == 1){
        loadingSend.value = false,
        enabledFuncBtn.value = false,
        print('inserido mesas com sucesso')
      }
    });

    showAdicionarMesa.value = false;
    acaoBtnLabel = 'Finalizar';
    labelDialog = 'Para adicionar novas mesas, selecione Adicionar Mesa na aba Disponíveis.';
    update();
  }

  UserModel userLogado(){
     UserModel userModel = box.read('userStorage');
     return userModel;
  }

  EstabelecimentoModel? estabelecimento(){
    UserModel userModel = box.read('userStorage');
    EstabelecimentoModel? estabelecimentoModel = userModel.estabelecimentoModel;
    return estabelecimentoModel;
  }

  String nomeEstabelecimento(){
    String? nome = estabelecimento()!.nome;
    if(nome!.isNotEmpty){
      return nome;
    }
    return '';
  }

  void incrementar(){
    contMesa++;
    update();
  }

  void decrementar(){
    if(contMesa < 1){
      contMesa = 0;
      update();
    }else{
      contMesa--;
      update();
    }
  }
}