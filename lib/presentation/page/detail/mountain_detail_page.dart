// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/models/mountain_model.dart';
import 'package:indoscape/data/repositories/repository.dart';

class DetailMountainPage extends StatefulWidget {
  const DetailMountainPage({super.key, required this.id});
  static const routeName = '/mountain-detail-page';
  final int id;

  @override
  State<DetailMountainPage> createState() => _DetailMountainPageState();
}

class _DetailMountainPageState extends State<DetailMountainPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Repository().getMountainList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _mountainsPhoto(context, data),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mountain ${data![widget.id].name.toString()}',
                                style: jakartaH2,
                              ),
                              const VerticalGap10(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  const HorizontalGap5(),
                                  Text(
                                    '${data[widget.id].region.toString()}, Indonesia',
                                    style: jakartaH4.copyWith(
                                      color: textColor.withOpacity(.5),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalGap10(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          Icons.monitor_heart_rounded,
                                          color: backgroundColor,
                                        ),
                                        const HorizontalGap5(),
                                        Text(
                                          '${data[widget.id].elevation.toString()} m',
                                          style: jakartaCaption.copyWith(
                                            color: backgroundColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.rectangleAd,
                                          color: backgroundColor,
                                        ),
                                        const HorizontalGap5(),
                                        Text(
                                          data[widget.id].range.toString(),
                                          style: jakartaCaption.copyWith(
                                            color: backgroundColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.mountain,
                                          color: backgroundColor,
                                        ),
                                        const HorizontalGap5(),
                                        Text(
                                          data[widget.id].active == true
                                              ? 'Active'
                                              : 'Non-Active',
                                          style: jakartaCaption.copyWith(
                                            color: backgroundColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalGap10(),
                              Text(
                                'Description',
                                style: jakartaH3,
                              ),
                              const VerticalGap5(),
                              Text(
                                data[widget.id].description.toString(),
                                style: jakartaButton.copyWith(
                                  color: textColor,
                                ),
                              ),
                              const VerticalGap10(),
                              Text(
                                'Recommended Mountain',
                                style: jakartaH3,
                              ),
                              const VerticalGap5(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 5,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const HorizontalGap5(),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            DetailMountainPage.routeName,
                                            arguments: data[widget.id].id);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              data[index].image.toString(),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const VerticalGap10(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Coming soon!'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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

  Container _mountainsPhoto(BuildContext context, List<MountainModel>? data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(data![widget.id].image.toString()),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              backgroundColor,
            ],
          ),
        ),
      ),
    );
  }
}
