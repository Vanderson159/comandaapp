import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_controller.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DeleteMesasView extends GetView<DeleteMesasController>{

  bool isVisible = true;
  bool isMarked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Deletar Mesas'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: (){

                if(isMarked == true){
                  isMarked = false;
                }
                else{
                  isMarked = true;
                }
                ListMesaView().selectBoxes(isMarked);
              },
              child: Text('Selecionar Tudo'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true, //força a lista a se encaixar dentro da coluna
              itemBuilder: (context, index) {
                final MesaModel mesaModel = mesalist[index];
                return MesaItem(mesaModel: mesaModel, index: index, visibleCheckBox: isVisible,);
              },
              itemCount: mesalist.length, //define tamanho da lista
            ),
            flex: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                      ),
                    ),
                    onPressed: (){},
                    child: Text('Deletar Mesa'),
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