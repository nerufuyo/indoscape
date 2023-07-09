import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:indoscape/presentation/page/discovery_page.dart';
import 'package:indoscape/presentation/page/home_page.dart';
import 'package:indoscape/presentation/page/menu_about_page.dart';
import 'package:indoscape/presentation/page/menu_movie_page.dart';
import 'package:indoscape/presentation/page/menu_weather_page.dart';
import 'package:indoscape/presentation/page/movies/detail_movie_page.dart';
import 'package:indoscape/presentation/page/news_page.dart';
import 'package:indoscape/presentation/widget/navigation_widget.dart';

void main() async {
  await dotenv.load(fileName: '.env');
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
          case ExplorePage.routeName:
            return MaterialPageRoute(builder: (context) => const ExplorePage());
          case NewsPage.routeName:
            return MaterialPageRoute(builder: (context) => const NewsPage());
          case MenuAboutPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuAboutPage());
          case MenuMoviePage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuMoviePage());
          case MenuWeatherPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuWeatherPage());
          case DetailMoviePage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => DetailMoviePage(id: id));
          default:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
        }
      },
    );
  }
}
