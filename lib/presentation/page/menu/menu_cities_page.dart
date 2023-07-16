import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/gap.dart';
import 'package:indoscape/common/typography.dart';

class MenuCitiesPage extends StatefulWidget {
  const MenuCitiesPage({super.key});
  static const routeName = '/menu-cities-page';

  @override
  State<MenuCitiesPage> createState() => _MenuCitiesPageState();
}

class _MenuCitiesPageState extends State<MenuCitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Coming Soon!',
              style: jakartaH2.copyWith(
                color: backgroundColor,
              ),
            ),
            const VerticalGap10(),
            Text(
              'Developer need sleep :(',
              style: jakartaH5.copyWith(
                color: backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
