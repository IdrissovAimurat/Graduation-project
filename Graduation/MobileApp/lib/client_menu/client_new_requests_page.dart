import 'package:flutter/material.dart';
import 'package:graduation/Api/http_client.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/client_models.dart';
import 'client_consider_request_page.dart';

class ClientNewRequestsPage extends StatefulWidget {
  @override
  _ClientNewRequestsPageState createState() => _ClientNewRequestsPageState();
}

class _ClientNewRequestsPageState extends State<ClientNewRequestsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController apartmentNumberController = TextEditingController();
  File? _image;

  String? selectedCountry;
  String? selectedRegion;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedMicrodistrict;
  String? selectedStreet;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitRequest() async {
    if (descriptionController.text.isNotEmpty) {
      final newRequest = ClientRequest(
        title: titleController.text,
        description: descriptionController.text,
        createdAt: DateTime.now(),
      );

      var client = HttpService();
      final createRequest = await client.createRequest(titleController.text, descriptionController.text, _image);

      setState(() {
        ClientConsiderRequestPage.requests.add(newRequest);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Заявка отправлена на рассмотрение')),
      );

      // Clear the form
      descriptionController.clear();
      commentController.clear();
      houseNumberController.clear();
      apartmentNumberController.clear();
      setState(() {
        _image = null;
        selectedCountry = null;
        selectedRegion = null;
        selectedCity = null;
        selectedDistrict = null;
        selectedMicrodistrict = null;
        selectedStreet = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, введите описание заявки')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Создать заявку"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Тема вашей заявки",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Введите тему заявки",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Описание вашей заявки",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Введите описание заявки",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Прикрепить фото",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _image == null
                      ? Text("Фото не выбрано", textAlign: TextAlign.center)
                      : Image.file(_image!, height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.photo_library, color: Colors.teal),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.teal),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _submitRequest,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Отправить заявку на рассмотрение",
                      style: TextStyle(fontSize: 16),
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

  Widget _buildDropdown(String labelText, String? value, ValueChanged<String?> onChanged, List<String> items) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
