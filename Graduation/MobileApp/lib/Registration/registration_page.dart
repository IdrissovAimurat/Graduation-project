import 'package:flutter/material.dart';
import 'package:graduation/Registration/text_form_fields.dart';
import 'package:graduation/Registration/dropdown_field.dart';
import 'package:graduation/Registration/phone_number_field.dart';
import 'package:graduation/Registration/register_button.dart';
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
              SurnameField(
                controller: _registrationPageState.surnameController,
              ),
              SizedBox(height: 16.0),
              NameField(
                controller: _registrationPageState.nameController,
              ),
              SizedBox(height: 16.0),
              PatronymicField(
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
              AddressField(
                controller: _registrationPageState.addressController,
              ),
              SizedBox(height: 16.0),
              PhoneNumberField(
                controller: _registrationPageState.phoneNumberController,
              ),
              SizedBox(height: 16.0),
              RegisterButton(
                onPressed: _registerWorker,
              ),
            ],
          ),
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
