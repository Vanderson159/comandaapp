import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          icon: Icon(Icons.clear))
    ];
  }

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
        var result = matchQuery[index];
        if(result.disponivel == true){
          return MesaItem(mesaModel: result, isVisibleCheckBox: false, abrirComandaFunc: true,);
        }else{
          return MesaItem(mesaModel: result, isVisibleCheckBox: false, toComanda: true,);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
        if(result.disponivel == true){
          return MesaItem(mesaModel: result, isVisibleCheckBox: false, abrirComandaFunc: true,);
        }else{
          return MesaItem(mesaModel: result, isVisibleCheckBox: false, toComanda: true,);
        }
      },
    );
  }
}
