import 'package:flutter/material.dart';
import 'package:names_world/src/names_feature/names_list.dart';
import '../settings/settings_view.dart';

import 'name.dart';

class NamesFavsView extends StatefulWidget {
  const NamesFavsView({Key? key, required this.futureNames, required this.handleFavsChange, required this.favList}) : super(key: key);

  final List<Name>? futureNames;
  final List<String> favList;
  final handleFavsChange;

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
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Center(
          child: NamesList(futureNames: favsNames,  onFavChange: updateFavs, favList: widget.favList)
        ));
  }
}
