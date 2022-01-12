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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red,
            ),
            label: "Home",
            activeIcon: Icon(
              Icons.home,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box_outlined,
              color: Colors.red,
            ),
            label: "Clubs",
            activeIcon: Icon(
              Icons.account_box_outlined,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
              color: Colors.red,
            ),
            label: "Players",
            activeIcon: Icon(
              Icons.group,
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
