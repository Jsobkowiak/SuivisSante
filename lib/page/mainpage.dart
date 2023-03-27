import 'package:flutter/material.dart';
import 'package:flutter_suivis_sante/api/api.dart';
import 'package:flutter_suivis_sante/api/local.dart';
import 'package:flutter_suivis_sante/page/graph.dart';
import 'package:flutter_suivis_sante/page/profil.dart';
import 'package:graphic/graphic.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;
  var data = [
    {'category': 'Shirts', 'sales': 5},
    {'category': 'Cardigans', 'sales': 20},
    {'category': 'Chiffons', 'sales': 36},
    {'category': 'Pants', 'sales': 10},
    {'category': 'Heels', 'sales': 10},
    {'category': 'Socks', 'sales': 20},
  ];


  static const List<Widget> _widgetOptions = <Widget>[
    Graph(),
    Profil(),
  ];

  @override
  void initState() {
    super.initState();
    if (Local.Token.isEmpty) {
      //Navigator.pushNamed(context, "/login");
    }
    Api.GetMusureByUserID();
  }

  FloatingActionButton floatProfil = FloatingActionButton(onPressed: (){}, backgroundColor: Colors.transparent);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        floatProfil = FloatingActionButton(foregroundColor: Colors.transparent,onPressed: (){}, backgroundColor: Colors.transparent);

      } else if (_selectedIndex == 1) {
         floatProfil = FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.pushNamed(context, "/editprofil");
            });
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.edit),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profil"),
        ],
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
