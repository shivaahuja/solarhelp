// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/companies_page.dart';
import 'package:solarhelp/src/screens/donation_page.dart';
import 'package:solarhelp/src/screens/home_page.dart';
import 'package:solarhelp/src/screens/learn_flutter.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key, required this.currentIndex}) : super(key: key);
  int currentIndex = 0;
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _screens = const [
    HomePage(),
    CompaniesPage(),
    DonationPage(),
    LearnFlutter(),
  ];
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  //BottomNavigationBar
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.attach_money,
          ),
          label: 'Donation',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book,
          ),
          label: 'Learn Flutter',
        ),
      ],
      onTap: _onTapped,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey[600],
      backgroundColor: Colors.white,
    );
  }
}
