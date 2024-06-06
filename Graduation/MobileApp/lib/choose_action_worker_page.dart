import 'package:flutter/material.dart';
import 'package:graduation/registration_worker/worker_registration_page.dart';
import 'package:graduation/rounded_button.dart';
import 'Authorization/login_worker_page.dart';
import 'Authorization/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_worker/authorization_page.dart';

class ChooseActionWorkerPage extends StatelessWidget {
  void _navigateToSignupPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => WorkerRegistrationPage()),
    );
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isWorkerLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthorizationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выберите действие'),
        centerTitle: true,
        backgroundColor: Colors.green.shade900, // Цвет AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
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
                    color: Colors.green.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildActionButton(
                context,
                icon: Icons.app_registration,
                title: 'Регистрация',
                onPressed: () => _navigateToSignupPage(context),
              ),
              SizedBox(height: 20),
              _buildActionButton(
                context,
                icon: Icons.login,
                title: 'Авторизация',
                onPressed: () => _navigateToLoginPage(context),
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
        primary: Colors.green.shade900, // Цвет кнопки
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
