import 'package:flutter/material.dart';
import 'package:graduation/Registration/text_form_fields.dart'; // Импортируем созданные нами виджеты
import 'package:graduation/Registration/dropdown_field.dart';
import 'package:graduation/Registration/phone_number_field.dart';
import 'package:graduation/Registration/register_button.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _fullNameController = TextEditingController();
  String? _selectedJob;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset('путь/к/вашему/изображению.png'), // Используйте Image.network если картинка из интернета
              SizedBox(height: 16.0),
              NameField(controller: _fullNameController),
              SizedBox(height: 16.0),
              JobDropdown(
                value: _selectedJob,
                onChanged: (newValue) {
                  setState(() {
                    _selectedJob = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0),
              AddressField(controller: _addressController),
              SizedBox(height: 16.0),
              EmailField(controller: _emailController),
              SizedBox(height: 16.0),
              PhoneNumberField(controller: _phoneNumberController),
              SizedBox(height: 16.0), // добавим дополнительный отступ

              RegisterButton(
                onPressed: () {
                  _registerWorker();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerWorker() {
    // В этом методе вы можете собирать данные с полей ввода и отправлять на сервер или сохранять локально
    String fullName = _fullNameController.text;
    String job = _selectedJob ?? 'Не выбрано';
    String address = _addressController.text;
    String email = _emailController.text;
    String phoneNumber = _phoneNumberController.text;

    // Вывод полученных данных в консоль (для проверки)
    print('ФИО: $fullName');
    print('Тип работы: $job');
    print('Адрес: $address');
    print('Почта: $email');
    print('Номер телефона: $phoneNumber');

    // Очистка полей после регистрации (если необходимо)
    _fullNameController.clear();
    _selectedJob = null;
    _addressController.clear();
    _emailController.clear();
    _phoneNumberController.clear();

    // Переход на другую страницу или выполнение других действий после регистрации
    // Например:
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SomePage()));
  }
}
