import 'package:flutter/material.dart';
import 'package:freedom_app/const.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: customGreen3,
      child: Column(
        children: [
          SizedBox(height: 100),
          Lottie.asset('assets/1.json'),
          Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              children: [
                Text(
                  "Добро пожаловать в RM.AI!",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
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
