import 'package:comandaapp/modules/mesas/details/itens/mesa_item_view.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mesa_details_view.dart';

class MesaItemController extends GetxController{

  TextEditingController contadorController = TextEditingController();
  RxInt qtd = 01.obs;
  final pedidosList = <ListMesaItem>[].obs;

  @override
  void onInit(){
    gerarLista();
    super.onInit();
  }

  gerarLista(){ //Percorre a primeira lista de mesas e adiciona os itens na nova lista observável
    for(int i = 0; i < itensPedido.length; i++){
      // final mesa = MesaModel(mesalist[i].id, mesalist[i].numero, mesalist[i].estabelecimento_id, mesalist[i].disponivel, false.obs);
      final pedido = itensPedido[i];
      pedidosList.add(pedido);
    }
  }

  //TODO: Ainda falta o resto

  void incrementar(){
    qtd.value++;
    update();
  }

  void decrementar(BuildContext context){
    if(qtd.value < 2){
      //TODO: abrir dialog de remover
      removeItem(context);
      qtd.value = 01;
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