import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_design/Cinema%20App%20UI/consts.dart';
import 'home_page_cinema.dart';
import 'profile_page.dart'; // Import trang Profile
import 'compass_page.dart'; // Import Compass page

class CinemaMainScreen extends StatefulWidget {
  const CinemaMainScreen({super.key});

  @override
  State<CinemaMainScreen> createState() => _CinemaMainScreenState();
}

class _CinemaMainScreenState extends State<CinemaMainScreen> {
  int currentIndex = 0;
  late final List<Widget> page;

  @override
  void initState() {
    page = [
      const HomePageCinema(),
       CompassPage(), // Update with CompassPage
      navBarPage(CupertinoIcons.ticket_fill),
      const ProfilePage(), // Thay đổi trang Profile
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.compass_fill),
            label: 'Compass',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ticket_fill),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  static Widget navBarPage(IconData iconName) {
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
