import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({ Key? key, required this.changeScreen, required this.currentPageIndex }) : super(key: key);

  final void Function(int) changeScreen;
  final int currentPageIndex;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
                  onDestinationSelected: widget.changeScreen,
                  indicatorColor: Theme.of(context).primaryColor,
                  selectedIndex: widget.currentPageIndex,
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