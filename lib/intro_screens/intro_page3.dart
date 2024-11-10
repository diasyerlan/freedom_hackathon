import 'package:flutter/material.dart';
import 'package:freedom_app/const.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: customGreen3,
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Lottie.asset('assets/3.json'),
          Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [
                Text(
                  "Умные рекомендации по найму",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Наш интеллектуальный помощник научит вас понимать, какие навыки важны для различных должностей, помогая вам делать обоснованные решения о найме",
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
