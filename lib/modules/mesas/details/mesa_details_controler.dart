import 'package:comandaapp/data/model/item_model.dart';
import 'package:comandaapp/data/provider/comanda_provider.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

var listItens = <ItemModel>[]
    .obs; //LISTA QUE ARMAZENA OS ITENS ADICIONADOS ENTAO TEM QUE DELETAR ELA NA HORA DE ENVIAR ELES PQ SE NAO VAI ACONTECER O MESMO BUG DO ADICIONAR

class MesaDetailsController extends GetxController {
  ComandaApiClient comandaApiClient = ComandaApiClient();
  ListMesaController listMesaController = ListMesaController();
  TextEditingController itemPedido = TextEditingController();
  final formKeyDetail =
      GlobalKey<FormState>(); //formkey do formulario de mesa detail
  RxBool attWidget = false.obs;
  RxBool loadingEncerrarPedido = false.obs;
  RxBool loadingEncerrarComanda = false.obs;

  void getItensComanda(int idMesa) {
    comandaApiClient.getItensComanda(listMesaController.tokenAccess(), idMesa);
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
              shape:  RoundedRectangleBorder(
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
                  child: Text('OK'),
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
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Erro ao encerrar pedido :(', style: TextStyle(fontWeight: FontWeight.bold),),
              content: const Text('Ocorreu algum problema ao tentar encerrar seu pedido, seus itens não foram salvos. Por favor tente novamente!'),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.back(),
                  child: Text('OK'),
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
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Comanda Encerrada', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
              content: const Text('Sua comanda foi encerrada com sucesso!', style: TextStyle(fontSize: 16),),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.offAllNamed('/listMesas'),
                  child: Text('OK'),
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
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Aviso', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
              content: const Text('Erro ao tentar encerrar a comanda, tente novamente!!', style: TextStyle(fontSize: 16),),
              actions: [
                ElevatedButton(
                  onPressed: ()=> Get.back(),
                  child: Text('OK'),
                )
              ],
            );
          },
        );
      }
    });
  }
}
