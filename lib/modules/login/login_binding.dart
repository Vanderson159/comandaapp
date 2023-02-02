import 'package:comandaapp/data/repository/auth_repository.dart';
import 'package:comandaapp/modules/login/login_controller.dart';
import 'package:get/get.dart';

import '../../data/provider/auth_provider.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<AuthApiClient>(() => AuthApiClient());
  }
}