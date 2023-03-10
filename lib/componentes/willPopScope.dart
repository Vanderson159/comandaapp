import 'package:comandaapp/modules/mesas/details/mesa_details_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WillPopScopeView extends StatefulWidget {


  Widget? view;
  int? tipo;

  WillPopScopeView(this.view, this.tipo);

  @override
  State<WillPopScopeView> createState() => _WillPopScopeViewState(view!, tipo!);
}


class _WillPopScopeViewState extends State<WillPopScopeView> {
  bool saved = false;
  Widget view;
  int? tipo;
  _WillPopScopeViewState(this.view, this.tipo);


  Future<bool?> showConfirmationDialog() {

      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              title: const Text('Atenção!'),
              content: const Text(
                  //'Ao sair sem encerrar os pedidos todas as alterações serão perdidas. Tem certeza que deseja sair?'
                'Deseja sair sem salvar as alterações no pedido?'
            ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    listItens
                        .clear(); // limpa a lista para nao duplicar os itens quando acessar a mesa novamente
                    Get.offAllNamed('/listMesas');
                  },
                  child: const Text('SIM'),
                ), //sim
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: const Text('NÃO'),
                ), //sim

              ],
            );
          });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: view,
      onWillPop: () async {
        if (!saved) {
          final confirmation = await showConfirmationDialog();
          return confirmation ?? false;
        }
        return true;
      },
    );
  }
}
