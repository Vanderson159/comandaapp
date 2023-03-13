import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../details/mesa_details_view.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<MesaModel> cacheList;

  CustomSearchDelegate(this.cacheList);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear),
      )
    ];
  }

  //TODO: Alterar label de busca (está como Search)
  //TODO: Adicionar função de toque na mesa pesquisada

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<MesaModel> matchQuery = cacheList.where(
          (element) =>
          element.toString().toLowerCase().contains((query.toLowerCase())),
    ).toList();

    if(matchQuery.isEmpty){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.search_off_outlined,
                  size: 150,
                ),
                Text(
                  'Nenhum resultado encontrado',
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
      );
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        final MesaModel result = matchQuery[index];
        return ListTile(
          title: MesaItem(mesaModel: result, isVisibleCheckBox: false,),
          onTap: (){
            Get.to(() => MesaDetails(mesaModel: result,));
            //TODO: Esse clique só funciona fora do model e o do model n funciona kkkkk
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) { //TODO: esse não ta funcionando como deveria, mas é detalhe kkkk
    List<MesaModel> matchQuery = [];
    for(var results in matchQuery){
      if(results.toString().toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(results);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return MesaItem(mesaModel: result, isVisibleCheckBox: false,);
      },
    );
  }
}
