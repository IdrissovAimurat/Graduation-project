import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'support_page.dart';
import 'requests_page.dart';
import 'new_requests_page.dart'; // Убедитесь, что вы импортируете правильный файл

class MainMenuPage extends StatefulWidget {
  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное меню'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Убирает кнопку назад
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          _buildMenuCard(
            title: 'Входящие заявки',
            icon: Icons.input,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewRequestsPage())), // Убедитесь, что используете правильный класс
          ),
          _buildMenuCard(
            title: 'Мои заявки',
            icon: Icons.work,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => RequestsPage())),
          ),
          _buildMenuCard(
            title: 'Поддержка',
            icon: Icons.support_agent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportPage())),
          ),
          _buildMenuCard(
            title: 'Настройки',
            icon: Icons.settings,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage())),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}
