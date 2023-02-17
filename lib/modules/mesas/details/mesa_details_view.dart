import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaDetails extends GetView<MesaDetailsController> {
  //const MesaDetails({super.key});

  String titulo = '';

  MesaDetails({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: (){
              Get.offAndToNamed('/listMesas');
              },
            child: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
          ),
          title: Text(
            titulo, //TODO: Mostrar numero da mesa
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:  const Color(0xffebebeb),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView(
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
                                onTap: (){
                                  addPedido(context);
                                  },
                                child: Image.asset(
                                  'imagens/iconePedidos.png',
                                ),
                              ),
                              //TODO: Puxar as informações da mesa selecionada

                            ],
                          ),
                        ),
                      ],
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
                              backgroundColor: const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                          ),
                          onPressed: (){}, //TODO: Adicionar função
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
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                          ),
                          onPressed: (){}, //TODO: Adicionar função
                          child: const Text('Encerrar Comanda'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addPedido(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pedidos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Item 1 pedido'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}