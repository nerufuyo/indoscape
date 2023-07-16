import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';

class ShimmerAppBarWidget extends StatelessWidget {
  const ShimmerAppBarWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 20,
              decoration: BoxDecoration(
                color: tertiaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const VerticalGap5(),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 20,
              decoration: BoxDecoration(
                color: tertiaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: tertiaryColor.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

class ShimmerFloatingWidget extends StatelessWidget {
  const ShimmerFloatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor,
          ),
        ),
        const VerticalGap5(),
        Container(
          width: 60,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor,
          ),
        ),
      ],
    );
  }
}

class ShimmerTravelWidget extends StatelessWidget {
  const ShimmerTravelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class ShimmerFoodDrinkWidget extends StatelessWidget {
  const ShimmerFoodDrinkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.25,
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class ShimmerDropDownNewsStation extends StatelessWidget {
  const ShimmerDropDownNewsStation({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: tertiaryColor.withOpacity(0.25),
      ),
    );
  }
}

class ShimmerNewsCategory extends StatelessWidget {
  const ShimmerNewsCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor.withOpacity(.25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor.withOpacity(.25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor.withOpacity(.25),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: tertiaryColor.withOpacity(.25),
          ),
        ),
      ],
    );
  }
}

class ShimmerNewsCarousel extends StatelessWidget {
  const ShimmerNewsCarousel({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: tertiaryColor.withOpacity(.25),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class ShimmerCurrentlyNewsList extends StatelessWidget {
  const ShimmerCurrentlyNewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const VerticalGap10(),
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: tertiaryColor.withOpacity(.25),
        ),
      ),
    );
  }
}

class ShimmerDiscoveryTopWidget extends StatelessWidget {
  const ShimmerDiscoveryTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.225,
      height: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
        color: tertiaryColor.withOpacity(.25),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class ShimmerDiscoveryEarthquakeWidget extends StatelessWidget {
  const ShimmerDiscoveryEarthquakeWidget({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        color: tertiaryColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class ShimmerMoviesCarouselLists extends StatelessWidget {
  const ShimmerMoviesCarouselLists({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.75,
      decoration: BoxDecoration(
        color: tertiaryColor.withOpacity(.25),
      ),
    );
  }
}

class ShimmerMoviesListView extends StatelessWidget {
  const ShimmerMoviesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const HorizontalGap10(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: tertiaryColor.withOpacity(.25),
                ),
              ),
              const VerticalGap10(),
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: tertiaryColor.withOpacity(.25),
                ),
              ),
              const VerticalGap5(),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: tertiaryColor.withOpacity(.25),
                ),
              ),
            ],
          );
        });
  }
}

class ShimmerMountainCarousel extends StatelessWidget {
  const ShimmerMountainCarousel({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.075,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
