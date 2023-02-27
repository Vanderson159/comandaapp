import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/comanda_provider.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/modules/initial/initial_controller.dart';
import 'package:comandaapp/modules/mesas/details/mesa_details_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListMesaController extends GetxController{

  final box = GetStorage('comandaapp');
  RxBool checkBoxes = false.obs;

  MesaApiClient mesaApiClient = MesaApiClient();
  ComandaApiClient comandaApiClient = ComandaApiClient();
  InitialController initialController = InitialController();
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
    return  mesaApiClient.listarMesas(tokenAccess());
  }

  abrirComanda(MesaModel mesaModel){
    comandaApiClient.abrirComanda(mesaModel, tokenAccess()).then((value){
      if(value == 1){
        mesaApiClient.indisponibilizar(tokenAccess(), mesaModel).then((value){
          if(value == 1){
            Get.to(MesaDetails(
              mesaModel: mesaModel,
            ),);
          }
        });
      }
    });
  }
}