import 'package:comandaapp/modules/mesas/addMesas/addMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'initial_controller.dart';

class InitialView extends GetView<InitialController> {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    appBar(String nomeEstabelecimento) {
      return AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Text(
                nomeEstabelecimento,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
            ),
          ],
        ),
        bottom: const TabBar(
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
      );
    }
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GetBuilder<InitialController>(
        init: InitialController(),
        builder: (_) {
          return Scaffold(
            appBar: appBar(
                _.nomeEstabelecimento()), //definindo nome do estabelecimento
            body: Stack(
              children: [
                TabBarView(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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

                //Definindo a janela de definição da qntd de mesas
                AddMesasView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
