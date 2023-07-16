import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:indoscape/presentation/page/detail/culture_detail_page.dart';
import 'package:indoscape/presentation/page/detail/mountain_detail_page.dart';
import 'package:indoscape/presentation/page/detail/travel_detail_page.dart';
import 'package:indoscape/presentation/page/discovery_page.dart';
import 'package:indoscape/presentation/page/detail/food_detail_page.dart';
import 'package:indoscape/presentation/page/home_page.dart';
import 'package:indoscape/presentation/page/introduction_page.dart';
import 'package:indoscape/presentation/page/menu/menu_about_page.dart';
import 'package:indoscape/presentation/page/menu/menu_cities_page.dart';
import 'package:indoscape/presentation/page/menu/menu_culture_page.dart';
import 'package:indoscape/presentation/page/menu/menu_food_page.dart';
import 'package:indoscape/presentation/page/menu/menu_mountain_page.dart';
import 'package:indoscape/presentation/page/menu/menu_movie_page.dart';
import 'package:indoscape/presentation/page/menu/menu_travel_page.dart';
import 'package:indoscape/presentation/page/menu/menu_weather_page.dart';
import 'package:indoscape/presentation/page/movies/category_movie_page.dart';
import 'package:indoscape/presentation/page/movies/detail_movie_page.dart';
import 'package:indoscape/presentation/page/news_page.dart';
import 'package:indoscape/presentation/page/profile_page.dart';
import 'package:indoscape/presentation/page/splash_page.dart';
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
      initialRoute: SplashPage.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case SplashPage.routeName:
            return MaterialPageRoute(builder: (context) => const SplashPage());
          case IntroductionPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const IntroductionPage());
          case NavigationWidget.routeName:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
          case HomePage.routeName:
            return MaterialPageRoute(builder: (context) => const HomePage());
          case ExplorePage.routeName:
            return MaterialPageRoute(builder: (context) => const ExplorePage());
          case NewsPage.routeName:
            return MaterialPageRoute(builder: (context) => const NewsPage());
          case ProfilePage.routeName:
            return MaterialPageRoute(builder: (context) => const ProfilePage());
          case MenuAboutPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuAboutPage());
          case MenuMountainPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuMountainPage());
          case MenuMoviePage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuMoviePage());
          case MenuCulturePage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuCulturePage());
          case MenuCitiesPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuCitiesPage());
          case MenuWeatherPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuWeatherPage());
          case MenuFoodPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuFoodPage());
          case MenuTravelPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const MenuTravelPage());
          case CategoryMoviePage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => CategoryMoviePage(id: id));
          case FoodDetailPage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => FoodDetailPage(id: id));
          case DetailMoviePage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => DetailMoviePage(id: id));
          case DetailMountainPage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => DetailMountainPage(id: id));
          case DetailCulturePage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => DetailCulturePage(id: id));
          case DetailTravelPage.routeName:
            int id = settings.arguments as int;
            return MaterialPageRoute(
                builder: (context) => DetailTravelPage(id: id));
          default:
            return MaterialPageRoute(
                builder: (context) => const NavigationWidget());
        }
      },
    );
  }
}
