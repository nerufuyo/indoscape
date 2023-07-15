import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () {
    //     Navigator.pushReplacementNamed(context, NavigationWidget.routeName);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'INDOSCAPE',
          body: 'Aplikasi yang menyajikan informasi seputar Indonesia',
          image: Image.asset('assets/images/logo.png'),
        ),
        PageViewModel(
          title: 'INDOSCAPE',
          body: 'Aplikasi yang menyajikan informasi seputar Indonesia',
          image: Image.asset('assets/images/logo.png'),
        ),
        PageViewModel(
          title: 'INDOSCAPE',
          body: 'Aplikasi yang menyajikan informasi seputar Indonesia',
          image: Image.asset('assets/images/logo.png'),
        ),
      ],
      onDone: () {
        Navigator.pushReplacementNamed(context, NavigationWidget.routeName);
      },
      onSkip: () {
        Navigator.pushReplacementNamed(context, NavigationWidget.routeName);
      },
      showSkipButton: true,
      skip: const Text('Lewati'),
      next: const Text('Selanjutnya'),
      done: const Text('Selesai'),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.blue,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
