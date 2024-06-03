import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_client/choose_action_client_page.dart';
import '../choose_action_worker_page.dart';
import 'package:graduation/client_menu/client_main_menu_page.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginAsWorker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isWorkerLoggedIn', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChooseActionWorkerPage()),
    );
  }

  void _loginAsClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isClientLoggedIn', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ClientChooseActionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Авторизация'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Выберите тип авторизации',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAuthButton(
                  context,
                  icon: Icons.work,
                  title: 'Сотрудник',
                  onTap: _loginAsWorker,
                ),
                _buildAuthButton(
                  context,
                  icon: Icons.person,
                  title: 'Клиент',
                  onTap: _loginAsClient,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white), // Иконка
      label: Text(
        title,
        style: TextStyle(
          fontSize: 18, // Размер шрифта
          fontWeight: FontWeight.bold, // Жирный шрифт
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.teal, // Цвет кнопки
        onPrimary: Colors.white, // Цвет текста
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Закругленные углы
        ),
        elevation: 5, // Тень кнопки
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Размеры кнопки
      ),
    );
  }
}
