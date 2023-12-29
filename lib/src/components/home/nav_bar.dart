import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentPageIndex = index;
                    });
                  },
                  indicatorColor: Theme.of(context).primaryColor,
                  selectedIndex: currentPageIndex,
                  destinations: const <Widget>[
                    NavigationDestination(
                      selectedIcon: Icon(Icons.home),
                      icon: Icon(Icons.home_outlined),
                      label: 'Inicio',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.star),
                      icon: Icon(Icons.star_outline),
                      label: 'Favoritos',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.search),
                      icon: Icon(Icons.search_outlined),
                      label: 'Busqueda',
                    ),
                    NavigationDestination(
                      selectedIcon: Icon(Icons.settings),
                      icon: Icon(Icons.settings_outlined),
                      label: 'Configuraciones',
                    ),
                  ],
                );
  }
}