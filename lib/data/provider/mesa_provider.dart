import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:comandaapp/data/base_url.dart';

class MesaApiClient{
  final http.Client httpClient = http.Client();
  final box = GetStorage('guardaapp');
  Future insertMesas(List<MesaModel> mesas, int idEstabelecimento, String accesstoken) async{
    String token = '';
    if (accesstoken.isNotEmpty) {
      token = accesstoken;
    }

    try{
      var response = await http.post(Uri.parse('${baseUrlMesa}'), headers: {
        "Authorization": 'Bearer ' + token
      }, body: {
         "estabelecimento_id" : idEstabelecimento.toString(),
         "listMesa": MesaModel.listToJson(mesas).toString(),
         "numeroMesas": mesas.length.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    }catch (err) {
      return 0;
    }

  }
}