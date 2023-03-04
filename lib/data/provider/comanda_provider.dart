import 'package:comandaapp/data/base_url.dart';
import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ComandaApiClient{
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp');

  Future abrirComanda(MesaModel mesaModel, String accesstoken, var dateTime) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse(baseUrlComanda), headers: {
        "Authorization": 'Bearer $token'
      }, body: {
        "itens" : "",
        "inicio_comanda": dateTime.toString(),
        "fim_comanda": "",
        "mesa_idmesas": mesaModel.id.toString(),
        "mesa_estabelecimento_id": mesaModel.estabelecimento_id.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch(err){
      return 0;
    }
  }
}