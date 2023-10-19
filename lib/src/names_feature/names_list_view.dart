import 'package:flutter/material.dart';
import 'package:names_world/src/names_feature/names_list.dart';
import '../settings/settings_view.dart';

import 'name.dart';

class NamesListView extends StatefulWidget {
  const NamesListView({Key? key, required this.futureNames, required this.handleFavsChange, required this.favList}) : super(key: key);

  final List<Name>? futureNames;
  final List<String> favList;
  final handleFavsChange;

  static const routeName = '/';

  @override
  State<NamesListView> createState() => _NamesListViewState();
}

class _NamesListViewState extends State<NamesListView> {



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
          child: NamesList(futureNames: widget.futureNames,  onFavChange: widget.handleFavsChange, favList: widget.favList)
        ));
  }
}
