// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';

class MenuAboutPage extends StatefulWidget {
  const MenuAboutPage({super.key});
  static const routeName = '/menu_about';

  @override
  State<MenuAboutPage> createState() => _MenuAboutPageState();
}

class _MenuAboutPageState extends State<MenuAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Repository().getCountryInformation(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('lib/assets/images/bgBromo.jpg'),
                      colorFilter: ColorFilter.mode(
                        textColor.withOpacity(.25),
                        BlendMode.darken,
                      ),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(.75),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      data[index].name!.official.toString(),
                                      style: jakartaH3.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                    const HorizontalGap5(),
                                    Container(
                                      color: primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: Text(
                                        data[index].cca2.toString(),
                                        style: jakartaH4.copyWith(
                                          color: backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const VerticalGap5(),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.mapMarkerAlt,
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                    const HorizontalGap5(),
                                    Text(
                                      data[index].capital![index].toString(),
                                      style: jakartaH4.copyWith(
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const VerticalGap10(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.9,
                        decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(.75),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(2),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Currency',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].currencies!.idr!.name} (${data[index].currencies!.idr!.symbol})',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Region',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].region} (${data[index].subregion})',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Language',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].languages!.ind}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Phone Code',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].idd!.root}${data[index].idd!.suffixes![0]}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Population',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].population}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Lat Lng',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].latlng![0]}, ${data[index].latlng![1]}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Borders',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].borders![0]}, ${data[index].borders![1]}, ${data[index].borders![2]}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            'Timezone',
                                            style: jakartaH4.copyWith(
                                              color: textColor.withOpacity(.75),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 2,
                                          ),
                                          child: Text(
                                            '${data[index].timezones![0]}, ${data[index].timezones![1]}, ${data[index].timezones![2]}',
                                            style: jakartaH4.copyWith(
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalGap10(),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'lib/assets/images/indonesiaMap.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 48,
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
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                      Text(
                        'About',
                        style: jakartaH2.copyWith(
                          color: backgroundColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(.3),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.share_rounded,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: jakartaH4,
              ),
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
}
