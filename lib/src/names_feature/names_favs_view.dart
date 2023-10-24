import 'package:flutter/material.dart';
import 'package:names_world/src/names_feature/names_list.dart';

import 'name.dart';

class NamesFavsView extends StatefulWidget {
  const NamesFavsView({Key? key, required this.futureNames, required this.handleFavsChange, required this.favList, required this.handleClearFavs}) : super(key: key);

  final List<Name>? futureNames;
  final List<String> favList;
  final handleFavsChange;
  final handleClearFavs;
  static const routeName = '/';

  @override
  State<NamesFavsView> createState() => _NamesFavsView();
}

class _NamesFavsView extends State<NamesFavsView> {

  List<Name>? favsNames = [];


  List<Name>? getFavNames()  {

    List<Name>? favNames = widget.futureNames?.where((element) => widget.favList.contains(element.id.toString()) ).toList();

    return favNames;
  }

    clearFavs()  {
    widget.handleClearFavs();
    setState(() {
    favsNames?.clear();
    });
  }


  updateFavs(name, isFav){

    widget.handleFavsChange(name,isFav);

    setState(() {
    favsNames?.remove(name);
    });

  }



  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    favsNames = getFavNames();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Nombres',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: clearFavs,
            ),
          ],
        ),
        body: Center(
          child: NamesList(futureNames: favsNames,  onFavChange: updateFavs, favList: widget.favList)
        ));
  }
}
