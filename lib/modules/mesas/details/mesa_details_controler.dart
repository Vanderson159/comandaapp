import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class MesaDetailsController extends GetxController{
  TextEditingController itemPedido =  TextEditingController();
  final formKeyDetail = GlobalKey<FormState>(); //formkey do formulario de mesa detail
  RxBool attWidget = false.obs;

}