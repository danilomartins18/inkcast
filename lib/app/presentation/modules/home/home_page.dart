import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inkcast/app/presentation/modules/library/tabs/library_tab.dart';
import 'package:inkcast/app/presentation/modules/profile/tabs/profile_tab.dart';
import 'package:inkcast/app/shared/constants.dart';

import 'tabs/home_tab.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _tabList = [HomeTab(), LibraryTab(), ProfileTab()];

  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _tabList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: inkLightColor,
        onTap: onTappedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: Text("Início"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.microphone),
            title: Text("Biblioteca"),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: Text("Perfil"),
          ),
        ],
      ),
    );
  }
}
