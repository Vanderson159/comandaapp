import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/details/itens/mesa_item_view.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<ListMesaItem> itensPedido = [];

class MesaDetails extends GetView<MesaDetailsController> {
  final MesaModel? mesaModel;
  MesaDetails({this.mesaModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Get.offNamed('/listMesas');
            },
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Mesa ${mesaModel!.numero.toString()}',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: GetBuilder<MesaDetailsController>(
          init: MesaDetailsController(),
          builder: (_) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Pedidos',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (contextDialog) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      backgroundColor: Colors.grey.shade800,
                                      child: Container(
                                        width: Get.width,
                                        height: Get.height * 0.24,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 10),
                                              child: Text(
                                                'Item Pedido',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5, left: 5, top: 15),
                                              child: Container(
                                                height: 40,
                                                child: Form(
                                                  key: _.formKeyDetail,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      filled:
                                                          true, //<-- SEE HERE
                                                      fillColor: Colors.grey
                                                          .shade400, //<-- SEE HERE
                                                    ),
                                                    controller:
                                                        _.itemPedido,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              // padding: EdgeInsets.only(left: Get.width * 0.50, top: 10),
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.50,
                                                  top: 15),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                   ListMesaItem mesaItem = ListMesaItem(_.itemPedido.text);
                                                   itensPedido.add(mesaItem);
                                                   Get.offAll(MesaDetails(mesaModel: mesaModel,));
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll(Colors.grey.shade400),
                                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    ),),
                                                ),
                                                child: const Text(
                                                  'Adicionar',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Image.asset(
                              'imagens/iconePedidos.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffebebeb),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: verificaPedidos(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Colors.black,
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                              onPressed: () {}, //TODO: Adicionar função
                              child: const Text('Encerrar Pedido'),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                  Colors.black,
                                ),
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                              ),
                              onPressed: () {}, //TODO: Adicionar função
                              child: const Text('Encerrar Comanda'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  addItemPedido() {}

  verificaPedidos() {
    //logica so para teste
    if (itensPedido.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: itensPedido[index],
          );
        },
        itemCount: itensPedido.length,
      );
    }
    else {
      return null;
    }
  }

}
