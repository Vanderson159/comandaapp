import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

  //para acessar o token salvo no storage
  ListMesaController listMesaController = ListMesaController();
  MesaApiClient mesaApiClient = MesaApiClient();
  final listaMesas = <MesaModel>[].obs;
  bool tagMarcados = false;
  RxBool loadingDelete = false.obs;

  @override
  void onInit(){
    gerarLista();
    super.onInit();
  }

  gerarLista(){
    for(int i = 0; i < mesalist.length; i++){
      final mesa = MesaModel(mesalist[i].id, mesalist[i].numero, mesalist[i].estabelecimento_id, mesalist[i].disponivel, false.obs);
      listaMesas.add(mesa);
    }
  }

  selectAll(){
    if(tagMarcados == false){
      for(int i = 0; i < listaMesas.length; i++){
        final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, true.obs);
        listaMesas[i] = mesa;
      }
      tagMarcados = true;
    }
    else{
      if(tagMarcados = true){
        for(int i = 0; i < listaMesas.length; i++){
          final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, false.obs);
          listaMesas[i] = mesa;
        }
        tagMarcados = false;
      }
    }
  }

  // selectCheckBox(int id){
  //   for(int i = 0; i < listaMesas.length; i++){
  //     if(listaMesas[i].id == id){
  //       var checkBox = listaMesas[i].isCheck;
  //       if(checkBox == true.obs){
  //         checkBox == false.obs;
  //       }else{
  //         if(checkBox == false.obs){
  //           checkBox == true.obs;
  //         }
  //       }
  //       final mesa = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, checkBox);
  //       listaMesas[i] = mesa;
  //     }
  //   }
  // }

  rXListToList(){
    List<MesaModel> listMesa = [];
    for(int i = 0; i < listaMesas.length; i++){
      var mesaModel = MesaModel(listaMesas[i].id, listaMesas[i].numero, listaMesas[i].estabelecimento_id, listaMesas[i].disponivel, listaMesas[i].isCheck);
      if(mesaModel.isCheck == true){
        listMesa.add(mesaModel);
      }
    }
    return listMesa;
  }

  deletarMesas(){
    loadingDelete.value = true;
    mesaApiClient.deletarMesas(rXListToList(), listMesaController.tokenAccess()).then((value) => {
      if(value == 1){
        loadingDelete.value = false,
        print('DELETADO COM SUCESSO'),
        Get.offAllNamed('/listMesas'),
      }else{
        if(value == 0){
          loadingDelete.value = false,
          print('ERRO AO DELETAR')
        }
      }
    });
  }
}