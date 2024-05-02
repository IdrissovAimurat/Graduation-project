import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import '../Registration/registration_page.dart';

class LoginPage extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void _navigateToRegistration(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RegistrationPage()),
    );
  }

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
                'Введите Ваши почту и пароль, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Почта',
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
              color: Theme.of(context).primaryColor, // Использование primaryColor из темы
              onPressed: () => _navigateToRegistration(context),
            ),
          ],
        ),
      ),
    );
  }
}
