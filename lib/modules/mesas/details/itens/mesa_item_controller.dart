import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/modules/mesas/details/itens/mesa_item_view.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaItemController extends GetxController{
  TextEditingController contadorController = TextEditingController();
  MesaDetailsController mesaDetailsController = MesaDetailsController();
  final pedidosList = <ListMesaItem>[].obs;

  @override
  void onInit(){
    super.onInit();
  }


 removeItem(BuildContext context, ItemModel itemModel, int posicaoArray){
    return showDialog(context: context, builder: (contextDialog){
      return AlertDialog(
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        //TODO: Não ta pegando o estilo do app
        title: const Text('AVISO'),
        content: Text('Tem certeza que deseja remover o ultimo item de ${itemModel.nome}'),
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
              listItens.removeAt(posicaoArray);//removendo pela posicao no array
              mesaDetailsController.encerrarPedido(itemModel.idMesa);
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