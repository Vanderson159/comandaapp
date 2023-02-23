import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/data/provider/mesa_provider.dart';
import 'package:comandaapp/modules/initial/initial_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListMesaController extends GetxController{

  final box = GetStorage('comandaapp');
  RxBool checkBoxes = false.obs;

  MesaApiClient mesaApiClient = MesaApiClient();
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
}