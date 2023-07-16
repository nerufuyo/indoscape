import 'package:flutter/material.dart';
import 'package:indoscape/common/color.dart';
import 'package:indoscape/common/typography.dart';
import 'package:indoscape/presentation/widget/navigation_widget.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);
  static const routeName = '/introduction';

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'LOOKING FOR INDONESIA?',
          body: 'This app will help you to find information about Indonesia',
          image: Image.asset('lib/assets/images/intro1.jpg'),
        ),
        PageViewModel(
          title: 'HAVE ATTENTION TO INDONESIA?',
          body:
              'In this app, you can find information about everything in Indonesia',
          image: Image.asset('lib/assets/images/intro2.jpg'),
        ),
        PageViewModel(
          title: 'COME AND JOIN US!',
          body: 'Let\'s explore Indonesia with us!',
          image: Image.asset('lib/assets/images/intro3.jpg'),
        ),
      ],
      onDone: () {
        Navigator.pushReplacementNamed(context, NavigationWidget.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, NavigationWidget.routeName);
      },
      showSkipButton: true,
      skip: Text(
        'Lewati',
        style: jakartaH4.copyWith(
          color: primaryColor,
        ),
      ),
      next: Text(
        'Selanjutnya',
        style: jakartaH4.copyWith(
          color: primaryColor,
        ),
      ),
      done: Text(
        'Selesai',
        style: jakartaH4.copyWith(
          color: primaryColor,
        ),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: primaryColor,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
