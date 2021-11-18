import 'package:coachtennis/coach/listofclubscreen/listofclubscreen.dart';
import 'package:coachtennis/coach/listofplayerscreen/listofplayerscreen.dart';
import 'package:coachtennis/coach/paiementscreen/paiementscreen.dart';
import 'package:coachtennis/coach/signup/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'homescreendetails.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOption = <Widget>[
    HomeScreenDetails(),
    ListOfClubScreen(),
    ListOfPlayerScreen(),
    PaiementScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coach Tennis"),
        actions: [
          IconButton(
            icon: const Icon(FontAwesome.address_book),
            onPressed: () {
              context.read<AuthService>().signOut();
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Feather.home,
              color: Colors.red,
            ),
            label: "Home",
            activeIcon: Icon(
              Feather.home,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.list,
              color: Colors.red,
            ),
            label: "Players",
            activeIcon: Icon(
              Feather.list,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.settings,
              color: Colors.red,
            ),
            label: "Settings",
            activeIcon: Icon(
              Feather.settings,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Feather.dollar_sign,
              color: Colors.red,
            ),
            label: "Paiement",
            activeIcon: Icon(
              Feather.dollar_sign,
              color: Colors.green,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOption.elementAt(_selectedIndex),
    );
  }
}
