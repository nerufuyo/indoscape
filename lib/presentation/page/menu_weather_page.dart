import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/constant.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
import 'package:intl/intl.dart';

class MenuWeatherPage extends StatefulWidget {
  const MenuWeatherPage({super.key});
  static const routeName = '/menu_weather';

  @override
  State<MenuWeatherPage> createState() => _MenuWeatherPageState();
}

class _MenuWeatherPageState extends State<MenuWeatherPage> {
  String cityVar = 'Bandung';
  String provinceVar = 'Jawa-Barat';
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: backgroundColor,
          ),
        ),
        centerTitle: true,
        title: Text(cityVar, style: jakartaH3),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _todaySection(),
          const VerticalGap10(),
          _weatherToday(),
          const VerticalGap20(),
          _weatherByHour(),
        ],
      ),
    );
  }

  Column _weatherByHour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Weather Prediciton',
          style: jakartaH3.copyWith(
            color: backgroundColor,
          ),
        ),
        const VerticalGap10(),
        FutureBuilder(
          future: Repository().getWeatherByHour(
            latitude.toString(),
            longitude.toString(),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const HorizontalGap10(),
                  itemCount: data.list!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss")
                        .parse(data.list![index].dtTxt.toString());
                    String dateMonth = DateFormat("dd MMM").format(dateTime);
                    String hourMinute = DateFormat("HH:mm").format(dateTime);

                    return Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: backgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${kelvinToCelsius(data.list![index].main!.temp!).toStringAsFixed(0)}°',
                            style: jakartaH3.copyWith(
                              color: backgroundColor,
                            ),
                          ),
                          const VerticalGap10(),
                          Image.network(
                            'https://openweathermap.org/img/wn/${data.list![index].weather![0].icon}.png',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          const VerticalGap10(),
                          Column(
                            children: [
                              Text(
                                dateMonth,
                                style: jakartaH5.copyWith(
                                  color: backgroundColor,
                                ),
                              ),
                              Text(
                                hourMinute,
                                style: jakartaH6.copyWith(
                                  color: backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: backgroundColor,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Padding _weatherToday() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: FutureBuilder(
        future:
            Repository().getWeather(latitude.toString(), longitude.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const HorizontalGap5(),
                      itemCount: data!.weather!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          data.weather![index].description!.toUpperCase(),
                          style: jakartaH5.copyWith(color: backgroundColor),
                        );
                      },
                    ),
                  ),
                ),
                const VerticalGap10(),
                Text(
                  '${kelvinToCelsius(data.main!.temp!).toStringAsFixed(0)}°',
                  style: jakartaH1.copyWith(
                    color: backgroundColor,
                    fontSize: 160,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.wind,
                            color: primaryColor,
                            size: 52,
                          ),
                          const VerticalGap10(),
                          Text(
                            '${data.wind!.speed!.toStringAsFixed(2)}km/h',
                            style: jakartaH4.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Wind',
                            style: jakartaBodyText1.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.droplet,
                            color: primaryColor,
                            size: 52,
                          ),
                          const VerticalGap10(),
                          Text(
                            '${data.main!.humidity}%',
                            style: jakartaH4.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: jakartaBodyText1.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.eye,
                            color: primaryColor,
                            size: 52,
                          ),
                          const VerticalGap10(),
                          Text(
                            '${metersToKilometers(data.visibility!.toDouble()).toStringAsFixed(0)} km',
                            style: jakartaH4.copyWith(
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            'Visibility',
                            style: jakartaBodyText1.copyWith(
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Error');
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        },
      ),
    );
  }

  Container _todaySection() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
        style: jakartaH5.copyWith(color: primaryColor),
      ),
    );
  }

  void loadData() async {
    getLocation();
  }

  Future getLocation() async {
    try {
      Position position = await getCurrentLocation();
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      String address = await getAddress(latitude, longitude);
      setState(() {
        String addressVar = address;
        List<String> addressParts = addressVar.split(",");
        String cityName = addressParts[0]
            .replaceAll("Kota", "")
            .trim()
            .replaceAll("Kabupaten", "")
            .trim();
        String provinceName = addressParts[1].trim().replaceAll(" ", "-");
        cityVar = cityName;
        provinceVar = provinceName;
      });
      return address;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }
}
