// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indoscape/presentation/page/menu/menu_about_page.dart';
import 'package:indoscape/presentation/page/menu/menu_cities_page.dart';
import 'package:indoscape/presentation/page/menu/menu_culture_page.dart';
import 'package:indoscape/presentation/page/menu/menu_food_page.dart';
import 'package:indoscape/presentation/page/menu/menu_mountain_page.dart';
import 'package:indoscape/presentation/page/menu/menu_movie_page.dart';
import 'package:indoscape/presentation/page/menu/menu_travel_page.dart';
import 'package:indoscape/presentation/page/menu/menu_weather_page.dart';

double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

double metersToKilometers(double meters) {
  return meters / 1000;
}

List floatingMenuContentText = [
  'About',
  'Mountains',
  'Cultures',
  'Travels',
  'Movies',
  'Cities',
  'Weather',
  'Foods',
];

List flostingMenuContentIcon = [
  'lib/assets/images/info.png',
  'lib/assets/images/mountain.png',
  'lib/assets/images/culture.png',
  'lib/assets/images/travel.png',
  'lib/assets/images/film.png',
  'lib/assets/images/city.png',
  'lib/assets/images/province.png',
  'lib/assets/images/food.png',
];

List floatingMenuContentRoute = [
  MenuAboutPage.routeName,
  MenuMountainPage.routeName,
  MenuCulturePage.routeName,
  MenuTravelPage.routeName,
  MenuMoviePage.routeName,
  MenuCitiesPage.routeName,
  MenuWeatherPage.routeName,
  MenuFoodPage.routeName,
];

List flostingMenuContentColor = [
  const Color(0xFF66A5DA),
  const Color(0xFF15181A),
  const Color(0xFFE8B647),
  const Color(0xFF1EDEEF),
  const Color(0xFF357FEF),
  const Color(0xFFDEBE79),
  const Color(0xFF95DF8D),
  const Color(0xFF769AE4),
];

Map<int, List<IconData>> categoryIcons = {
  1: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.scaleBalanced,
    FontAwesomeIcons.gavel,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.futbol,
    FontAwesomeIcons.running,
    FontAwesomeIcons.book,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.glassCheers,
    FontAwesomeIcons.globeAsia,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.car,
  ],
  2: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.dollarSign,
    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.personBooth,
    FontAwesomeIcons.mosque,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.glassCheers,
    FontAwesomeIcons.globeAsia,
    FontAwesomeIcons.handsBubbles,
  ],
  3: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.flag,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.running,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.baseball,
    FontAwesomeIcons.glassCheers,
  ],
  4: [FontAwesomeIcons.fire],
  5: [FontAwesomeIcons.fire],
  6: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.city,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.running,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.car,
    FontAwesomeIcons.paintRoller,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.mountainCity,
  ],
  7: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.artstation,
    FontAwesomeIcons.running,
    FontAwesomeIcons.car,
    FontAwesomeIcons.moneyBill,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.soccerBall,
  ],
  8: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.newspaper,
    FontAwesomeIcons.placeOfWorship,
    FontAwesomeIcons.circleCheck,
    FontAwesomeIcons.mosque,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.soccerBall,
    FontAwesomeIcons.plane,
  ],
  9: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.flag,
    FontAwesomeIcons.city,
    FontAwesomeIcons.circleCheck,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.mountainCity,
    FontAwesomeIcons.soccerBall,
    FontAwesomeIcons.car,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.book,
    FontAwesomeIcons.heartPulse,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.gauge,
  ],
  10: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.soccerBall,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.television,
    FontAwesomeIcons.car,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.heartPulse,
  ],
  11: [
    FontAwesomeIcons.flag,
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.city,
    FontAwesomeIcons.globe,
    FontAwesomeIcons.soccerBall,
    FontAwesomeIcons.brush,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.car,
    FontAwesomeIcons.person,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.chair,
    FontAwesomeIcons.brain,
    FontAwesomeIcons.info,
    FontAwesomeIcons.cakeCandles,
  ],
  12: [
    FontAwesomeIcons.fire,
    FontAwesomeIcons.moneyBillTransfer,
    FontAwesomeIcons.baseballBatBall,
    FontAwesomeIcons.soccerBall,
    FontAwesomeIcons.running,
    FontAwesomeIcons.person,
    FontAwesomeIcons.tshirt,
    FontAwesomeIcons.plane,
    FontAwesomeIcons.female,
    FontAwesomeIcons.car,
    FontAwesomeIcons.microchip,
    FontAwesomeIcons.heartPulse,
  ],
};

final List<String> desiredTimes = ['06:00', '12:00', '18:00'];
