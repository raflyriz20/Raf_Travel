import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/screens/home_screen.dart';
import 'package:flutter_travel_ui/screens/profil_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class navbar extends StatefulWidget {
  @override
  _navbarState createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  // Tiga layar
  final List<Widget> _screens = [HomeScreen(), HomeScreen(), ProfileScreen()];

  int _activeScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeScreenIndex,
        selectedItemColor: Color(0xFF3EBACE),
        onTap: (index) {
          setState(() {
            _activeScreenIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          // Tiga item navigasi
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 25.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.fileAlt,
              size: 25.0,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.userAlt,
              size: 25.0,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
