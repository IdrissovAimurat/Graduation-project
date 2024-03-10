import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import 'package:graduation/choose_action_page.dart';
import 'package:graduation/Registration/register_button.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Введите Ваши логин и пароль, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  labelText: 'Логин',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20), // Отступ между полями ввода
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20), // Отступ между полем ввода пароля и кнопкой
            RoundedButton(
              title: 'Войти',
              color: Colors.pink,
              onPressed: () {
                String login = _loginController.text;
                String password = _passwordController.text;
                // Дальнейшие действия при нажатии на кнопку входа
                print('Логин: $login, Пароль: $password');
              },
            ),
          ],
        ),
      ),
    );
  }
}
