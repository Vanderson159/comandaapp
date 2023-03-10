import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/modules/mesas/listMesas_controller.dart';
import 'package:get/get.dart';

class DeleteMesasController extends GetxController{

  ListMesaController listMesaController = ListMesaController();//para acessar o token salvo no storage
  MesaApiClient mesaApiClient = MesaApiClient();
  final listaMesas = <MesaModel>[].obs;
  bool tagMarcados = false;
  RxBool loadingDelete = false.obs;

  @override
  void onInit(){
    gerarLista();
    super.onInit();
  }

  gerarLista(){ //Percorre a primeira lista de mesas e adiciona os itens na nova lista observável
    listMesaController.buscarMesas();
    for(int i = 0; i < mesasDisponiveis.length; i++){
      final mesa = MesaModel(mesasDisponiveis[i].id, mesasDisponiveis[i].numero, mesasDisponiveis[i].estabelecimento_id, mesasDisponiveis[i].disponivel, false.obs);
      listaMesas.add(mesa);
    }
    mesasDisponiveis.clear();// limpar essa list senao duplica quando for chamada dnv
  }

  selectAll(){ //Atualiza a lista obs para marcar ou desmarcar todos os checkbox
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
        Get.offAllNamed('/listMesas'),
        mesasDisponiveis.clear(), // limpar essa list senao duplica quando for chamada dnv
      }
      else{
        if(value == 0){
          loadingDelete.value = false,
          print('ERRO AO DELETAR')
        }
      }
    });
  }
}