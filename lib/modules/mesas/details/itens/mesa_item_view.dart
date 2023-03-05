import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/modules/mesas/details/itens/mesa_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ListMesaItem extends GetView<MesaItemController>{
  ItemModel itemModel;
  RxInt qtd = 01.obs;
  int posicaoNoArray;

  ListMesaItem(this.itemModel, this.posicaoNoArray);

  @override
  Widget build(BuildContext context) {

    //if que verifica se o item possui uma quantidade maior que 1 caso sim ele atualiza o qtd com o valor do item, serve para quando os itens da comanda sao retornados do db
    if(itemModel.quantidade.value > 1){
      qtd.value = itemModel.quantidade.value;
    }

    MesaItemController controller = Get.put(MesaItemController());

    return Card(
      color: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListTile(
        textColor: Colors.white,
        title: Text(itemModel.nome),
        trailing: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.grey.shade600
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 25,
                child: Obx(
                      ()=>
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text( //TODO: Quando altera a quantidade de um item altera de todos -- para resolver isso passei o valor qtd como atributo da class ListMesaItem assim fica separados os valores e náo ocorre esse erro
                      itemModel.quantidade.value.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade500,
                borderRadius: BorderRadius.circular(8),
              ),
              width: 70,
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      print(itemModel.idMesa);
                      if(qtd.value < 2){
                        controller.removeItem(context, itemModel, posicaoNoArray);
                      }else{
                        qtd--;
                      }
                      itemModel.quantidade.value = qtd.value;
                    },
                    child: const SizedBox(
                      width: 30,
                      child: Icon(Icons.remove,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Text('|', style: TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: (){
                      qtd++;
                      itemModel.quantidade.value = qtd.value;
                    },
                    child: const SizedBox(
                      width: 30,
                      child: Icon(Icons.add, size: 20, color: Colors.black,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}