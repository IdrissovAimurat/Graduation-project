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
          title: Text('Адрес'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade900, // Цвет AppBar
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
                        color: Colors.teal.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: idNumberController,
                      decoration: InputDecoration(
                        labelText: 'Индивидуальный идентификационный номер удостоверения',
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
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: streetNumberController,
                      decoration: InputDecoration(
                        labelText: 'Номер улицы',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: houseNumberController,
                      decoration: InputDecoration(
                        labelText: 'Номер дома',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: apartmentNumberController,
                      decoration: InputDecoration(
                        labelText: 'Номер квартиры',
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
                        primary: Colors.teal.shade900, // Цвет кнопки
                        onPrimary: Colors.white, // Цвет текста кнопки
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
      ),
    );
  }
}
