import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_client/choose_action_client_page.dart';
import '../choose_action_worker_page.dart';
//import 'choose_action_worker_page.dart'; // для работника
import 'package:graduation/client_menu/client_main_menu_page.dart'; // для клиента

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
        title: Text('Authorization'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginAsWorker,
              child: Text('Login as Worker'),
            ),
            ElevatedButton(
              onPressed: _loginAsClient,
              child: Text('Login as Client'),
            ),
          ],
        ),
      ),
    );
  }
}
