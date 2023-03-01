import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

  final listaMesas = <MesaModel>[].obs;
  bool tagMarcados = false;

  @override
  void onInit(){
    gerarLista();
    super.onInit();
  }

  gerarLista(){
    for(int i = 0; i < mesalist.length; i++){
      final mesa = MesaModel(mesalist[i].id, mesalist[i].numero, mesalist[i].estabelecimento_id, mesalist[i].disponivel, false.obs);
      listaMesas.add(mesa);
    }
  }

  selectAll(){
    if(tagMarcados == false){
      for(int i = 0; i < listaMesas.length; i++){
        final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, true.obs);
        listaMesas[i] = mesa;
      }
      tagMarcados = true;
    }else{
      if(tagMarcados = true){
        for(int i = 0; i < listaMesas.length; i++){
          final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, false.obs);
          listaMesas[i] = mesa;
        }
        tagMarcados = false;
      }
    }
  }

  selectCheckBox(int id){
    for(int i = 0; i < listaMesas.length; i++){
      if(listaMesas[i].id == id){
        var checkBox = listaMesas[i].isCheck;
        if(checkBox == true.obs){
          checkBox == false.obs;
        }else{
          if(checkBox == false.obs){
            checkBox == true.obs;
          }
        }
        final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, checkBox);
        listaMesas[i] = mesa;
      }
    }
  }





  //TODO: preciso que essa func retorne uma List<MesaModel> contendo as mesas que devem ser deletadas, vou precisar ter acesso ao id delas para poder deletar na api
  //TODO: tem que ser uma lista List<MesaModel> também para usar os parses para json que ja tem nas models
  List<dynamic>? toListDelete(BuildContext context, bool isAllCheck){
    List<MesaModel> deleteList = [];
    mesalist.where((element) {
      if(isAllCheck == true){
        deleteList = mesalist;
      }
      else if(element.isCheck == true){ //TODO: Quando seleciona todas não funciona
        deleteList.add(element);
      }
      return true;
    }).toList();

    return deleteList;
  }


}