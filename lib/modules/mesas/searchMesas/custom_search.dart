import 'package:comandaapp/data/model/mesa_model.dart';
import 'package:comandaapp/modules/mesas/listMesas_view.dart';
import 'package:flutter/material.dart';

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
    List<MesaModel> matchQuery = cacheList
        .where(
          (element) =>
          element.toString().toLowerCase().contains((query.toLowerCase())),
    )
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index){
        var result = matchQuery[index];
        return MesaItem(mesaModel: result, isVisibleCheckBox: false,);
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
        return MesaItem(mesaModel: result, isVisibleCheckBox: false,);
      },
    );
  }
}
