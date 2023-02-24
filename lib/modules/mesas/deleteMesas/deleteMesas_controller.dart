import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

  List<MesaModel> deleteList = [];

  List<dynamic>? toListDelete(BuildContext context){
    return mesalist.map((mesa) => deleteList.add(mesa)).toList();//retornando null

  }

}