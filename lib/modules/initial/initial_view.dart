import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'initial_controller.dart';

class InitialView extends GetView<InitialController> {
  const InitialView({super.key});
  @override
  Widget build(BuildContext context) {
    appBar(String nomeEstabelecimento) {
      return AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Text(
                nomeEstabelecimento,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
            ),
          ],
        ),
        bottom: const TabBar(
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          isScrollable: false,
          tabs: [
            Tab(
              text: 'Ocupadas',
            ),
            Tab(
              text: 'Disponíveis',
            ),
          ],
        ),
      );
    }

    controller.contadorController.text = controller.contMesa.toString();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GetBuilder<InitialController>(
        init: InitialController(),
        builder: (_) {
          return Scaffold(
            appBar: appBar(
                _.nomeEstabelecimento()), //definindo nome do estabelecimento
            body: Stack(
              children: [
                TabBarView(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline,
                            size: 150,
                          ),
                          Text(
                            'Atenção',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            'Não há mesa ocupada',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: Text("hahaahahah"),
                    )
                  ],
                ),

                Opacity(
                  opacity: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                  ),
                ),

                //Definindo a janela de definição de mesas
                AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  title: const Text('Mesas'),
                  content: SizedBox(
                    height: 110,
                    child: Column(
                      children: [
                        Text(_.labelDialog),
                        Obx(
                          () => Visibility(
                            visible: controller.showAdicionarMesa.value,
                            child: Row(
                              children: [
                                const Text('Qtd mesas: '),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.decrementar();
                                    controller.contadorController.text =
                                        controller.contMesa.toString();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(35, 35),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                  child: const Text(
                                    '-',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                    ], //Definindo a quantidade de caracteres
                                    textAlign: TextAlign.center,
                                    controller: controller.contadorController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.incrementar();
                                    controller.contadorController.text =
                                        controller.contMesa.toString();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                      const Size(35, 35),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Obx(
                      () => Visibility(
                        visible: !controller.loadingSend.value,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (controller.contMesa < 1) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (contextDialog) {
                                    return AlertDialog(
                                      title: const Center(
                                        child: Text('AVISO'),
                                      ),
                                      content: const Text(
                                          'Selecione uma quantidade de mesas superior a 0'),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              if (controller.enabledFuncBtn.value) {
                                controller.inserirMesas(controller.contMesa);
                              } else {
                                Get.offAllNamed('/listMesas');
                              }
                            }
                          },
                          child: Text(_.acaoBtnLabel),
                        ),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.loadingSend.value,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: Get.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 40,
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
