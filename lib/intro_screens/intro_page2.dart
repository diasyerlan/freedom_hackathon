import 'package:flutter/material.dart';
import 'package:freedom_app/const.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: customGreen3,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Lottie.asset('assets/2.json'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Находите идеальных кандидатов быстро",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Используйте наши продвинутые фильтры для поиска по специальности, навыкам и опыту работы. Обеспечьте себе доступ к резюме специалистов из любой области",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
