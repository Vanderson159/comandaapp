import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

  List<MesaModel> deleteList = [];

  List<dynamic>? toListDelete(BuildContext context){

    mesalist.where((element) {
      if (element.isCheck == true){
        print(element);
        deleteList.add(element);
      }
      return true;
    }).toList();

    return deleteList;
  }


}