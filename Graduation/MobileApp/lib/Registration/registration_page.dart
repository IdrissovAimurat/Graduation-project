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
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patronymicController = TextEditingController(); //отечественная война
  String? _selectedJob;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Создаем переменную для управления отступом
  final double fieldSpacing = 16.0;

  @override
  void dispose() {
    _surnameController.dispose();
    _nameController.dispose();
    _patronymicController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

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
              SizedBox(height: fieldSpacing), // Отступ перед изображением
              Image.asset(
                'assets/images/ui-design.png',
                height: 120,
              ), // Используйте Image.network если картинка из интернета
              SizedBox(height: fieldSpacing), // Отступ после изображения
              SurnameField(controller: _surnameController),
              SizedBox(height: fieldSpacing), // Отступ после изображения
              NameField(controller: _nameController),
              SizedBox(height: fieldSpacing), // Отступ после изображения
              PatronymicField(controller: _patronymicController),

              SizedBox(height: fieldSpacing),
              JobDropdown(
                value: _selectedJob,
                onChanged: (newValue) {
                  setState(() {
                    _selectedJob = newValue;
                  });
                },
              ),
              SizedBox(height: fieldSpacing),
              AddressField(controller: _addressController),
              SizedBox(height: fieldSpacing),
              PhoneNumberField(controller: _phoneNumberController),
              SizedBox(height: fieldSpacing), // добавим дополнительный отступ

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
    String surname = _surnameController.text;
    String name = _nameController.text;
    String patronymic = _patronymicController.text;
    String job = _selectedJob ?? 'Не выбрано';
    String address = _addressController.text;
    String phoneNumber = _phoneNumberController.text;

    // Вывод полученных данных в консоль (для проверки)
    print('Фамилия: $surname');
    print('Имя: $name');
    print('Отчество: $patronymic');
    print('Тип работы: $job');
    print('Адрес: $address');
    //print('Почта: $email');
    print('Номер телефона: $phoneNumber');

    // Очистка полей после регистрации (если необходимо)
    _surnameController.clear();
    _nameController.clear();
    _patronymicController.clear();
    _selectedJob = null;
    _addressController.clear();
    _phoneNumberController.clear();

    // Переход на другую страницу или выполнение других действий после регистрации
    // Например:
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SomePage()));
  }
}
