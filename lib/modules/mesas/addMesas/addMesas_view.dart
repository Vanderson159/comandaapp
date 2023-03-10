
import 'package:comandaapp/modules/mesas/addMesas/addMesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AddMesasView extends GetView<AddMesasController>{
  @override
  Widget build(BuildContext context) {
    controller.contMesa = 0;
    controller.contadorController.text = controller.contMesa.toString();
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: const Text('Mesas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
      content: SizedBox(
        height: 110,
        child: Column(
          children: [
            Text(controller.labelDialog),
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
                        onChanged: (value) {
                          controller.contMesa = int.parse(value);
                          controller.contadorController.text =
                              controller.contMesa.toString();

                        },
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
                    controller.inserirMesas(controller.contMesa, 1);
                  } else {
                    Get.offAllNamed('/listMesas');
                  }
                }
              },
              child: Text(controller.acaoBtnLabel),
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
    );
  }
}