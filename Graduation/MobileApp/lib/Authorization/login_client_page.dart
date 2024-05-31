import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation/Api/http_client.dart';
import 'package:graduation/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/endpoints.dart';
import '../client_menu/client_main_menu_page.dart';

class LoginClientPage extends StatefulWidget {
  @override
  _LoginClientPageState createState() => _LoginClientPageState();
}

class _LoginClientPageState extends State<LoginClientPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
    });
  }

  void _saveUserData(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('isLoggedIn', true);
  }

    Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccess = false;
      var client = HttpService();
      var data = {
        'email' : _emailController.text,
        'password': _passwordController.text
      };
      loginSuccess = await client.authorization(data);

      if (loginSuccess) {
        _saveUserData(_emailController.text, _passwordController.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ClientMainMenuPage()),
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
        title: Text('Вход'),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Почта',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
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
