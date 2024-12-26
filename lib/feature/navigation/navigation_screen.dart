import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_mobile/feature/history/history_screen.dart';
import 'package:pos_mobile/feature/home/home_screen.dart';
import 'package:pos_mobile/feature/menu/menu_screen.dart';
import 'package:pos_mobile/feature/notification/notification_screen.dart';
import 'package:pos_mobile/feature/account/account_screen.dart';

import '../ui/color.dart';
import '../ui/typography.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int _initialIndex = 0;
  List<Widget> screens =[
    HomeScreen(),
    // MenuScreen(),
    const HistoryScreen(),
    const NotificationScreen(),
    AccountScreen(),
  ];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: screens[_initialIndex], // Gunakan nilai _initialIndex untuk menampilkan layar
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 1,
      iconSize: 24,
      currentIndex: _initialIndex,
      enableFeedback: false,
      unselectedLabelStyle: xsMedium.copyWith(color: iconNeutralSecondary),
      selectedLabelStyle: xsMedium.copyWith(color: primaryColor),
      selectedItemColor: primaryColor,
      unselectedItemColor: iconNeutralSecondary,
      onTap: (e) {
        setState(() {
          _initialIndex = e;
        });
      },
      items: const [
        // BottomNavigationBarItem(
        //   label: 'Home',
        //   icon: Icon(Icons.home),
        //   activeIcon: Icon(Icons.home, color: primaryColor)
        // ),
        
        BottomNavigationBarItem(
          label: 'Menu',
          icon: Icon(Icons.menu_book),
          activeIcon: Icon(Icons.menu_book, color: primaryColor),
        ),
        BottomNavigationBarItem(
          label: 'My order',
          icon: Icon(Icons.list_alt),
          activeIcon: Icon(Icons.list_alt, color: primaryColor),
        ),
        BottomNavigationBarItem(
          label: 'Inbox',
          icon: Icon(Icons.notifications),
          activeIcon: Icon(Icons.notifications, color: primaryColor),
        ),
        BottomNavigationBarItem(
          label: 'Account',
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle_outlined, color: primaryColor),
        ),
      ],
    ),
  );
}
}