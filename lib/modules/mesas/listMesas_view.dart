import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/initial/initial_view.dart';
import 'package:comandaapp/modules/mesas/addMesas/addMesas_view.dart';
import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_view.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_view.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:comandaapp/modules/mesas/searchMesas/custom_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

List<MesaModel> mesalist = [];

class ListMesaView extends GetView<ListMesaController> {
  ListMesaView({super.key});

  InitialView initialView = const InitialView();
  ListMesaController controller = Get.put(ListMesaController());

  @override
  Widget build(BuildContext context) {
    Get.put(MesaDetailsController());
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
                SpeedDialChild(child: const Icon(Icons.delete), onTap: ()=> Get.to(()=>DeleteMesasView())),
                SpeedDialChild(child: const Icon(Icons.add), onTap: () {
                  showDialog(context: context, builder: (contextDialog){
                    return AddMesasView();
                  });
                }),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false, //desativar seta de voltar
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
                //guia de mesas ocupadas
                Center(
                  child: FutureBuilder<List<MesaModel>>(
                    initialData: const [],
                    future: _.buscarMesasOcupadas(),
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
                          _.setListMesa(mesalist);
                          if (mesalist == null) {
                            return const FailureDialog('Falha ao listar mesas');
                          } else {
                            if(mesalist.isEmpty){
                              return  const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 150,
                                  ),
                                  Text(
                                    'Atenção!',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    'Não há mesa ocupada!',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              );
                            }else{
                              return RefreshIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.black,
                                onRefresh: controller.pullRefresh,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final MesaModel mesaModel = mesalist[index];
                                    return MesaItem(mesaModel: mesaModel, index: index, isVisibleCheckBox: false, toComanda: true,);
                                  },
                                  itemCount: mesalist.length,
                                ),
                              );
                            }
                          }
                      }
                      return  const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 150,
                          ),
                          Text(
                            'Atenção!',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            'Não há mesa ocupada',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                //guia de mesas disponiveis
                Center(
                  child: FutureBuilder<List<MesaModel>>(
                    initialData: const [],
                    future: _.buscarMesas(),
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
                          _.setListMesa(mesalist);
                          if (mesalist == null) {
                            return const FailureDialog('Falha ao listar mesas');
                          } else {
                            if(mesalist.isEmpty){
                              return  const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 150,
                                  ),
                                  Text(
                                    'Atenção!',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    'Não há mesa disponível',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              );
                            }else{
                              return RefreshIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.black,
                                onRefresh: controller.pullRefresh,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final MesaModel mesaModel = mesalist[index];
                                    return MesaItem(mesaModel: mesaModel, index: index, isVisibleCheckBox: false, abrirComandaFunc: true,);
                                  },
                                  itemCount: mesalist.length,
                                ),
                              );
                            }
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
  final isVisibleCheckBox;
  bool? abrirComandaFunc = true; // atributo para definir quando o MesaItem deve abrir a janela de comanda e quando nao
  bool? toComanda = true; // atributo para definir quando o MesaItem deve levar direto para a chenela da comanda (como ocorre com as mesas ocupadas)


  MesaItem({required this.mesaModel, this.index, required this.isVisibleCheckBox, this.abrirComandaFunc, this.toComanda});

  String titulo() {
    String aux = mesaModel.numero.toString();
    String titulo = 'Mesa $aux';
    return titulo;
  }

  @override
  Widget build(BuildContext context) {

    disponivelImage(){
      if(mesaModel.disponivel == true){
        return AssetImage('imagens/mesaverde.png');
      }
      if(mesaModel.disponivel == false){
        return AssetImage('imagens/mesavermelha.png');
      }
      return AssetImage('imagens/mesaverde.png');
    }

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
                    if(mesaModel.disponivel == true && abrirComandaFunc == true){
                      showDialog(context: context, builder: (contextDialog){
                        return AlertDialog(
                          shape:  const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          title: const Text('Abrir nova comanda', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          content: RichText(text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              //Text('Deseja abrir uma nova comanda na ${titulo()}?')
                              const TextSpan(text: 'Deseja abrir uma nova comanda para a ', style: TextStyle(fontSize: 16),),
                              TextSpan(text: '${titulo()}?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                            ],
                          ),),
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
                              onPressed: (){
                                showDialog(barrierDismissible: false, context: context, builder: (contextDialog){
                                  return Obx(() => Visibility(visible: controller.loadingComanda.value, child: Center(child: Container(height: 20, width: 20, child: CircularProgressIndicator(),),),),);
                                });
                                controller.abrirComanda(mesaModel);
                              },
                              child: const Text('Sim'),
                            ),//sim
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
                    }else{
                      if(toComanda == true){
                        Get.to(() => MesaDetails(mesaModel: mesaModel,));
                      }
                    }
                  },
                  leading: Image(
                    width: 50,
                    height: 50,
                    image: disponivelImage(),
                  ),
                  title: Text(titulo()),
                  trailing: Visibility(
                    visible: isVisibleCheckBox,
                    child: SizedBox(
                      width: 35,
                      child: Obx( () =>
                        Checkbox(
                          value: mesaModel.isCheck!.value,
                          onChanged: (value){
                            mesaModel.isCheck!.value = !mesaModel.isCheck!.value;
                          },
                          activeColor: Colors.black,
                          checkColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
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
