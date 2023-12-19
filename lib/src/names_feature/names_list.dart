import 'package:flutter/material.dart';
import '../models/name.dart';
import 'name_list_item.dart';

typedef FavoriteChangedCallback = Function(Name name, bool inFav);

class NamesList extends StatelessWidget {
  const NamesList({ Key? key,  required this.futureNames, required this.onFavChange, required this.favList }): super(key: key);


  final List<Name>? futureNames; 

  final  List<String> favList;

  final FavoriteChangedCallback onFavChange;

  @override
  Widget build(BuildContext context) {
    return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: futureNames!.map((name) {
                      return NameListItem(
                        name: name,
                        inFav: favList.contains(name.id.toString()),
                        onFavChange: onFavChange,
                      );
                    }).toList());

  }


}

