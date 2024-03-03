import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import 'package:graduation/choose_action_page.dart';

class AuthorizationPage extends StatelessWidget {
  void _navigateToRegistration(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ChooseActionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добро пожаловать'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Авторизуйтесь, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            RoundedButton(
              title: 'Работник',
              color: Colors.pinkAccent,
              onPressed: () => _navigateToRegistration(context), // Изменение обработчика события
            ),
            SizedBox(height: 20), // Отступ между кнопками
            RoundedButton(
              title: 'Клиент',
              color: Colors.pinkAccent,
              onPressed: () {
                // Обработчик события для кнопки Клиент
                print('Кнопка Клиент нажата');
              },
            ),
          ],
        ),
      ),
    );
  }
}
