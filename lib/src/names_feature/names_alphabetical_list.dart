import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import '../models/name.dart';
import 'name_list_item.dart';

typedef FavoriteChangedCallback = Function(Name name, bool inFav);

class NamesAlphabeticalList extends StatelessWidget {
  const NamesAlphabeticalList({ Key? key,  required this.futureNames, required this.onFavChange, required this.favList }): super(key: key);

  final List<Name> futureNames; 

  final  List<String> favList;

  final FavoriteChangedCallback onFavChange;


    @override
  Widget build(BuildContext context) {
    return AzListView(data: futureNames, itemCount: futureNames.length, itemBuilder: (context,index){
      final name = futureNames[index];
      return NameListItem(
                        name: name,
                        inFav: favList.contains(name.id.toString()),
                        onFavChange: onFavChange,
                      );
    });
  }

}
