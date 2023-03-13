import 'package:comandaapp/modules/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
                        image: AssetImage('imagens/ecomanda.png'),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('Username', textAlign: TextAlign.start),
                  ),
                  TextFormField(
                    onChanged: (value){
                      if(controller.avisoBtnUsername.value){
                        controller.liberaBotao(controller.formKey.currentState!.validate());
                      }
                    },
                    validator: (value) {
                      if (value!.length < 3) {
                        return 'O login deve possuir ao menos 3 caracteres';
                      }
                      return null;
                    },
                    controller: controller.usernameCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Digite seu username',
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
                        onChanged: (value) {
                            if (value.length >= 4) {
                              if (controller.usernameCtrl.text.length < 3) {
                                controller.avisoBtnUsername.value = true;
                              }
                              controller.liberaBotao(controller.formKey.currentState!.validate());
                            } else {
                              controller.liberaBotao(false);
                            }

                        },
                        validator: (value) {
                          if (value!.length < 3) {
                            return 'A senha deve possuir ao menos 4 caracteres';
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
                              controller.showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              controller.showPassword.value =
                                  !controller.showPassword.value;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Row(
                        children: [
                          SizedBox(
                            width: 35,
                            child: Checkbox(
                              value: controller.checkBox.value,
                              onChanged: (value){
                                controller.checkBox.value = value!;
                                },
                              activeColor: Colors.black,
                              checkColor: Colors.white,
                            ),
                          ),
                          const Text('Lembrar de mim'),
                        ],
                      ),
                      ),
                    ],
                  ),

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
                                        controller.isButtonActive == true
                                            ? Colors.black
                                            : Colors.grey.shade200),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.isButtonActive == true ? controller.login() : null;
                                    },
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
                                        controller.isButtonActive == true
                                            ? Colors.black
                                            : Colors.grey.shade200),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ],
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
