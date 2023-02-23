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
                if(isAllCheck == false.obs){
                  isAllCheck = true.obs;
                }
                else{
                  isAllCheck = false.obs;
                }
                ListMesaView().selectBoxes(isAllCheck);
              },
              child: const Text('Selecionar Tudo'),
            ),
          ),
          Expanded(
            flex: 10,
            child: ListView.builder(
              shrinkWrap: true, //força a lista a se encaixar dentro da coluna
              itemBuilder: (context, index) {
                final MesaModel mesaModel = mesalist[index];
                return MesaItem(mesaModel: mesaModel, index: index, isVisibleCheckBox: isVisible,);
              },
              itemCount: mesalist.length, //define tamanho da lista
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
                    onPressed: (){},
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