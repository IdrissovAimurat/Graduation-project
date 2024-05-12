import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import '../Registration/registration_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToRegistration(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => RegistrationPage()),
      );
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
        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Почта',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите вашу почту';
                    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                      return 'Введите корректный адрес электронной почты';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите ваш пароль';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              RoundedButton(
                title: 'Далее',
                color: Theme.of(context).primaryColor,
                onPressed: () => _navigateToRegistration(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
