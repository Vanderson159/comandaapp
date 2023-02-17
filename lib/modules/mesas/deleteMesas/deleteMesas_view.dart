import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_controller.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DeleteMesasView extends GetView<DeleteMesasController>{
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
          ElevatedButton(
            onPressed: (){},
            child: Text('Selecionar Tudo'),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true, //força a lista a se encaixar dentro da coluna
              itemBuilder: (context, index) {
                final MesaModel mesaModel = mesalist[index];
                return MesaItem(mesaModel: mesaModel, index: index,);
              },
              itemCount: mesalist.length, //define tamanho da lista
            ),
            flex: 10,
          ),
          ElevatedButton(
            onPressed: (){},
            child: Text('Deletar Mesa'),
          ),
        ],
      ),
    );
  }
}