import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'initial_controller.dart';

class InitialView extends GetView<InitialController> {
  @override
  Widget build(BuildContext context) {
    controller.contadorController.text = controller.cont.toString();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GetBuilder<InitialController>(
        init: InitialController(),
        builder: (_){
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Text(
                        '${_.nomeRestaurante}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Icon(
                      Icons.person_outline,
                      color: Colors.black,
                    ),
                  ],
                ),
                bottom: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      text: 'Ocupadas',
                    ),
                    Tab(
                      text: 'Disponíveis',
                    ),
                  ],
                ),
              ),
              body: Stack(
                children: [
                  TabBarView(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 150,
                            ),
                            Text(
                              'Atenção',
                              style: TextStyle(fontSize: 30),
                            ),
                            Text(
                              'Não há mesa ocupada',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text(""),
                      )
                    ],
                  ),
                  Opacity(
                    opacity: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                    ),
                  ),
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    title: Text('Mesas'),
                    content: Container(
                      height: 110,
                      child: Column(
                        children: [
                          Text(
                              '${_.labelDialog}'),
                          Row(
                            children: [
                              Text('Qtd mesas: '),
                              ElevatedButton(
                                onPressed: () {
                                  controller.decrementar();
                                  controller.contadorController.text =
                                      controller.cont.toString();
                                },
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(35, 35),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: controller.contadorController,
                                  decoration:
                                  InputDecoration(border: InputBorder.none),
                                  cursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.incrementar();
                                  controller.contadorController.text =
                                      controller.cont.toString();
                                },
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(35, 35),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.offAllNamed('/initial2');
                        },
                        child: Text('Adicionar Mesas'),
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }
}
