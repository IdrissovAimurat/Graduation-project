import 'package:flutter/material.dart';
import 'package:graduation/registration_client/client_text_form_fields.dart';
import 'package:graduation/registration_client/client_register_button.dart';
import '../Authorization/login_client_page.dart';
import 'client_address_page.dart';
import 'client_phone_number_field.dart';

// Класс для хранения состояния страницы регистрации
class ClientRegistrationPageState extends ChangeNotifier {
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

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  // Создаем экземпляр класса состояния
  final ClientRegistrationPageState _clientregistrationPageState = ClientRegistrationPageState();

  String address = "";

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
                  icon: Icons.person,
                  label: 'Фамилия',
                  controller: _clientregistrationPageState.surnameController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.person_outline,
                  label: 'Имя',
                  controller: _clientregistrationPageState.nameController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.person_pin,
                  label: 'Отчество',
                  controller: _clientregistrationPageState.patronymicController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.home,
                  label: 'Адрес',
                  controller: TextEditingController(text: address),
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ClientAddressPage(),
                      ),
                    );
                    setState(() {
                      if (result != null) {
                        address = result;
                      }
                    });
                  },
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.phone,
                  label: 'Номер телефона',
                  controller: _clientregistrationPageState.phoneNumberController,
                ),
                SizedBox(height: 16.0),
                _buildRegisterButton(
                  context,
                  title: 'Регистрация',
                  onPressed: _registerClient,
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

  Future<void> _registerClient() async {
    String surname = _clientregistrationPageState.surnameController.text.trim();
    String name = _clientregistrationPageState.nameController.text.trim();
    String patronymic = _clientregistrationPageState.patronymicController.text.trim();
    String phoneNumber = _clientregistrationPageState.phoneNumberController.text.trim();

    if (surname.isNotEmpty && name.isNotEmpty && patronymic.isNotEmpty && address.isNotEmpty && phoneNumber.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginClientPage()));
    } else {
      String emptyField = _getEmptyField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните поле "$emptyField"')),
      );
    }
  }

  String _getEmptyField() {
    if (_clientregistrationPageState.surnameController.text.trim().isEmpty) {
      return 'Фамилия';
    } else if (_clientregistrationPageState.nameController.text.trim().isEmpty) {
      return 'Имя';
    } else if (address.isEmpty) {
      return 'Адрес';
    } else if (_clientregistrationPageState.phoneNumberController.text.trim().isEmpty) {
      return 'Номер телефона';
    } else {
      return '';
    }
  }
}
