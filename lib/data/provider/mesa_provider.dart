import 'package:http/http.dart' as http;
import 'package:comandaapp/data/base_url.dart';

class MesaApiClient{
  final http.Client httpClient = http.Client();
  
  Future insertMesas(String accessToken) async{
    String token = '';
    if (accessToken.isNotEmpty) {
      token = accessToken;
    }
    /*
    try{
      var response = await http.post(Uri.parse('${baseUrlMesa}'), headers: {
        "Authorization": 'Bearer ' + token
      }, body: {
         "numero":
      });
    }
    */

  }
}