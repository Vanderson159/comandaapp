import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_controller.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteMesasView extends GetView<DeleteMesasController>{

  final bool isVisible = true;
  RxBool isAllCheck = false.obs;

  DeleteMesasView({super.key});

  @override
  Widget build(BuildContext context) {
    //fui obrigado a declarar o controller porque com o GetView não tava achando
    DeleteMesasController controller = Get.put(DeleteMesasController());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Deletar Mesas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: (){
                controller.selectAll();
              },
              child: const Text('Selecionar Tudo'),
            ),
          ),
          Expanded(
            flex: 10,
            child: Obx(() => ListView.builder(
              shrinkWrap: true, //força a lista a se encaixar dentro da coluna
              itemBuilder: (context, index) {
                final MesaModel mesaModel = controller.listaMesas[index];
                return MesaItem(
                  mesaModel: mesaModel,
                  index: index,
                  isVisibleCheckBox: isVisible,
                );
              },
              itemCount: controller.listaMesas.length, //define tamanho da lista
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      //TODO: Alternar cor se tiver alguma mesa selecionada
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                      ),
                    ),
                    onPressed: (){
                      //TODO: buscar pela lista as mesas com checkbox marcado e armazenar na deleteList
                      showDialog(context: context, builder: (contextDialog){
                      return AlertDialog(
                        shape:  const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
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
                              showDialog(barrierDismissible: false, context: context, builder: (contextDialog){
                                return Obx(() => Visibility(visible: controller.loadingDelete.value, child: Center(child: Container(height: 20, width: 20, child: CircularProgressIndicator(),),),),);
                              });
                              controller.deletarMesas();
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
                            onPressed: (){
                              Get.back();
                            },
                            child: const Text('Não'),
                          ),
                        ],
                      );
                      });
                    },
                    child: const Text('Deletar Mesa'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}