import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/data/repositories/repository.dart';
import 'package:indoscape/presentation/page/detail/culture_detail_page.dart';

class MenuCulturePage extends StatefulWidget {
  const MenuCulturePage({Key? key}) : super(key: key);
  static const routeName = '/menu_culture_page';

  @override
  State<MenuCulturePage> createState() => _MenuCulturePageState();
}

class _MenuCulturePageState extends State<MenuCulturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          'Culture',
          style: jakartaH3,
        ),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: Repository().getCultureList(),
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
                  final culutre = data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailCulturePage.routeName,
                        arguments: culutre.id,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: textColor.withOpacity(.25),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(culutre.imageUrl.toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    culutre.type.toString(),
                                    style: jakartaH4.copyWith(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const VerticalGap10(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Text(
                                  culutre.name.toString(),
                                  style: jakartaH3.copyWith(
                                    color: textColor,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.pin_drop_outlined,
                                        color: textColor,
                                        size: 20,
                                      ),
                                      const HorizontalGap5(),
                                      Text(
                                        culutre.origin.toString(),
                                        style: jakartaCaption.copyWith(
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const VerticalGap10(),
                          Text(
                            culutre.description.toString(),
                            style: jakartaButton.copyWith(
                              color: textColor,
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
            return Center(
              child: Text(snapshot.error.toString()),
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
