import 'package:flutter/material.dart';
import 'package:graduation/authorization_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientSettingsPage extends StatelessWidget {
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Очистка сохраненных данных

    // Используем Future.delayed, чтобы дать время для очистки данных
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthorizationPage()),
            (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Настройки"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Версия приложения: 1.0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Выйти из аккаунта'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,  // Красный цвет для кнопки выхода
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
