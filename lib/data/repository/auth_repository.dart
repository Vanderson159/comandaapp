import 'package:comandaapp/data/model/auth_model.dart';
import 'package:comandaapp/data/provider/auth_provider.dart';

class AuthRepository{
  final AuthApiClient apiClient = AuthApiClient();
  Future<AuthModel> login(String username, String password) async {
    return AuthModel.fromJson(await apiClient.login(username, password));
  }
}