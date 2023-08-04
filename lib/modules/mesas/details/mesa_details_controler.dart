import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/data/provider/comanda_provider.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/model/mesa_model.dart';

var listItens = <ItemModel>[].obs; //LISTA QUE ARMAZENA OS ITENS ADICIONADOS ENTAO TEM QUE DELETAR ELA NA HORA DE ENVIAR ELES PQ SE NAO VAI ACONTECER O MESMO BUG DO ADICIONAR

class MesaDetailsController extends GetxController {
  ComandaApiClient comandaApiClient = ComandaApiClient();
  ListMesaController listMesaController = ListMesaController();
  TextEditingController itemPedido = TextEditingController();
  final formKeyDetail = GlobalKey<FormState>(); //formkey do formulario de mesa detail
  RxBool attWidget = false.obs;
  RxBool loadingEncerrarPedido = false.obs;
  RxBool loadingEncerrarComanda = false.obs;
  late int idMesa;
  MesaModel mesaModel = MesaModel(0, 0, 0, false, false.obs);
  final box = GetStorage('comandaapp');

  @override
  void onInit() async{
    super.onInit();
    var data = Get.arguments;
    if(data != null){
      if(data['mesaId'] != null){
        mesaModel = MesaModel(int.parse(data['mesaId']), int.parse(data['mesaNumero']), int.parse(data['mesaEstabelecimentoId']), false, false.obs);
      }
    }
  }

  void verificaAuth(){
    if(box.read('auth') == null){
      Get.offAllNamed('/login');
    }
  }

  void getItensComanda(int mesaId) {
    comandaApiClient.getItensComanda(listMesaController.tokenAccess(), mesaId);
  }

  void cleanList() {
    ItemModel.listToJson(listItens);
    listItens.clear();
  }

  void adicionarItem(ItemModel itemModel) {
    listItens.add(itemModel);
    Get.back();
  }



  void printarItens() {
    listItens.forEach((element) {
      print(element.nome);
      print(element.quantidade);
    });
  }

  void encerrarPedido(int id, BuildContext context) {
    loadingEncerrarPedido.value = true;
    comandaApiClient.inserirItensToComanda(ItemModel.listToJson(listItens).toString(), listMesaController.tokenAccess(), id).then((value) {
      if (value == 1) {
        loadingEncerrarPedido.value = false;
        Get.back(); // chamo esse get back pq senao fica uma tela escura depois de clicar em OK
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:  const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Pedido Realizado!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
              content: const Text('Seu pedido foi efetuado com sucesso!', style: TextStyle(fontSize: 16),),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    listItens.clear();
                    Get.offAllNamed('/listMesas');
                    },
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      } else {
        //mensagem de erro caso de algo errado
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:  const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Erro ao encerrar pedido :(', style: TextStyle(fontWeight: FontWeight.bold),),
              content: const Text('Ocorreu algum problema ao tentar encerrar seu pedido, seus itens não foram salvos. Por favor tente novamente!'),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.back(),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      }
    });
  }

  void encerrarComanda(int idMesa, BuildContext context){
    loadingEncerrarComanda.value = true;
    comandaApiClient.fecharComanda(listMesaController.tokenAccess(), idMesa, listMesaController.horarioBrasilia().toString()).then((value){
      if(value == 1){
        listItens.clear();
        loadingEncerrarComanda.value = false;
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:  const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Comanda Encerrada', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
              content: const Text('Sua comanda foi encerrada com sucesso!', style: TextStyle(fontSize: 16),),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.offAllNamed('/listMesas'),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      }else{
        Get.back();
        loadingEncerrarComanda.value = false;
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape:  const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Aviso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
              content: const Text('Erro ao tentar encerrar a comanda, tente novamente!!', style: TextStyle(fontSize: 16),),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.back(),
                  child: const Text('OK'),
                )
              ],
            );
          },
        );
      }
    });
  }
}
