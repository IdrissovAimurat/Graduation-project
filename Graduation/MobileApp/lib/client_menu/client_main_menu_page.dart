import 'package:flutter/material.dart';
import 'client_settings_page.dart';
import 'client_support_page.dart';
import 'package:graduation/client_menu/client_requests_page.dart' as client_requests_page;
import 'package:graduation/client_menu/client_new_requests_page.dart' as client_new_requests_page;

class ClientMainMenuPage extends StatefulWidget {
  @override
  _ClientMainMenuPageState createState() => _ClientMainMenuPageState();
}

class _ClientMainMenuPageState extends State<ClientMainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главное меню'),
        centerTitle: true,
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
              title: Text('Поддержка'),
              leading: Icon(Icons.support_agent),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClientSupportPage())),
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

// Примерные классы для страниц, на которые будут осуществляться переходы
// class IncomingRequestsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Входящие заявки"),
//       ),
//       body: Center(child: Text("Здесь будут отображаться входящие заявки")),
//     );
//   }
// }

// class RequestsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Мои заявки"),
//       ),
//       body: Center(child: Text("Здесь будут отображаться мои заявки")),
//     );
//   }
// }

// class SupportPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Поддержка"),
//       ),
//       body: Center(child: Text("Здесь будет информация о поддержке")),
//     );
//   }
// }


