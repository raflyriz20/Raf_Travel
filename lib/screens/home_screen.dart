import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_travel_ui/screens/maps_screen.dart';
// import 'package:flutter_travel_ui/screens/profil_screen.dart';
import 'package:flutter_travel_ui/widgets/destination_carousel.dart';
import 'package:flutter_travel_ui/widgets/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  ScrollController _scrollController = ScrollController();
  // int _currentTab = 0;

  List<IconData> _icons = [
    FontAwesomeIcons.umbrellaBeach,
    FontAwesomeIcons.hotel,
    FontAwesomeIcons.mapMarkedAlt,
    Icons.chat,
  ];
  List<String> name_icons = ['wisata', 'hotel', 'lokasi', 'chat'];

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  void _launchWhatsapp() async {
    String number = '+6289667296633';
    String message = 'Halo RAF TRAVEL... :D';
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Gagal Membuka Whatsapp");
  }

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (_selectedIndex == 0) {
          if (_scrollController.hasClients) {
            final position = _scrollController.position.minScrollExtent;
            _scrollController.animateTo(
              position,
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        }
        if (_selectedIndex == 1) {
          if (_scrollController.hasClients) {
            final position = _scrollController.position.maxScrollExtent;
            _scrollController.animateTo(
              position,
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        }
        if (_selectedIndex == 2) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MapsScreen()));
        }
        if (_selectedIndex == 3) {
          _launchWhatsapp();
        }
      },
      child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Color(0xFFE7EBEE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _icons[index],
                  size: 20.0,
                  color: _selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Color(0xFFB4C1C4),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(name_icons[index])
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F5F7),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'SELAMAT DATANG',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.cyan),
                    ),
                    Text(
                      'DI RAF TRAVEL',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.cyan),
                    ),
                  ],
                )),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            DestinationCarousel(),
            SizedBox(height: 20),
            HotelCarousel(),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Color(0xFF3EBACE),
      //   currentIndex: _currentTab,
      //   onTap: (int _currentIndex) {
      //     setState(() {
      //       if (_currentIndex == 1) {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => HomeScreen()));
      //       } else if (_currentIndex == 2) {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => HomeScreen()));
      //       } else if (_currentIndex == 3) {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => ProfileScreen()));
      //       }
      //     });
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         FontAwesomeIcons.search,
      //         size: 25.0,
      //       ),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         FontAwesomeIcons.fileAlt,
      //         size: 25.0,
      //       ),
      //       label: 'Booking',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         FontAwesomeIcons.userAlt,
      //         size: 25.0,
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
