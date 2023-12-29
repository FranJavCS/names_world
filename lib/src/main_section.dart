import 'package:flutter/material.dart';
import 'package:NameFinder/src/names_feature/names_favs_view.dart';
import 'package:NameFinder/src/services/name_services.dart';
import 'components/home/nav_bar.dart';
import 'models/name.dart';
import 'names_feature/names_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  List<Name> listNames = [];

  List<Name> allListNames = [];

  List<Name> favoriteNames = [];

  // Fetch content from the json file
  Future<void> _getNames() async {
   NameServices namesService =  NameServices();
    List<Name> namesTmp = await namesService.getAllNames();
    setState(() {
      allListNames = namesTmp;
      listNames = allListNames;
    });
  }

  //Set<Name>  _favList = {};
  List<String> _favList = <String>[];

  void _handleFavsChange(Name name, bool inFav) {
    setState(() {
      if (!inFav) {
        _favList.add(name.id.toString());
      } else {
        _favList.remove(name.id.toString());
      }
    });

    _saveFavs();
  }

  void _clearFavs() {
    setState(() {
      _favList.clear();
    });

    _saveFavs();
  }

  Future<void> _loadFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _favList = prefs.getStringList('favList') ?? [];
    });
  }

  Future<void> _saveFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('favList', _favList);
  }

  void _handleGenderFilter(gender) {
    developer.log(gender);
    if (gender != '') {
      setState(() {
        listNames =
            allListNames.where((name) => name.gender == gender).toList();
      });
    } else {
      setState(() {
        listNames = allListNames;
      });
    }
  }

  @override
  // ignore: must_call_super
  initState() {
    // ignore: avoid_print
    _getNames();
    _loadFavs();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: listNames.isNotEmpty
            ? Scaffold(
                bottomNavigationBar: const NavBar(),
                body: <Widget>[
                  NamesListView(
                      futureNames: listNames,
                      favList: _favList,
                      handleFavsChange: _handleFavsChange,
                      onFilterGender: _handleGenderFilter),
                  NamesFavsView(
                      futureNames: listNames,
                      favList: _favList,
                      handleFavsChange: _handleFavsChange,
                      handleClearFavs: _clearFavs),
                  SettingsView(controller: widget.settingsController),
                ][currentPageIndex],
              )
            : const CircularProgressIndicator());
  }
}
