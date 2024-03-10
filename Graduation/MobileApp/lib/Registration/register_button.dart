import 'package:flutter/material.dart';
import 'package:graduation/Registration/registration_page.dart'; // Импортируем страницу регистрации
import 'package:graduation/rounded_button.dart';
import 'package:graduation/Authorization/login_page.dart'; // Импортируем страницу авторизации

class RegisterButton extends StatelessWidget {
  void _navidageToLoginPage(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }


  final VoidCallback onPressed;

  const RegisterButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => _navidageToLoginPage(context),
      child: Text('Зарегистрироваться'),
    );
  }
}
