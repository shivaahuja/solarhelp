// ignore_for_file: must_be_immutable

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:solarhelp/src/screens/companies_page.dart';
import 'package:solarhelp/src/screens/donation_page.dart';
import 'package:solarhelp/src/screens/home_page.dart';

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
  CurvedNavigationBar _buildBottomNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.grey.shade200,
      color: Colors.green.shade300,
      index: _currentIndex,
      animationDuration: const Duration(milliseconds: 200),
      onTap: _onTapped,
      height: 60,
      items: const [
        Icon(Icons.home),
        Icon(Icons.list),
        Icon(Icons.attach_money)
      ],
    );
    // return BottomNavigationBar(
    //   type: BottomNavigationBarType.fixed,
    //   currentIndex: _currentIndex,
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: 'Home',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.list,
    //       ),
    //       label: 'List',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.attach_money,
    //       ),
    //       label: 'Donation',
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(
    //         Icons.book,
    //       ),
    //       label: 'Learn Flutter',
    //     ),
    //   ],
    //   onTap: _onTapped,
    //   selectedItemColor: Colors.black,
    //   unselectedItemColor: Colors.grey[600],
    //   backgroundColor: Colors.white,
    // );
  }
}
