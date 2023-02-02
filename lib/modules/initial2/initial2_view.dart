import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'initial2_controller.dart';

class InitialView2 extends GetView<Initial2Controller> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
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
                    'PAPA GULA',
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
                title: Text('Mesas Adicionadas!', textAlign: TextAlign.center,),
                content: Container(
                  height: 110,
                  child: Column(
                    children: [
                      Text(
                          'Para adicionar novas mesas, selecione Adicionar Mesa na aba Disponíveis.'),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Finalizar'),
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
          )),
    );
  }
}
