import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
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
    bool isLoading = true;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBarMethod(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2.225,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(
                        color: textColor.withOpacity(.25),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Jakarta',
                        style: jakartaH3.copyWith(color: textColor),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.225,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(
                        color: textColor.withOpacity(.25),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Jakarta',
                        style: jakartaH3.copyWith(color: textColor),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalGap10(),
              Skeleton(
                isLoading: isLoading,
                duration: const Duration(seconds: 2),
                themeMode: ThemeMode.light,
                shimmerGradient: _shimmerGradientCustom(),
                skeleton: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: FutureBuilder(
                  future: Repository().getQuake(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error',
                          style: jakartaH3.copyWith(color: textColor),
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBarMethod() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Skeleton(
        isLoading: isLoading,
        duration: const Duration(seconds: 2),
        themeMode: ThemeMode.light,
        shimmerGradient: _shimmerGradientCustom(),
        skeleton: ShimmerAppBarWidget(context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greetingVar!',
                  style: jakartaH3.copyWith(color: textColor),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      size: 16,
                      color: textColor,
                    ),
                    const HorizontalGap5(),
                    Text(
                      addressVar.toString(),
                      style: jakartaCaption.copyWith(color: textColor),
                    ),
                  ],
                )
              ],
            ),
            InkWell(
              onTap: () {},
              focusColor: primaryColor,
              hoverColor: primaryColor,
              highlightColor: primaryColor,
              child: Stack(
                children: [
                  const Icon(
                    FontAwesomeIcons.solidBell,
                    size: 24,
                    color: textColor,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: backgroundColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    double latitude = 0;
    double longitude = 0;
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
