// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:graduation/Authorization/login_client_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_worker/authorization_page.dart';
import '../registration_client/client_registration_page.dart';

class ClientChooseActionPage extends StatelessWidget {
  void _navigateToClientRegistrationPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ClientRegistrationPage()),
    );
  }

  void _navigateToLoginClientPage(BuildContext context) {
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
        backgroundColor: Colors.teal, // Цвет AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Добавление отступов
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Здравствуйте, авторизуйтесь, пожалуйста',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildActionButton(
                context,
                icon: Icons.app_registration,
                title: 'Регистрация',
                onPressed: () => _navigateToClientRegistrationPage(context),
              ),
              SizedBox(height: 20),
              _buildActionButton(
                context,
                icon: Icons.login,
                title: 'Авторизация',
                onPressed: () => _navigateToLoginClientPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String title, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white), // Иконка
      label: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal, // Цвет кнопки
        onPrimary: Colors.white, // Цвет текста
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Закругленные углы
        ),
        elevation: 5, // Тень кнопки
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Размеры кнопки
      ),
    );
  }
}

void _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isWorkerLoggedIn');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => AuthorizationPage()),
  );
}
