import 'package:flutter/material.dart';
import 'package:graduation/Registration/text_form_fields.dart';
import 'package:graduation/Registration/dropdown_field.dart';
import 'package:graduation/Registration/phone_number_field.dart';
import 'package:graduation/Registration/register_button.dart';
import '../Authorization/login_client_page.dart';

// Класс для хранения состояния страницы регистрации
class ClientRegistrationPageState extends ChangeNotifier {
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

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  // Создаем экземпляр класса состояния
  final ClientRegistrationPageState _clientregistrationPageState = ClientRegistrationPageState();

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
                controller: _clientregistrationPageState.surnameController,
              ),
              SizedBox(height: 16.0),
              NameField(
                controller: _clientregistrationPageState.nameController,
              ),
              SizedBox(height: 16.0),
              PatronymicField(
                controller: _clientregistrationPageState.patronymicController,
              ),
              SizedBox(height: 16.0),
              JobDropdown(
                value: _clientregistrationPageState.selectedJob,
                onChanged: (newValue) {
                  setState(() {
                    _clientregistrationPageState.selectedJob = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0),
              AddressField(
                controller: _clientregistrationPageState.addressController,
              ),
              SizedBox(height: 16.0),
              PhoneNumberField(
                controller: _clientregistrationPageState.phoneNumberController,
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
    String surname = _clientregistrationPageState.surnameController.text.trim();
    String name = _clientregistrationPageState.nameController.text.trim();
    String patronymic = _clientregistrationPageState.patronymicController.text.trim();
    String job = _clientregistrationPageState.selectedJob ?? 'Не выбрано';
    String address = _clientregistrationPageState.addressController.text.trim();
    String phoneNumber = _clientregistrationPageState.phoneNumberController.text.trim();

    if (surname.isNotEmpty && name.isNotEmpty && patronymic.isNotEmpty &&
        job != 'Не выбрано' && address.isNotEmpty && phoneNumber.isNotEmpty) {
      // Все поля заполнены, выполняем регистрацию и переход на страницу входа
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginClientPage()));
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
    if (_clientregistrationPageState.surnameController.text.trim().isEmpty) {
      return 'Фамилия';
    } else if (_clientregistrationPageState.nameController.text.trim().isEmpty) {
      return 'Имя';
    } else if (_clientregistrationPageState.selectedJob == null ||
        _clientregistrationPageState.selectedJob == 'Не выбрано') {
      return 'Тип работы';
    } else if (_clientregistrationPageState.addressController.text.trim().isEmpty) {
      return 'Адрес';
    } else if (_clientregistrationPageState.phoneNumberController.text.trim().isEmpty) {
      return 'Номер телефона';
    } else {
      return ''; // Если все поля заполнены, возвращаем пустую строку
    }
  }

}
