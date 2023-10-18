import 'dart:ffi';

import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';

class Name {
  const Name(
      {required this.id,
      required this.name,
      required this.meaning,
      required this.gender});

  final String name;
  final int id;
  final String meaning;
  final String gender;

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      id: json['id'],
      name: json['name'],
      meaning: json['meaning'],
      gender: json['gender'],
    );
  }
}

typedef FavoriteChangedCallback = Function(Name name, bool inFav);

class NameListItem extends StatelessWidget {
  NameListItem(
      {required this.name, required this.inFav, required this.onFavChange})
      : super(key: ObjectKey(name));

  final Name name;
  final bool inFav;
  final FavoriteChangedCallback onFavChange;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inFav //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  Color _getGenderColor(BuildContext context, String gender) {

    return gender == 'M' //
        ? Colors.lightBlue
        : Colors.pink;
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onFavChange(name, inFav);
        },
        leading: CircleAvatar(
          backgroundColor: _getGenderColor(context, name.gender),
          child: Text(name.gender),
        ),
        title: Text(
          name.name
        ),
        trailing: Icon(Icons.favorite,
            color: _getColor(context),
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes'));
  }
}

class NamesListView extends StatefulWidget {
  const NamesListView({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<NamesListView> createState() => _NamesListViewState();
}

class _NamesListViewState extends State<NamesListView> {
  late Future<List<Name>> futureNames;
  
  




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
          child: FutureBuilder<List<Name>>(
            future: futureNames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: snapshot.data!.map((name) {
                      return NameListItem(
                        name: name,
                        inFav: _favList.contains(name.id.toString()),
                        onFavChange: _handleFavsChange,
                      );
                    }).toList());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ));
  }
}
