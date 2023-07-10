// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/constant.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/charades_model.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? addressVar;
  String? greetingVar;
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
    return Scaffold(
      appBar: _appBarMethod(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: primaryColor,
            ),
            _bgDotRightBack(),
            _bgDotRightFront(),
            _bgDotLeftBack(),
            _bgDotLeftFront(),
            _mainContent(context),
            _floatingMenuMethod(context),
          ],
        ),
      ),
    );
  }

  Positioned _mainContent(BuildContext context) {
    return Positioned(
      top: 180,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: backgroundColor,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _travelTitle(),
              const VerticalGap10(),
              _tavelContent(context),
              const VerticalGap20(),
              _charadesContent(),
              const VerticalGap20(),
              _fooddrinksTitle(),
              const VerticalGap10(),
              _fooddrinksContent(context),
              const VerticalGap30(),
              const VerticalGap30(),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<CharadesModel> _charadesContent() {
    return FutureBuilder(
      future: Repository().getCharades(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: textColor.withOpacity(.25)),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: textColor.withOpacity(.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: textColor.withOpacity(.25)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    data!.soal.toString(),
                    style: jakartaH4,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: textColor.withOpacity(.25)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    data.jawaban.toString(),
                    style: jakartaH4,
                  ),
                ),
              ],
            ),
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
    );
  }

  SizedBox _fooddrinksContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, index) =>
            const HorizontalGap5(),
        itemCount: 10,
        itemBuilder: (BuildContext context, index) {
          return Skeleton(
            isLoading: isLoading,
            duration: const Duration(seconds: 2),
            themeMode: ThemeMode.light,
            shimmerGradient: _shimmerGradientCustom(),
            skeleton: const ShimmerFoodDrinkWidget(),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.25,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  color: textColor.withOpacity(.15),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('lib/assets/images/bakso.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.75,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.utensils,
                              size: 12,
                              color: primaryColor,
                            ),
                            const HorizontalGap5(),
                            Text(
                              'Food & Drinks',
                              style: jakartaH6,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bakso',
                              style: jakartaH4,
                            ),
                            Text(
                              'Rp. 10.000',
                              style: jakartaH5,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 12,
                              color: primaryColor,
                            ),
                            const HorizontalGap5(),
                            Text(
                              'Jl. Jend. Sudirman No. 1',
                              style: jakartaH6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _fooddrinksTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Ordinary Foods & Drinks',
            style: jakartaH3,
          ),
          Text(
            'See All',
            style: jakartaButton.copyWith(color: primaryColor),
          ),
        ],
      ),
    );
  }

  SizedBox _tavelContent(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, index) =>
            const HorizontalGap5(),
        itemCount: 10,
        itemBuilder: (BuildContext context, index) {
          return Skeleton(
            isLoading: isLoading,
            duration: const Duration(seconds: 2),
            themeMode: ThemeMode.light,
            shimmerGradient: _shimmerGradientCustom(),
            skeleton: const ShimmerTravelWidget(),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/images/bromo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(.25),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      'Mountain',
                      style: jakartaCaption.copyWith(
                        color: backgroundColor,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.pin_drop_outlined,
                        color: backgroundColor,
                        size: 20,
                      ),
                      const HorizontalGap5(),
                      Flexible(
                        child: Text(
                          'Bromo, East Java',
                          style: jakartaCaption.copyWith(
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding _travelTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60,
        left: 16,
        right: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Travel Destination',
            style: jakartaH3,
          ),
          Text(
            'See All',
            style: jakartaButton.copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }

  Positioned _bgDotLeftFront() {
    return Positioned(
      top: 60,
      left: -40,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: tertiaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Positioned _bgDotLeftBack() {
    return Positioned(
      top: 40,
      left: -80,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Positioned _bgDotRightFront() {
    return Positioned(
      top: 16,
      right: -40,
      child: Container(
        width: 140,
        height: 60,
        decoration: BoxDecoration(
          color: tertiaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  Positioned _bgDotRightBack() {
    return Positioned(
      top: 0,
      right: -40,
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.25),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  Positioned _floatingMenuMethod(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.25,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: textColor.withOpacity(0.125),
              blurRadius: 2,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          clipBehavior: Clip.hardEdge,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
            mainAxisSpacing: 8,
            mainAxisExtent: 86,
          ),
          itemCount: floatingMenuContentText.length,
          itemBuilder: (context, index) {
            return Skeleton(
              isLoading: isLoading,
              duration: const Duration(seconds: 2),
              themeMode: ThemeMode.light,
              shimmerGradient: _shimmerGradientCustom(),
              skeleton: const ShimmerFloatingWidget(),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, floatingMenuContentRoute[index]);
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 7.5,
                        ),
                        Positioned(
                          top: 0,
                          bottom: 10,
                          left: 0,
                          right: 10,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: 55,
                            decoration: BoxDecoration(
                              color: flostingMenuContentColor[index]
                                  .withOpacity(.45),
                              backgroundBlendMode: BlendMode.darken,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          bottom: 0,
                          left: 8,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(
                                  flostingMenuContentIcon[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const VerticalGap5(),
                    Expanded(
                      child: Text(
                        floatingMenuContentText[index],
                        style: jakartaButton.copyWith(color: textColor),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _appBarMethod() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
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
                  style: jakartaH3.copyWith(color: backgroundColor),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.pin_drop_outlined,
                      size: 16,
                      color: backgroundColor,
                    ),
                    const HorizontalGap5(),
                    Text(
                      addressVar.toString(),
                      style: jakartaCaption.copyWith(color: backgroundColor),
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
                    color: backgroundColor,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        color: accentColor,
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
