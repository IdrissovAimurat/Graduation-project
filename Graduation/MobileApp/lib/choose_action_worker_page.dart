import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import 'Authorization/login_page.dart';
import 'Authorization/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_worker/authorization_page.dart';


class ChooseActionWorkerPage extends StatelessWidget {
  void _navigateToSignupPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignupPage()),
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Здравствуйте, Авторизуйтесь, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            RoundedButton(
              title: 'Регистрация',
              color: Theme.of(context).primaryColor,
              onPressed: () => _navigateToSignupPage(context),
            ),
            SizedBox(height: 20),
            RoundedButton(
              title: 'Авторизация',
              color: Theme.of(context).primaryColor,
              onPressed: () => _navigateToLoginPage(context),
            ),
          ],
        ),
      ),
    );
  }
}
