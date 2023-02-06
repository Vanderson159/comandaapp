import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/initial/initial_view.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

List<MesaModel>? mesalist = [];

class ListMesaView extends GetView<ListMesaController> {
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
                SpeedDialChild(
                    child: Icon(Icons.delete),
                    onTap: (){
                    }
                ),
                SpeedDialChild(
                    child: Icon(Icons.add),
                    onTap: (){
                    }
                ),
              ],
            ),
            appBar: InitialView.appBar(
                controller.initialController.nomeEstabelecimento()),
            body: TabBarView(
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
                  child: FutureBuilder<List<MesaModel>>(
                    initialData: [],
                    future: controller.buscarMesas(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          break;
                        case ConnectionState.waiting:
                          return Progress();
                        case ConnectionState.active:
                          break;
                        case ConnectionState.done:
                          mesalist = snapshot.data;
                          if (mesalist == null) {
                            return FailureDialog('Falha ao listar mesas');
                          } else {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final MesaModel mesaModel = mesalist![index];
                                return MesaItem(mesaModel, index);
                              },
                              itemCount: mesalist!.length,
                            );
                          }
                      }
                      return Text('Unknown error');
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
  final TextEditingController _pesquisaController = TextEditingController();

  MesaItem(this.mesaModel, this.index);

  String titulo() {
    String aux = mesaModel.numero.toString();
    String titulo = 'Mesa $aux';
    return titulo;
  }

  @override
  Widget build(BuildContext context) {
    return index == 0
        ? Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: Image(
                    width: 50,
                    height: 50,
                    image: AssetImage('imagens/mesaverde.png'),
                  ),
                  title: Text(titulo()),
                ),
              )
            ],
          )
        : Column(
            children: [
              Card(
                child: ListTile(
                  onTap: () {},
                  leading: Image(
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
}

class Progress extends StatelessWidget {
  final String message;
  Progress({this.message = 'Loading'});

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
            SizedBox(
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

  FailureDialog(this.message,
      {this.title = 'Failure', this.icon = Icons.warning, this.flagAcao});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        child: Text(title),
        visible: title.isNotEmpty,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: Colors.red,
              ),
            ),
            visible: icon != null,
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            visible: message.isNotEmpty,
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          //////SIMMMM
          child: Text("OK"),
          onPressed: () {
            Get.offAllNamed('/initial');
          },
        ),
      ],
    );
  }
}
