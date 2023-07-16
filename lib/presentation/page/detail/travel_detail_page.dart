import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';

class DetailTravelPage extends StatefulWidget {
  const DetailTravelPage({super.key, required this.id});
  static const routeName = '/travel-detail-page';
  final int id;

  @override
  State<DetailTravelPage> createState() => _DetailTravelPageState();
}

class _DetailTravelPageState extends State<DetailTravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Repository().getTravelList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data![widget.id - 1].image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            textColor.withOpacity(.75),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 48,
                    left: 16,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: textColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[widget.id - 1].name.toString(),
                            style: jakartaH3.copyWith(
                              color: backgroundColor,
                            ),
                          ),
                          const HorizontalGap5(),
                          Row(
                            children: [
                              Text(
                                '${data[widget.id - 1].region} | ',
                                style: jakartaH5.copyWith(
                                  color: backgroundColor.withOpacity(.75),
                                ),
                              ),
                              Text(
                                data[widget.id - 1].type.toString(),
                                style: jakartaButton.copyWith(
                                  color: backgroundColor.withOpacity(.75),
                                ),
                              ),
                            ],
                          ),
                          const VerticalGap15(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: backgroundColor.withOpacity(.75),
                                  ),
                                  const HorizontalGap5(),
                                  Text(
                                    data[widget.id - 1].popularity.toString(),
                                    style: jakartaButton.copyWith(
                                      color: backgroundColor.withOpacity(.75),
                                    ),
                                  ),
                                ],
                              ),
                              const HorizontalGap15(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    color: backgroundColor.withOpacity(.75),
                                  ),
                                  const HorizontalGap5(),
                                  Text(
                                    data[widget.id - 1].culture.toString(),
                                    style: jakartaButton.copyWith(
                                      color: backgroundColor.withOpacity(.75),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const VerticalGap15(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const HorizontalGap10(),
                                itemCount:
                                    data[widget.id - 1].highlights!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: backgroundColor.withOpacity(.75),
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    child: Center(
                                      child: Text(
                                        data[widget.id - 1]
                                            .highlights![index]
                                            .toString(),
                                        style: jakartaButton.copyWith(
                                          color:
                                              backgroundColor.withOpacity(.75),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const VerticalGap5(),
                          Divider(
                            thickness: 2,
                            color: backgroundColor.withOpacity(.75),
                          ),
                          const VerticalGap5(),
                          Text(
                            data[widget.id - 1].history.toString(),
                            style: jakartaH4.copyWith(
                              color: backgroundColor.withOpacity(.75),
                            ),
                          ),
                          const VerticalGap5(),
                          Text(
                            data[widget.id - 1].description.toString(),
                            style: jakartaButton.copyWith(
                              color: backgroundColor.withOpacity(.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
