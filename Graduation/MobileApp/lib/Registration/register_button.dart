import 'package:flutter/material.dart';
import 'package:graduation/Authorization/login_page.dart';
import 'package:graduation/Authorization/signup_page.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool navigateToLoginPage;

  const RegisterButton({
    Key? key,
    this.onPressed,
    this.navigateToLoginPage = true, // Устанавливаем значение по умолчанию в true
  }) : super(key: key);

  void onPress(BuildContext context) {
    if (navigateToLoginPage) {
      _navigateToLoginPage(context);
    } else {
      onPressed?.call();
    }
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPress(context),
      child: const Text('Зарегистрироваться'),
    );
  }
}