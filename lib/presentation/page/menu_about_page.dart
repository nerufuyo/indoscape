import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
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
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      secondaryColor,
                      tertiaryColor,
                    ],
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.25,
                maxChildSize: 1,
                builder: (context, scrollController) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          width: 64,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                          color: backgroundColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                    const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: backgroundColor.withOpacity(.5),
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
        },
      ),
    );
  }
}
