import 'package:comandaapp/modules/mesas/details/itens/mesa_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ListMesaItem extends GetView<MesaItemController>{
  String titulo;

  ListMesaItem(this.titulo);

  @override
  Widget build(BuildContext context) {

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
        title: Text(titulo),
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
                    child: Text( //TODO: Quando altera a quantidade de um item altera de todos
                      controller.contadorController.text = controller.qtd.value.toString(),
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
                      controller.decrementar(context);
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
                      controller.incrementar();
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