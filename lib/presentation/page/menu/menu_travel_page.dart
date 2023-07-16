import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/presentation/page/detail/travel_detail_page.dart';

class MenuTravelPage extends StatefulWidget {
  const MenuTravelPage({super.key});
  static const routeName = '/menu_travel_page';

  @override
  State<MenuTravelPage> createState() => _MenuTravelPageState();
}

class _MenuTravelPageState extends State<MenuTravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBarSection(context),
      body: FutureBuilder(
        future: Repository().getTravelList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                separatorBuilder: (context, index) => const VerticalGap10(),
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  final travel = data[index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(travel.image.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  textColor.withOpacity(.5),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    travel.name.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const VerticalGap5(),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.pin_drop,
                                            color: backgroundColor
                                                .withOpacity(.75),
                                            size: 16,
                                          ),
                                          const HorizontalGap5(),
                                          Text(
                                            travel.region.toString(),
                                            style: jakartaButton.copyWith(
                                              color: backgroundColor
                                                  .withOpacity(.75),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const HorizontalGap10(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: backgroundColor
                                                .withOpacity(.75),
                                            size: 16,
                                          ),
                                          const HorizontalGap5(),
                                          Text(
                                            travel.popularity.toString(),
                                            style: jakartaButton.copyWith(
                                              color: backgroundColor
                                                  .withOpacity(.75),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailTravelPage.routeName,
                                    arguments: travel.id,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: textColor.withOpacity(.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              travel.type.toString(),
                              style: jakartaButton.copyWith(
                                color: backgroundColor,
                              ),
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }

  AppBar _appBarSection(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: primaryColor,
        ),
      ),
      centerTitle: true,
      title: Text(
        'Travel',
        style: jakartaH3.copyWith(color: primaryColor),
      ),
    );
  }
}
