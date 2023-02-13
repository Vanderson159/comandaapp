import 'package:flutter/material.dart';

class MesaDetails extends StatelessWidget {
  const MesaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
          title: const Text(
            'Mesa 33', //TODO: Mostrar numero da mesa
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:  const Color(0xffebebeb),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Pedidos',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/iconePedidos.png',
                              ),
                              //TODO: Alterar para o ícone do app
                              //TODO: Puxar as informações da mesa selecionada
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                          ),
                          onPressed: (){}, //TODO: Adicionar função
                          child: const Text('Encerrar Pedido'),
                        ),
                      ),

                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)))
                          ),
                          onPressed: (){}, //TODO: Adicionar função
                          child: const Text('Encerrar Comanda'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}