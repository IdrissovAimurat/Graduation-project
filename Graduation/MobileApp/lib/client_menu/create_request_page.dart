import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/client_models.dart';

class CreateRequestPage extends StatefulWidget {
  @override
  _CreateRequestPageState createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitRequest() {
    if (descriptionController.text.isNotEmpty) {
      final newRequest = ClientRequest(
        type: descriptionController.text,
        address: "ул. Неизвестная, 0", // Placeholder address
        dateTime: DateTime.now(),
        comment: commentController.text,
        image: _image,
      );

      Navigator.of(context).pop(newRequest);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Заявка отправлена на рассмотрение')),
      );
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Описание вашей заявки",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              Text(
                "Прикрепить фото",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              _image == null
                  ? Text("Фото не выбрано")
                  : Image.file(_image!, height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: "Комментарий к заявке",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitRequest,
                child: Text("Отправить заявку на рассмотрение"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
