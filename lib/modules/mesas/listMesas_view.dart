import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/initial/initial_view.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:comandaapp/modules/mesas/searchMesas/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

List<MesaModel> mesalist = [];

class ListMesaView extends GetView<ListMesaController> {
  ListMesaView({super.key});
  InitialView initialView = const InitialView();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: GetBuilder<ListMesaController>(
        init: ListMesaController(),
        builder: (_) {
          return Scaffold(
            floatingActionButton: SpeedDial(
              backgroundColor: Colors.black,
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(child: const Icon(Icons.delete), onTap: () {}),
                SpeedDialChild(child: const Icon(Icons.add), onTap: () {}),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: CustomSearchDelegate(_.listMesaModel));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      controller.initialController.nomeEstabelecimento(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
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
            ),
            body: TabBarView(
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
                Center(
                  child: FutureBuilder<List<MesaModel>>(
                    initialData: const [],
                    future: controller.buscarMesas(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;
                        case ConnectionState.waiting:
                          return const Progress();
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          mesalist = snapshot.data!;
                          controller.setListMesa(mesalist);
                          if (mesalist == null) {
                            return const FailureDialog('Falha ao listar mesas');
                          } else {
                            return Column(
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
                            );
                          }
                      }
                      return const Text('Unknown error');
                    },
                  ),
                )
              ],
            ),

          );
        },
      ),
    );
  }
}

class MesaItem extends GetView<ListMesaController> {
  final MesaModel mesaModel;
  final index;

  MesaItem({required this.mesaModel, this.index,super.key});

  String titulo() {
    String aux = mesaModel.numero.toString();
    String titulo = 'Mesa $aux';
    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    showDialog(context: context, builder: (contextDialog){
                      return AlertDialog(
                        shape:  const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        title: const Text('Abrir nova comanda'),
                        content: Text('Deseja abrir uma nova comanda na ${titulo()}?'),
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
                            onPressed: ()=> openMesaDetails(),
                            child: const Text('Sim'),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            onPressed: ()=>Get.back(),
                            child: const Text('Não'),
                          ),
                        ],
                      );
                    });
                  },
                  leading: const Image(
                    width: 50,
                    height: 50,
                    image: AssetImage('imagens/mesaverde.png'),
                  ),
                  title: Text(titulo()),
                ),
              )
            ],
          );
  }

  void openMesaDetails() { //TODO: passar o numero da mesa
    Get.toNamed('/details');
  }

}

class Progress extends StatelessWidget {
  final String message;
  const Progress({super.key, this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.blue.shade800,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(message)
          ],
        ),
      ),
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final int? flagAcao;

  const FailureDialog(this.message,
      {super.key, this.title = 'Failure', this.icon = Icons.warning, this.flagAcao});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        visible: title.isNotEmpty,
        child: Text(title),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: Colors.red,
              ),
            ),
          ),
          Visibility(
            visible: message.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          //////SIMMMM
          child: const Text("OK"),
          onPressed: () {
            Get.offAllNamed('/initial');
          },
        ),
      ],
    );
  }
}
