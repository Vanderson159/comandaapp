import 'package:comandaapp/data/model/user_model.dart';
import 'package:comandaapp/data/provider/user_provider.dart';

class UserRepository{
  final UserApiClient userApiClient = UserApiClient();
  Future<UserModel> showUser(int userId, String accessToken) async{
    var responseUserShow = await userApiClient.showUser(userId, accessToken);
    return UserModel.fromJson(responseUserShow);
  }
}