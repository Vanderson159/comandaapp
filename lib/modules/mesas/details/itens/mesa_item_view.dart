import 'package:comandaapp/modules/mesas/details/itens/mesa_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ListMesaItem extends GetView<MesaItemController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ListTile(
          textColor: Colors.white,
          title: Text('Item 1 Pedido'),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.white
                  ),
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 20,
                child: Text('1', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 70,
                height: 25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print('MENOS');
                      },
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.remove, size: 20, color: Colors.black,),
                      ),
                    ),
                    Text('|'),
                    GestureDetector(
                      onTap: (){
                        print('MAIS');
                      },
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.add, size: 20, color: Colors.black,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}