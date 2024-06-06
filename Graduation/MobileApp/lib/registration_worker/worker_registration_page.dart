import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graduation/registration_worker/worker_registration_page_info.dart';
import '../Api/http_client.dart';
import '../models/client_registration_models.dart';

// Класс для хранения состояния страницы регистрации
class WorkerRegistrationPageState extends ChangeNotifier {
  // Контроллеры для каждого текстового поля
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController patronymicController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Метод для очистки контроллеров при диспозе страницы
  @override
  void dispose() {
    surnameController.dispose();
    nameController.dispose();
    patronymicController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

class WorkerRegistrationPage extends StatefulWidget {
  @override
  _WorkerRegistrationPageState createState() => _WorkerRegistrationPageState();
}

class _WorkerRegistrationPageState extends State<WorkerRegistrationPage> {
  // Создаем экземпляр класса состояния
  final WorkerRegistrationPage _workerregistrationPageState = WorkerRegistrationPage();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userRoleNameController = TextEditingController();
  String address = "";
  Future<void> _submitRequest() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final newRequest = ClientRegistrationRequest(
        userName: "test",
        email: emailController.text,
        password: passwordController.text,
        userRoleName: "worker",
      );
      try {
        var client = HttpService();
        final result = await client.createUser(newRequest);
        print('User created: $result');
        _navigateToConfirmationPage();
        var userId = result['userId'];
        print('userId $userId');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkerRegistrationPageInfo(userId: userId)),
        );
      } catch (e) {
        print('Failed to create user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при создании пользователя: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
    }
  }

  void _navigateToConfirmationPage(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WorkerRegistrationPage())
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal.shade900,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.teal.shade900),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Заполните данные'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade900, // Цвет AppBar
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 16.0),
                Image.asset(
                  'assets/images/ui-design.png',
                  height: 120,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.g_mobiledata,
                  label: 'email',
                  controller: emailController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.password,
                  label: 'Пароль',
                  controller: passwordController,
                ),
                SizedBox(height: 16.0),
                _buildRegisterButton(
                  context,
                  title: 'Регистрация',
                  onPressed: _submitRequest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required IconData icon, required String label, required TextEditingController controller, VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal.shade900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildRegisterButton(BuildContext context, {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.teal.shade900, // Цвет кнопки
        onPrimary: Colors.white, // Цвет текста
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Закругленные углы
        ),
        elevation: 5, // Тень кнопки
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Размеры кнопки
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

