import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/news_model.dart';
import 'package:indoscape/data/models/news_station_model.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/domain/usecase/get_location.dart';
import 'package:indoscape/presentation/widget/loading_widget.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});
  static const routeName = '/news_page';

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String? greetingVar;
  String? addressVar;
  bool isLoading = true;
  String dropdownValue = 'antara';
  String newCategory = 'terbaru';
  int selectedNameIndex = 0;
  int selectedPahsIndex = 0;

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
      appBar: _appBarMethod(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: Repository().getNewsStationList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        _dropDownNavigation(snapshot),
                        const HorizontalGap5(),
                        _categoryNavigation(snapshot),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: jakartaBodyText1.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  );
                } else {
                  return const LoadingNewsNavigation();
                }
              },
            ),
            const VerticalGap10(),
            FutureBuilder(
              future: Repository().getNewsList(
                dropdownValue,
                newCategory,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _carouselNews(data),
                        const VerticalGap10(),
                        _newsList(context, data),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: jakartaBodyText1.copyWith(
                        color: primaryColor,
                      ),
                    ),
                  );
                } else {
                  return const LoadingCurrentlyNewsList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _newsList(BuildContext context, NewsModel data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Berita Terkini',
            style: jakartaH3.copyWith(
              color: textColor,
            ),
          ),
          const VerticalGap5(),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: textColor.withOpacity(.25),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const VerticalGap10(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Skeleton(
              isLoading: isLoading,
              duration: const Duration(seconds: 2),
              themeMode: ThemeMode.light,
              shimmerGradient: _shimmerGradientCustom(),
              skeleton: const ShimmerCurrentlyNewsList(),
              child: ListView.separated(
                separatorBuilder: (context, index) => const VerticalGap10(),
                itemCount: data.posts!.length,
                itemBuilder: (context, index) {
                  final dateFormatted = DateFormat('dd MMMM yyyy').format(
                    DateTime.parse(
                      data.posts![index].pubDate!.toString(),
                    ),
                  );
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: textColor.withOpacity(.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(
                                data.posts![index].thumbnail!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                    color: primaryColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    data.title!.split('-')[0].toString(),
                                    style: jakartaH6.copyWith(
                                      color: backgroundColor,
                                    ),
                                  ),
                                ),
                                const VerticalGap10(),
                                Text(
                                  data.posts![index].title!,
                                  style: jakartaH5,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const VerticalGap5(),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.clock,
                                      color: textColor,
                                      size: 14,
                                    ),
                                    const HorizontalGap5(),
                                    Text(
                                      dateFormatted,
                                      style: jakartaCaption.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Skeleton _carouselNews(NewsModel data) {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: ShimmerNewsCarousel(context: context),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlayCurve: Curves.easeInOut,
          clipBehavior: Clip.hardEdge,
          viewportFraction: 1,
          pauseAutoPlayOnTouch: true,
        ),
        itemCount: data.posts!.length > 5 ? 5 : data.posts!.length,
        itemBuilder: (BuildContext context, index, realIndex) {
          return InkWell(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    data.posts![index].thumbnail.toString(),
                  ),
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          textColor.withOpacity(0.5),
                          textColor.withOpacity(0.75),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor,
                      ),
                      child: Text(
                        data.title!.split('-')[0].toString(),
                        style: jakartaButton.copyWith(
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.posts![index].title.toString(),
                          style: jakartaH4.copyWith(
                            color: backgroundColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const VerticalGap5(),
                        Text(
                          data.posts![index].description.toString(),
                          style: jakartaBodyText2.copyWith(
                            color: backgroundColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Skeleton _dropDownNavigation(
      AsyncSnapshot<List<NewsStationListModel>> snapshot) {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: ShimmerDropDownNewsStation(context: context),
      child: SizedBox(
        child: DropdownButton(
          value: dropdownValue,
          icon: const Icon(
            FontAwesomeIcons.chevronDown,
            color: textColor,
          ),
          iconSize: 16,
          focusColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          borderRadius: BorderRadius.circular(8),
          style: jakartaBodyText1.copyWith(color: textColor),
          underline: const SizedBox.shrink(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              selectedNameIndex =
                  snapshot.data!.indexWhere((value) => value.name == newValue);
            });
          },
          items: snapshot.data!
              .map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(
                          value.name!.toUpperCase(),
                          style: jakartaH5,
                        ),
                      ))
              .toList(),
        ),
      ),
    );
  }

  Expanded _categoryNavigation(
      AsyncSnapshot<List<NewsStationListModel>> snapshot) {
    return Expanded(
      child: SizedBox(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(right: 16),
          scrollDirection: Axis.horizontal,
          child: Skeleton(
            isLoading: isLoading,
            duration: const Duration(seconds: 2),
            themeMode: ThemeMode.light,
            shimmerGradient: _shimmerGradientCustom(),
            skeleton: const ShimmerNewsCategory(),
            child: GNav(
              gap: 4,
              iconSize: 20,
              padding: const EdgeInsets.all(12),
              tabMargin: const EdgeInsets.symmetric(horizontal: 4),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor,
              activeColor: backgroundColor,
              rippleColor: secondaryColor,
              hoverColor: tertiaryColor,
              color: textColor.withOpacity(.5),
              tabs: snapshot.data![selectedNameIndex].paths!
                  .map<GButton>(
                    (path) => GButton(
                      icon: FontAwesomeIcons.newspaper,
                      text: path.name!.substring(0, 1).toUpperCase() +
                          path.name!.substring(1, path.name!.length),
                      textStyle: jakartaButton.copyWith(
                        color: backgroundColor,
                      ),
                    ),
                  )
                  .toList(),
              selectedIndex: selectedPahsIndex,
              onTabChange: (index) {
                setState(() {
                  selectedPahsIndex = index;
                  List pathParts = snapshot
                      .data![selectedNameIndex].paths![selectedPahsIndex].path!
                      .split("/");
                  newCategory = pathParts[pathParts.length - 2];
                });
              },
            ),
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
