import 'package:flutter/material.dart';
import 'package:indoscape/presentation/page/home_page.dart';
import 'package:indoscape/presentation/page/menu_about_page.dart';
import 'package:indoscape/presentation/page/news_page.dart';
import 'package:indoscape/presentation/widget/navigation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INDOSCAPE',
      initialRoute: NavigationWidget.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case NavigationWidget.routeName:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case NewsPage.routeName:
            return MaterialPageRoute(builder: (context) => const NewsPage());
          case MenuAboutPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuAboutPage());
          default:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
        }
      },
    );
  }
}
