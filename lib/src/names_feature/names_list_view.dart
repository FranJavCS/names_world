import 'package:NameFinder/src/names_feature/names_alphabetical_list.dart';
import 'package:flutter/material.dart';
import 'package:NameFinder/src/names_feature/names_list.dart';
import '../models/name.dart';
import 'components/search_bar.dart';


class NamesListView extends StatefulWidget {
  const NamesListView({Key? key, required this.futureNames, required this.handleFavsChange, required this.favList, this.onFilterGender}) : super(key: key);

  final List<Name> futureNames;
  final List<String> favList;
  final handleFavsChange;
  final onFilterGender;

  static const routeName = '/';

  @override
  State<NamesListView> createState() => _NamesListViewState();
}

class _NamesListViewState extends State<NamesListView> {

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:   AppBar(
          centerTitle: true,
          title: const Text(
            'Nombres',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.male, color: Colors.blue),
              onPressed: () {
                widget.onFilterGender('M');
              },
            ),
            IconButton(
              icon: const Icon(Icons.female,color: Colors.pink),
              onPressed: () {
                widget.onFilterGender('F');
              },
            ),
            TextButton(onPressed: () {widget.onFilterGender(''); }, child: const Text('Todos', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Center(
          child: NamesAlphabeticalList(futureNames: widget.futureNames,  onFavChange: widget.handleFavsChange, favList: widget.favList)
        ));
  }
}
