import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart'; // Импортируем файл RoundedButton

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите действие'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RoundedButton(
              title: 'Регистрация',
              color: Colors.pinkAccent,
              onPressed: () {
                // Действие при нажатии на кнопку Регистрация
                print('Кнопка Регистрация нажата');
              },
            ),
            SizedBox(height: 20), // Отступ между кнопками
            RoundedButton(
              title: 'Авторизация',
              color: Colors.pinkAccent,
              onPressed: () {
                // Действие при нажатии на кнопку Авторизация
                print('Кнопка Авторизация нажата');
              },
            ),
          ],
        ),
      ),
    );
  }
}
