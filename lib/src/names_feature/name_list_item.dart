import 'package:flutter/material.dart';

import 'name.dart';


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

    return !inFav //
        ? Theme.of(context).disabledColor
        : Colors.redAccent;
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
            size: 24.0));
  }
}