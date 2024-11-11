import 'package:flutter/material.dart';
import 'package:freedom_app/const.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customGreen3,
      child: Column(
        children: [
          const SizedBox(height: 100),
          Lottie.asset('assets/1.json'),
          Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [
                Text(
                  "Добро пожаловать в RM.AI!",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Зарегистрируйтесь за секунды и откройте для себя мир профессиональных возможностей с мгновенным доступом к обширной базе данных резюме",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
