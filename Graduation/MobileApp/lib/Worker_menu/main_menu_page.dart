import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'support_page.dart';
import 'package:graduation/Worker_menu/requests_page.dart' as requests_page;
import 'package:graduation/Worker_menu/new_requests_page.dart' as new_requests_page;

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
        automaticallyImplyLeading: false, // Убирает кнопку назад
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('Входящие заявки'),
              leading: Icon(Icons.input),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => new_requests_page.NewRequestsPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Мои заявки'),
              leading: Icon(Icons.work),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => requests_page.RequestsPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Поддержка'),
              leading: Icon(Icons.support_agent),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportPage())),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Настройки'),
              leading: Icon(Icons.settings),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage())),
            ),
          ),
        ],
      ),
    );
  }
}
