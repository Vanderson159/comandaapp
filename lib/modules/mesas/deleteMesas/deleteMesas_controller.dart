import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

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