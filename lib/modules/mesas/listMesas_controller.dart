import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/comanda_provider.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/modules/initial/initial_controller.dart';
import 'package:comandaapp/modules/mesas/deleteMesas/deleteMesas_controller.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListMesaController extends GetxController{

  final box = GetStorage('comandaapp');
  RxBool checkBoxes = false.obs;
  RxBool loadingComanda = false.obs;

  MesaApiClient mesaApiClient = MesaApiClient();
  ComandaApiClient comandaApiClient = ComandaApiClient();
  InitialController initialController = InitialController();
  DeleteMesasController deleteMesasController = DeleteMesasController();
  List<MesaModel> listMesaModel = [];

  void setListMesa(List<MesaModel> listMesa){
    listMesaModel = listMesa;
    box.write('cacheListMesa', listMesaModel);
  }

  String tokenAccess(){
    AuthModel auth = box.read('auth');
    String accesstoken = auth.accessToken.toString();
    return accesstoken;
  }

  buscarMesas(){
    return  mesaApiClient.listarMesas(tokenAccess(), 0);
  }

  buscarMesasOcupadas(){
    return  mesaApiClient.listarMesas(tokenAccess(), 1);
  }

  abrirComanda(MesaModel mesaModel) async{
    loadingComanda.value = true;
    comandaApiClient.abrirComanda(mesaModel, tokenAccess()).then((value){
      if(value == 1){
        mesaApiClient.indisponibilizar(tokenAccess(), mesaModel).then((value){
          if(value == 1){
            loadingComanda.value = true;
            Get.to(MesaDetails(
              mesaModel: mesaModel,
            ),);
          }
        });
      }
    });
  }
}