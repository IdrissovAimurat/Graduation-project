import 'package:flutter/material.dart';
import 'package:graduation/client_menu/client_consider_request_page.dart' as client_consider_request_page;
import '../auth_worker/authorization_page.dart';
import 'client_settings_page.dart';
import 'client_support_page.dart';
import 'package:graduation/client_menu/client_requests_page.dart' as client_requests_page;
import 'package:graduation/client_menu/client_new_requests_page.dart' as client_new_requests_page;
import 'package:shared_preferences/shared_preferences.dart';

class ClientMainMenuPage extends StatefulWidget {
  @override
  _ClientMainMenuPageState createState() => _ClientMainMenuPageState();
}

class _ClientMainMenuPageState extends State<ClientMainMenuPage> {
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isClientLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthorizationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное меню'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false, // Убирает кнопку назад
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          _buildMenuCard(
            title: 'Создать заявку',
            icon: Icons.input,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_new_requests_page.ClientNewRequestsPage())),
          ),
          _buildMenuCard(
            title: 'Мои заявки',
            icon: Icons.work,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_requests_page.ClientRequestsPage())),
          ),
          _buildMenuCard(
            title: 'Заявки на рассмотрении',
            icon: Icons.pending,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_consider_request_page.ClientConsiderRequestPage())),
          ),
          _buildMenuCard(
            title: 'Поддержка',
            icon: Icons.support_agent,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientSupportPage())),
          ),
          _buildMenuCard(
            title: 'Настройки',
            icon: Icons.settings,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientSettingsPage())),
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
