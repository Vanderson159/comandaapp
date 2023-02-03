import 'package:comandaapp/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    //controller.secureScreen();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start, //Alinhamento não ta funcionando
                children: [
                  const SizedBox(
                    height: 250,
                    width: 250,
                    child: Image(
                      image: AssetImage('imagens/comanda.png'),
                    ),
                  ),

                  const Text('Email', textAlign: TextAlign.start),
                  TextField(
                    controller: controller.usernameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'example@gmail.com',
                    ),

                  ),

                  const Text('Senha', textAlign: TextAlign.start),
                  Obx(() => TextField(
                    obscureText: !controller.showPassword.value,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: controller.passwordCtrl,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Digite sua senha',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showPassword.value ? Icons.visibility : Icons.visibility_off,
                          color: Get.theme.primaryColor,
                        ),
                        onPressed: (){
                          controller.showPassword.value = !controller.showPassword.value;
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  ),

                  Obx(
                    () => Visibility(
                      visible: !controller.loading.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => controller.limpar(),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  child: Text(
                                    'LIMPAR',
                                    style:
                                        TextStyle(color: Colors.blue.shade800),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: 100,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () => controller.login(),
                                  child: const Text('LOGIN'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.loading.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: Get.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 40,
                            ),
                            child: ElevatedButton(
                              onPressed: null,
                              child: CircularProgressIndicator(
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
