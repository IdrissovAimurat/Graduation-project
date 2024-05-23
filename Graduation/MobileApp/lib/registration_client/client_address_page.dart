import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientAddressPage extends StatefulWidget {
  @override
  _ClientAddressPageState createState() => _ClientAddressPageState();
}

class _ClientAddressPageState extends State<ClientAddressPage> {
  // Контроллеры для каждого текстового поля
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController apartmentNumberController = TextEditingController();

  String? selectedCountry;
  String? selectedRegion;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedMicrodistrict;
  String? selectedStreet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Адрес'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Введите данные адреса',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: idNumberController,
                    decoration: InputDecoration(
                      labelText: 'Индивидуальный идентификационный номер удостоверения',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedCountry,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCountry = newValue;
                      });
                    },
                    items: ['Казахстан', 'Кыргызстан', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Страна',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedRegion,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRegion = newValue;
                      });
                    },
                    items: ['Алматинская', 'Атырауская', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Область',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedCity,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCity = newValue;
                      });
                    },
                    items: ['Алматы', 'Атырау', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Город',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedDistrict,
                    onChanged: (newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                      });
                    },
                    items: ['Бостандыкский', 'Медеуский', 'Наурызбайский', 'Турксибский', 'Алмалинский', 'Жетысуский', 'Алатауский', 'Ауэзовский', 'Медеуский', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Район',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedMicrodistrict,
                    onChanged: (newValue) {
                      setState(() {
                        selectedMicrodistrict = newValue;
                      });
                    },
                    items: ['Таугуль', 'Коктем', 'Самал', 'Казахфильм', 'Аксай', 'Сайран', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Микрорайон',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedStreet,
                    onChanged: (newValue) {
                      setState(() {
                        selectedStreet = newValue;
                      });
                    },
                    items: ['Сейфуллина', 'Байтурсынова', 'Наурызбай батыра', 'Кабанбай батыра', 'Богенбай батыра', 'Сатпаева', 'Абая', 'Проспект Назарбаева', 'Толе би', 'Жандосова', 'Торекулова', 'Не выбрано'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Улица',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: streetNumberController,
                    decoration: InputDecoration(
                      labelText: 'Номер улицы',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: houseNumberController,
                    decoration: InputDecoration(
                      labelText: 'Номер дома',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: apartmentNumberController,
                    decoration: InputDecoration(
                      labelText: 'Номер квартиры',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      // Save address and go back to registration page
                      String fullAddress = '${selectedCountry ?? ''}, ${selectedRegion ?? ''}, ${selectedCity ?? ''}, ${selectedDistrict ?? ''}, ${selectedMicrodistrict ?? ''}, ${selectedStreet ?? ''}, ${houseNumberController.text}, ${apartmentNumberController.text}';
                      Navigator.of(context).pop(fullAddress);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
