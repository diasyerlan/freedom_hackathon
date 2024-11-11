import 'package:flutter/material.dart';
import 'package:freedom_app/const.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: customGreen3,
        child: Column(
          children: [
            const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
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
