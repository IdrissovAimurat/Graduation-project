import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import '../Registration/registration_page.dart';  // Используйте нужный экран для перехода после успешного логина

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Имитация проверки логина и пароля (здесь должен быть запрос к серверу или локальная проверка)
      bool loginSuccess = true;  // Предположим, что данные корректны
      if (loginSuccess) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => RegistrationPage()), // Сменить на страницу после логина
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Неверный логин или пароль')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните форму корректно')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Логин'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 80),
                Image.asset('assets/images/registrationIcon.png', height: 120),
                SizedBox(height: 40),
                Text(
                  'Добро пожаловать!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'Логин',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите ваш логин';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите ваш пароль';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                RoundedButton(
                  title: 'ВОЙТИ',
                  color: Theme.of(context).primaryColor,
                  onPressed: _login,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
