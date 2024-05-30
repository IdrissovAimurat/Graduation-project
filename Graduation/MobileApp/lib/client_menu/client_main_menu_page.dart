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
  // void _logout(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('isClientLoggedIn');
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => AuthorizationPage()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное меню'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Убирает кнопку назад
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () => _logout(context),
          // ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Создать заявку'),
              leading: Icon(Icons.input),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_new_requests_page.ClientNewRequestsPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Мои заявки'),
              leading: Icon(Icons.work),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_requests_page.ClientRequestsPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Заявки на рассмотрении'),
              leading: Icon(Icons.work),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => client_consider_request_page.ClientConsiderRequestPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Поддержка'),
              leading: Icon(Icons.support_agent),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientSupportPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Настройки'),
              leading: Icon(Icons.settings),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientSettingsPage())),
            ),
          ),
        ],
      ),
    );
  }
}
