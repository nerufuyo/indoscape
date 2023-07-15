import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/constant.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
import 'package:indoscape/presentation/page/menu/menu_about_page.dart';
import 'package:indoscape/presentation/page/menu/menu_weather_page.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:skeletons/skeletons.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  static const routeName = '/explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String? addressVar;
  String? greetingVar;
  String? cityVar;
  String? provinceVar;
  bool isLoading = true;
  double latitude = 0;
  double longitude = 0;

  @override
  void initState() {
    loadData();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _countrySection(context),
                  _weatherSection(context),
                ],
              ),
              const VerticalGap10(),
              _earthquakeSection(),
            ],
          ),
        ),
      ),
    );
  }

  Skeleton _earthquakeSection() {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: ShimmerDiscoveryEarthquakeWidget(context: context),
      child: FutureBuilder(
        future: Repository().getQuake(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: textColor.withOpacity(.25),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Earthquake News',
                      style: jakartaH3.copyWith(color: backgroundColor),
                    ),
                  ),
                  Image.network(
                    data.shakemap.toString(),
                  ),
                  const VerticalGap10(),
                  Text(
                    data.potensi.toString() + data.dirasakan.toString(),
                    style: jakartaH5,
                  ),
                  const VerticalGap10(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Date',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.tanggal.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Time',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.jam.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Coordinates',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.coordinates.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Latitude',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.lintang.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Longitude',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.bujur.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Magnitude',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              '${data.magnitude} SR',
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Depth',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.kedalaman.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'Region',
                              style: jakartaH5.copyWith(
                                color: textColor.withOpacity(.75),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              data.wilayah.toString(),
                              style: jakartaH5.copyWith(
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error',
                style: jakartaH3.copyWith(color: textColor),
              ),
            );
          } else {
            return ShimmerDiscoveryEarthquakeWidget(context: context);
          }
        },
      ),
    );
  }

  Skeleton _countrySection(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: const ShimmerDiscoveryTopWidget(),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MenuAboutPage.routeName);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.225,
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: textColor.withOpacity(.25),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: Repository().getCountryInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index].cca3.toString(),
                              style: jakartaH4.copyWith(color: textColor),
                            ),
                            Text(
                              'Information',
                              style: jakartaCaption.copyWith(color: textColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            data[index].flags!.png.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error',
                    style: jakartaH3.copyWith(color: textColor),
                  ),
                );
              } else {
                return const ShimmerDiscoveryTopWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  Skeleton _weatherSection(BuildContext context) {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: const ShimmerDiscoveryTopWidget(),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MenuWeatherPage.routeName);
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.225,
          height: MediaQuery.of(context).size.height / 11,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: textColor.withOpacity(.25),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: Repository().getWeather(
              latitude.toString(),
              longitude.toString(),
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${kelvinToCelsius(data.main!.temp!).toStringAsFixed(0)}°',
                          style: jakartaH3.copyWith(
                            color: textColor,
                          ),
                        ),
                        Text(
                          cityVar.toString(),
                          style: jakartaCaption.copyWith(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ListView.builder(
                        itemCount: data.weather!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(.25),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Image.network(
                              'https://openweathermap.org/img/wn/${data.weather![index].icon}.png',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error',
                    style: jakartaH3.copyWith(color: textColor),
                  ),
                );
              } else {
                return const ShimmerDiscoveryTopWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  LinearGradient _shimmerGradientCustom() {
    return LinearGradient(
      colors: [
        primaryColor.withOpacity(.25),
        primaryColor.withOpacity(.5),
        primaryColor.withOpacity(.25),
      ],
      begin: const Alignment(-1.0, -0.5),
      end: const Alignment(1.0, 0.5),
      stops: const [0.0, 0.5, 1.0],
      tileMode: TileMode.repeated,
    );
  }

  void loadData() async {
    getLocation();
    greetUser();
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
        addressVar = address;
        List<String> addressParts = addressVar!.split(",");
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

  Future greetUser() async {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greetingVar = 'Good Morning';
      });
    } else if (hour < 18) {
      setState(() {
        greetingVar = 'Good Afternoon';
      });
    } else {
      setState(() {
        greetingVar = 'Good Evening';
      });
    }
  }
}
