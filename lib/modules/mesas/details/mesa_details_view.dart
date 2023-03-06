import 'package:comandaapp/componentes/willPopScope.dart';
import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/details/itens/mesa_item_view.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaDetails extends GetView<MesaDetailsController> {
  final MesaModel? mesaModel;
  MesaDetails({this.mesaModel});

  @override
  Widget build(BuildContext context) {
    controller.getItensComanda(mesaModel!.id);
    return WillPopScopeView(Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 0, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      //TODO verificar se o mainAxisAlignment: MainAxisAlignment.spaceBetween não fica melhor, pedir opinão dos guri
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
                                            padding: EdgeInsets.only(left: 10, top: 10),
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
                                                  decoration:
                                                  InputDecoration(
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
                                                  controller: _.itemPedido,
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
                                                ItemModel item = ItemModel(_.itemPedido.text, 1.obs, 0);
                                                _.adicionarItem(item);
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors
                                                        .grey.shade400),
                                                shape:
                                                MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(12),
                                                  ),
                                                ),
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
                    flex: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffebebeb),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(() => ListView.builder(
                        shrinkWrap: true, //força a lista a se encaixar dentro da coluna
                        itemBuilder: (context, index){
                          final ItemModel item = listItens[index];
                          item.idMesa = mesaModel!.id;
                          return ListMesaItem(item, index); //passo index para indicar a posicao na lista para poder deletar caso ele fica decrementando a quantidade
                        },
                        itemCount: listItens.length,
                      ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 30,
                      width: 170,
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
                        onPressed: () {
                          _.cleanList();
                        },
                        child: const Text('Apagar todos os itens'),
                      ),
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
                              backgroundColor:
                              const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                            onPressed: () {
                              showDialog(barrierDismissible: false, context: context, builder: (contextDialog){
                                return Obx(() => Visibility(visible: controller.loadingEncerrarPedido.value, child: Center(child: Container(height: 20, width: 20, child: CircularProgressIndicator(),),),),);
                              });
                              controller.encerrarPedido(mesaModel!.id, context);
                            },
                            child: const Text('Encerrar Pedido'),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                              const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                            onPressed: () {
                              //listItens.clear();
                            }, //TODO: Adicionar função
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
    ), 0);
  }
}
