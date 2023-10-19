import 'package:flutter/material.dart';
import 'package:names_world/src/names_feature/names_favs_view.dart';
import 'dart:convert';
import 'names_feature/name.dart';
import 'names_feature/names_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MainSection extends StatefulWidget {
  const MainSection({
    Key? key,
    required this.settingsController,
  }) : super(key: key);
  static const routeName = '/';
  final SettingsController settingsController;

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  late Future<List<Name>> futureNames;


 List<Name> favoriteNames = [];

  // Fetch content from the json file
  Future<List<Name>> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/data.json');
    final data = await json.decode(response)['items'] as List;
    developer.log('Consultando data', name: 'my.app.category');
    developer.log(jsonEncode(data), name: 'my.app.category');
    return data.map((nameJson) => Name.fromJson(nameJson)).toList();
  }

  //Set<Name>  _favList = {};
  List<String> _favList = <String>[];

  void _handleFavsChange(Name name, bool inFav) {
    setState(() {
      // When a user changes what's in the cart, you need
      // to change _shoppingCart inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      if (!inFav) {
        _favList.add(name.id.toString());
      } else {
        _favList.remove(name.id.toString());
      }
    });

    _saveFavs();
  }

  Future<void> _loadFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //var lstFavs = prefs.getStringList('favList');

    setState(() {
      _favList = prefs.getStringList('favList') ?? [];
     
    });
  }

  Future<void> _saveFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('favList', _favList);
  }

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    futureNames = readJson();
    _loadFavs();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Name>>(
      future: futureNames,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              indicatorColor: Colors.amber[800],
              selectedIndex: currentPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.star),
                  label: 'Favoritos',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.school),
                  icon: Icon(Icons.settings),
                  label: 'Configuraciones',
                ),
              ],
            ),
            body: <Widget>[
              NamesListView(futureNames: snapshot.data, favList: _favList, handleFavsChange: _handleFavsChange),
               NamesFavsView(futureNames: snapshot.data, favList: _favList, handleFavsChange: _handleFavsChange),
              SettingsView(controller: widget.settingsController),
            ][currentPageIndex],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
