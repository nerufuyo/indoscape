// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/constant.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/food_model.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/presentation/page/detail/food_detail_page.dart';
import 'package:indoscape/presentation/page/detail/mountain_detail_page.dart';
import 'package:indoscape/presentation/page/detail/travel_detail_page.dart';
import 'package:indoscape/presentation/page/menu/menu_food_page.dart';
import 'package:indoscape/presentation/page/menu/menu_travel_page.dart';
import 'package:indoscape/presentation/widget/shimmer_widget.dart';
import 'package:skeletons/skeletons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
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
              _mountainContent(),
              const VerticalGap20(),
              _foodTitle(),
              const VerticalGap10(),
              _foodsContent(),
            ],
          ),
        ),
      ),
    );
  }

  Skeleton _mountainContent() {
    return Skeleton(
      isLoading: isLoading,
      duration: const Duration(seconds: 2),
      themeMode: ThemeMode.light,
      shimmerGradient: _shimmerGradientCustom(),
      skeleton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ShimmerMountainCarousel(context: context),
      ),
      child: FutureBuilder(
        future: Repository().getMountainList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 5,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 20),
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                autoPlayCurve: Curves.easeInOut,
                clipBehavior: Clip.hardEdge,
                viewportFraction: 1,
                pauseAutoPlayOnTouch: true,
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final mountain = data![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailMountainPage.routeName,
                      arguments: mountain.id,
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.075,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(mountain.image.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                textColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            mountain.active == true ? 'Active' : 'Non-Active',
                            style: jakartaCaption.copyWith(
                              color: backgroundColor,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  const HorizontalGap5(),
                                  Text(
                                    mountain.region.toString(),
                                    style: jakartaBodyText2.copyWith(
                                      color: backgroundColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Mountain ${mountain.name.toString()}',
                                style: jakartaH3.copyWith(
                                  color: backgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
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

  FutureBuilder<List<FoodModel>> _foodsContent() {
    return FutureBuilder(
      future: Repository().getFoodList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height / 8,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, index) =>
                  const HorizontalGap5(),
              itemCount: data!.length,
              itemBuilder: (BuildContext context, index) {
                final food = data[index];
                return Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: _shimmerGradientCustom(),
                  skeleton: const ShimmerFoodDrinkWidget(),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        FoodDetailPage.routeName,
                        arguments: food.id,
                      );
                    },
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
                              image: DecorationImage(
                                image: AssetImage(food.imageUrl.toString()),
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
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      food.name.toString(),
                                      style: jakartaH4,
                                    ),
                                    const HorizontalGap5(),
                                    Text(
                                      food.region.toString(),
                                      style: jakartaH6.copyWith(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  food.price.toString(),
                                  style: jakartaH5,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  food.description.toString(),
                                  style: jakartaButton,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Padding _foodTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MenuFoodPage.routeName);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Traditional Foods',
              style: jakartaH3,
            ),
            Text(
              'See All',
              style: jakartaButton.copyWith(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder _tavelContent(BuildContext context) {
    return FutureBuilder(
      future: Repository().getTravelList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, index) =>
                  const HorizontalGap5(),
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                final travel = data[index];
                return Skeleton(
                  isLoading: isLoading,
                  duration: const Duration(seconds: 2),
                  themeMode: ThemeMode.light,
                  shimmerGradient: _shimmerGradientCustom(),
                  skeleton: const ShimmerTravelWidget(),
                  child: InkWell(
                    onTap: () {
                       Navigator.pushNamed(
                        context,
                        DetailTravelPage.routeName,
                        arguments: travel.id,
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(travel.image.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  textColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: textColor.withOpacity(.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              travel.type.toString(),
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
                                  travel.region.toString(),
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
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
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

  Padding _travelTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 60,
        left: 16,
        right: 16,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, MenuTravelPage.routeName);
        },
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
}
