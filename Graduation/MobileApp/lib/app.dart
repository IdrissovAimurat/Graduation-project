import 'package:flutter/material.dart';
import 'package:graduation/authorization_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Authorization Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.red.shade700, // Цвет AppBar
        ),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthorizationPage(),
    );
  }
}
