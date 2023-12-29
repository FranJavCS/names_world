import 'package:flutter/material.dart';

import '../models/name.dart';


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
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[Text(name.meaning)],
                  ),
                )),
              );
            },
          );
        },
        leading: CircleAvatar(
          radius: 25.0,
          backgroundImage: Image.asset( name.gender == 'M' ?  "assets/images/baby_avatar/nino_1.jpg": "assets/images/baby_avatar/nina_1.jpg").image,
          backgroundColor: Colors.transparent,
        ),
        title: Text(name.name),
        trailing: IconButton(
            icon: const Icon(Icons.favorite, size: 24.0),
            color: _getColor(context),
            onPressed: () {
              onFavChange(name, inFav);
            }));
  }
}
