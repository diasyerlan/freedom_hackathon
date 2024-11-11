import 'package:flutter/material.dart';
import 'package:freedom_app/auth/auth.dart';
import 'package:freedom_app/const.dart';
import 'package:freedom_app/intro_screens/intro_page1.dart';
import 'package:freedom_app/intro_screens/intro_page2.dart';
import 'package:freedom_app/intro_screens/intro_page3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import this package

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [IntroPage1(), IntroPage2(), IntroPage3()],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(activeDotColor: customGreen2),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !onLastPage ?
                GestureDetector(
                    onTap: () async {
                      await _storeOnboardInfo();
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                       'Пропустить',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )) : const SizedBox(),
                    SizedBox(width: !onLastPage ? 150: 0,),
                onLastPage
                    ? GestureDetector(
                        onTap: () async {
                          await _storeOnboardInfo();
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const AuthPage();
                          }));
                        },
                        child: Text('Начать!',
                            style: Theme.of(context).textTheme.bodyLarge))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Далее',
                            style: Theme.of(context).textTheme.bodyLarge))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
