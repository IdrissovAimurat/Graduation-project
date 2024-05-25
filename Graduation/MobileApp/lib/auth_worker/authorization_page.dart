import 'package:flutter/material.dart';
import 'package:graduation/rounded_button.dart';
import 'package:graduation/choose_action_page.dart';
import '../auth_client/choose_action_client_page.dart';

class AuthorizationPage extends StatelessWidget {
  void _navigateToChooseActionWorker(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ChooseActionPage()),
    );
  }
  void _navigateToChooseActionClient(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => ClientChooseActionPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добро пожаловать'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Авторизуйтесь, пожалуйста',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            RoundedButton(
              title: 'Работник',
              color: Theme.of(context).primaryColor,
              onPressed: () => _navigateToChooseActionWorker(context),
            ),
            SizedBox(height: 20),
            RoundedButton(
              title: 'Клиент',
              color: Theme.of(context).primaryColor,
              onPressed: () => _navigateToChooseActionClient(context),
            ),
          ],
        ),
      ),
    );
  }
}
