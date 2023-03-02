import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaItemController extends GetxController{

  TextEditingController contadorController = TextEditingController();
  RxInt qtd = 01.obs;

  void incrementar(){
    qtd.value++;
    update();
  }

  void decrementar(BuildContext context){
    if(qtd.value < 1){
      //TODO: abrir dialog de remover
      removeItem(context);
      qtd.value = 00;
      update();
    }
    else{
      qtd.value--;
      update();
    }
  }

  Future<dynamic> removeItem(BuildContext context){
    return showDialog(context: context, builder: (contextDialog){
      return AlertDialog(
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        //TODO: Não ta pegando o estilo do app
        title: const Text('Deletar mesas'),
        content: const Text('Tem certeza que deseja deletar as mesas selecionadas?'),
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: (){
              Get.back();
            },
            child: const Text('Sim'),
          ),//sim
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<
                  RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            onPressed: ()=>Get.back(),
            child: const Text('Não'),
          ),
        ],
      );
    });
  }

}