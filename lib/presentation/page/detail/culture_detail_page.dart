import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';

import '../../../common/gap.dart';

class DetailCulturePage extends StatefulWidget {
  const DetailCulturePage({super.key, required this.id});
  static const routeName = '/detail_culture_page';
  final int id;

  @override
  State<DetailCulturePage> createState() => _DetailCulturePageState();
}

class _DetailCulturePageState extends State<DetailCulturePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository().getCultureList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: textColor,
                ),
              ),
              centerTitle: true,
              title: Text(
                data![widget.id - 1].name.toString(),
                style: jakartaH3.copyWith(color: textColor),
              ),
              elevation: 0,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(
                            data[widget.id - 1].imageUrl.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const VerticalGap10(),
                    Text(
                      data[widget.id].type.toString(),
                      style: jakartaH4.copyWith(color: textColor),
                    ),
                    const VerticalGap10(),
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          color: primaryColor,
                        ),
                        const HorizontalGap5(),
                        Text(
                          data[widget.id - 1].origin.toString(),
                          style: jakartaButton.copyWith(color: textColor),
                        ),
                      ],
                    ),
                    const VerticalGap10(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const HorizontalGap5(),
                        itemCount: data[widget.id - 1].tags!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: primaryColor,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Center(
                              child: Text(
                                data[widget.id - 1].tags![index].toString(),
                                style: jakartaH4.copyWith(
                                  color: backgroundColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const VerticalGap10(),
                    Text(
                      data[widget.id - 1].description.toString(),
                      style: jakartaButton.copyWith(color: textColor),
                    ),
                    const VerticalGap10(),
                    Text(
                      'History ${data[widget.id - 1].name.toString()}',
                      style: jakartaH4.copyWith(color: textColor),
                    ),
                    const VerticalGap10(),
                    Text(
                      data[widget.id - 1].history.toString(),
                      style: jakartaButton.copyWith(color: textColor),
                    ),
                    const VerticalGap10(),
                    Text(
                      'Other Culture',
                      style: jakartaH4.copyWith(color: textColor),
                    ),
                    const VerticalGap10(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const HorizontalGap5(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                DetailCulturePage.routeName,
                                arguments: data[index].id,
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(
                                    data[index].imageUrl.toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
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
