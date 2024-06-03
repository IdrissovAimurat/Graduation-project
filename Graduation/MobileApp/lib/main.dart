import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Worker_menu/main_menu_page.dart';
import 'choose_action_worker_page.dart'; // для работника
import 'package:graduation/client_menu/client_main_menu_page.dart'; // для клиента
import 'auth_worker/authorization_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isWorkerLoggedIn = prefs.getBool('isWorkerLoggedIn') ?? false;
  bool isClientLoggedIn = prefs.getBool('isClientLoggedIn') ?? false;

  runApp(MyApp(isWorkerLoggedIn: isWorkerLoggedIn, isClientLoggedIn: isClientLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isWorkerLoggedIn;
  final bool isClientLoggedIn;

  MyApp({required this.isWorkerLoggedIn, required this.isClientLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isWorkerLoggedIn
          ? MainMenuPage()
          : isClientLoggedIn
          ? ClientMainMenuPage()
          : AuthorizationPage(),
    );
  }
}
