import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
import 'package:indoscape/presentation/page/discovery_page.dart';
import 'package:indoscape/presentation/page/home_page.dart';
import 'package:indoscape/presentation/page/news_page.dart';
import 'package:indoscape/presentation/page/profile_page.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:skeletons/skeletons.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});
  static const routeName = '/navigation';

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  String? addressVar;
  String? greetingVar;
  int selectedIndex = 0;
  bool isLoading = true;
  

  List pages = const [
    HomePage(),
    ExplorePage(),
    NewsPage(),
    ProfilePage(),
  ];

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: _appBarMethod(),
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
            tabBorderRadius: 24,
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
                text: 'Explore',
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
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feature not available yet'),
                  ),
                );
              },
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
