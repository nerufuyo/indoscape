import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/presentation/page/home_page.dart';
import 'package:indoscape/presentation/page/news_page.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});
  static const routeName = '/navigation';

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  int selectedIndex = 0;
  List pages = const [
    HomePage(),
    Text('Menu'),
    NewsPage(),
    Text('Profile'),
  ];

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Center(
          child: pages[selectedIndex],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: GNav(
            gap: 8,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: primaryColor,
            activeColor: backgroundColor,
            rippleColor: secondaryColor,
            hoverColor: tertiaryColor,
            color: textColor.withOpacity(.5),
            tabs: const [
              GButton(
                icon: FontAwesomeIcons.house,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.box,
                text: 'Menu',
              ),
              GButton(
                icon: FontAwesomeIcons.newspaper,
                text: 'News',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              onTap(index);
            },
          ),
        ),
      ),
    );
  }
}
