// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import 'package:graduation/Authorization/signup_client_page.dart';
import 'package:graduation/Authorization/login_client_page.dart';

class ChooseActionPage extends StatelessWidget {
  void _navigateToSignupClientPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignupClientPage()),

    );
  }
  void _navigateToLoginClientPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginClientPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите действие'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Здравствуйте, Авторизуйтесь, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            RoundedButton(
              title: 'Регистрация',
              color: Theme.of(context).primaryColor, // Использование primaryColor из темы
              onPressed: () => _navigateToSignupClientPage(context), // Изменение обработчика события
            ),
            SizedBox(height: 20), // Отступ между кнопками
            RoundedButton(
              title: 'Авторизация',
              color: Theme.of(context).primaryColor, // Использование primaryColor из темы
              onPressed: () => _navigateToLoginClientPage(context), // Изменение обработчика события
              // Обработчик события для кнопки Клиент,
            ),
          ],
        ),
      ),
    );
  }
}
