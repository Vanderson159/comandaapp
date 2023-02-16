import 'package:comandaapp/modules/login/login_controller.dart';
import 'package:comandaapp/remember.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: SizedBox(
                          height: 250,
                          width: 250,
                          child: Image(
                            image: AssetImage('imagens/comanda.png'),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Email', textAlign: TextAlign.start),
                      ),
                      TextFormField(
                        validator: (value){
                          if(value!.length < 3){
                            return 'O login deve possuir mais de 3 caracteres';
                          }
                          return null;
                        },
                        controller: controller.usernameCtrl,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: 'example@gmail.com',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text('Senha', textAlign: TextAlign.start),
                      ),
                      Obx(
                            () => GestureDetector(
                          child: TextFormField(
                            onChanged: (value){
                              if(value.length > 3){
                                controller.liberaBotao(true);
                              }else{
                                controller.liberaBotao(false);
                              }
                            },
                            validator: (value){
                              if(value!.length < 3){
                                return 'A senha deve possuir mais de 4 caracteres';
                              }
                            },
                            obscureText: !controller.showPassword.value,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: controller.passwordCtrl,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Digite sua senha',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.showPassword.value? Icons.visibility : Icons.visibility_off, color: Colors.black,
                                ),
                                onPressed: () {
                                  controller.showPassword.value = !controller.showPassword.value;
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),

                      //Cria checkbox para lembrar dados e o campo de "esqueci senha"
                      const RememberData(),
                      //TODO: criar lógica de armazenamento dos dados

                      Obx(
                            () => Visibility(
                          visible: !controller.loading.value,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(
                                           controller.isButtonActive ==  true ? Colors.black : Colors.grey.shade200
                                        ),
                                        shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      onPressed: () => controller.isButtonActive == true ? controller.login() : null,
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
