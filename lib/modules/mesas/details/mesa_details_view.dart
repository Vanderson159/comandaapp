import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesaDetails{

  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_sharp,
          ),
          title: Text('Numero da mesa'), //TODO: Mostrar numero da mesa
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color:  Color(0xffaaaaaa),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pedidos'),
                        Icon(Icons.menu_book), //TODO: Alterar para o ícone do app
                        //TODO: Puxar as informações da mesa selecionada
                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.black,
                      ),
                    ),
                    onPressed: (){},
                    child: Text('Encerrar Pedido'),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Colors.black,
                        ),
                    ),
                    onPressed: (){},
                    child: Text('Encerrar Comanda'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}