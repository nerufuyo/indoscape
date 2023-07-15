import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key, required this.id});
  static const routeName = '/food_detail_page';
  final int id;

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository().getFoodList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 96),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              data![widget.id - 1].imageUrl.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const VerticalGap10(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    FontAwesomeIcons.dollarSign,
                                    size: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                                const HorizontalGap5(),
                                Text(
                                  data[widget.id - 1].price.toString(),
                                  style: jakartaH5.copyWith(
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: const Icon(
                                    FontAwesomeIcons.treeCity,
                                    size: 16,
                                    color: backgroundColor,
                                  ),
                                ),
                                const HorizontalGap5(),
                                Text(
                                  data[widget.id - 1].region.toString(),
                                  style: jakartaH5.copyWith(
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const VerticalGap10(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Text(
                                data[widget.id - 1].description.toString(),
                                style: jakartaButton.copyWith(
                                  color: textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const VerticalGap20(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Recomendation', style: jakartaH3),
                            ],
                          ),
                        ),
                        const VerticalGap10(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(left: 16),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (BuildContext context, index) =>
                                const HorizontalGap5(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, index) {
                              final food = data[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    FoodDetailPage.routeName,
                                    arguments: food.id,
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.25,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                food.imageUrl.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.75,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
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
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 52,
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
                            color: primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            FontAwesomeIcons.chevronLeft,
                            color: backgroundColor,
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        data[widget.id - 1].name.toString(),
                        style: jakartaH3.copyWith(
                          color: textColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Feature not available yet'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: const Icon(
                            FontAwesomeIcons.heart,
                            color: backgroundColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
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
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }
      },
    );
  }
}
