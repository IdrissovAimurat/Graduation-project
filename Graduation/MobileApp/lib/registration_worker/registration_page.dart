import 'package:flutter/material.dart';
import 'package:graduation/registration_worker/text_form_fields.dart';
import 'package:graduation/registration_worker/dropdown_field.dart';
import 'package:graduation/registration_worker/phone_number_field.dart';
import 'package:graduation/registration_worker/register_button.dart';
import 'package:graduation/Authorization/login_page.dart';

// Класс для хранения состояния страницы регистрации
class RegistrationPageState extends ChangeNotifier {
  // Контроллеры для каждого текстового поля
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController patronymicController = TextEditingController();
  String? selectedJob;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Метод для очистки контроллеров при диспозе страницы
  @override
  void dispose() {
    surnameController.dispose();
    nameController.dispose();
    patronymicController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Создаем экземпляр класса состояния
  final RegistrationPageState _registrationPageState = RegistrationPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заполните данные'),
        centerTitle: true,
        backgroundColor: Color(0xFFA40606), // Цвет AppBar
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
                controller: _registrationPageState.surnameController,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                context,
                icon: Icons.person_outline,
                label: 'Имя',
                controller: _registrationPageState.nameController,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                context,
                icon: Icons.person_pin,
                label: 'Отчество',
                controller: _registrationPageState.patronymicController,
              ),
              SizedBox(height: 16.0),
              JobDropdown(
                value: _registrationPageState.selectedJob,
                onChanged: (newValue) {
                  setState(() {
                    _registrationPageState.selectedJob = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                context,
                icon: Icons.home,
                label: 'Адрес',
                controller: _registrationPageState.addressController,
              ),
              SizedBox(height: 16.0),
              _buildTextField(
                context,
                icon: Icons.phone,
                label: 'Номер телефона',
                controller: _registrationPageState.phoneNumberController,
              ),
              SizedBox(height: 16.0),
              _buildRegisterButton(
                context,
                title: 'Зарегистрироваться',
                onPressed: _registerWorker,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required IconData icon, required String label, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFA40606)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFFA40606), // Цвет кнопки
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

  void _registerWorker() {
    String surname = _registrationPageState.surnameController.text.trim();
    String name = _registrationPageState.nameController.text.trim();
    String patronymic = _registrationPageState.patronymicController.text.trim();
    String job = _registrationPageState.selectedJob ?? 'Не выбрано';
    String address = _registrationPageState.addressController.text.trim();
    String phoneNumber = _registrationPageState.phoneNumberController.text.trim();

    if (surname.isNotEmpty && name.isNotEmpty && patronymic.isNotEmpty &&
        job != 'Не выбрано' && address.isNotEmpty && phoneNumber.isNotEmpty) {
      // Все поля заполнены, выполняем регистрацию и переход на страницу входа
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      // Если какое-то поле пустое, показываем уведомление
      String emptyField = _getEmptyField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните поле "$emptyField"')),
      );
    }
  }

  // Функция для определения первого пустого поля
  String _getEmptyField() {
    if (_registrationPageState.surnameController.text.trim().isEmpty) {
      return 'Фамилия';
    } else if (_registrationPageState.nameController.text.trim().isEmpty) {
      return 'Имя';
    } else if (_registrationPageState.selectedJob == null ||
        _registrationPageState.selectedJob == 'Не выбрано') {
      return 'Тип работы';
    } else if (_registrationPageState.addressController.text.trim().isEmpty) {
      return 'Адрес';
    } else if (_registrationPageState.phoneNumberController.text.trim().isEmpty) {
      return 'Номер телефона';
    } else {
      return ''; // Если все поля заполнены, возвращаем пустую строку
    }
  }
}
