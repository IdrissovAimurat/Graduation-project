import 'package:flutter/material.dart';
import 'package:graduation/Worker_menu/requests_page.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'client_models.dart';
import 'client_requests_page.dart';

class ClientRequestDetailPage extends StatefulWidget {
  final ClientRequest request;

  ClientRequestDetailPage({required this.request});

  @override
  _ClientRequestDetailPageState createState() => _ClientRequestDetailPageState();
}

class _ClientRequestDetailPageState extends State<ClientRequestDetailPage> {
  File? _image;
  File? _video;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  void _submitWork() {
    if (_image != null || _video != null) {
      setState(() {
        bool removed = ClientRequestsPage.requests.remove(widget.request);
        if (removed) {
          print("Request was removed successfully");
        } else {
          print("Request was not found");
        }
        Navigator.pop(context, true);  // Возвращает true, если изменения были сделаны
      });
    }
  }

  void requestManageExternalStoragePermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      bool isPermanentlyDenied = await Permission.manageExternalStorage.isPermanentlyDenied;
      if (isPermanentlyDenied) {
        openAppSettings(); // Открыть настройки приложения для пользователя
      } else {
        // Запросить разрешение
        await Permission.manageExternalStorage.request();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request.type),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Тип услуги: ${widget.request.type}", style: TextStyle(fontSize: 18)),
              Text("Адрес: ${widget.request.address}", style: TextStyle(fontSize: 18)),
              Text("Дата и время: ${DateFormat('yyyy-MM-dd – kk:mm').format(widget.request.dateTime)}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo_camera),
                    onPressed: _takePhoto,
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_library),
                    onPressed: _pickImage,
                  ),
                  IconButton(
                    icon: Icon(Icons.videocam),
                    onPressed: _pickVideo,
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_image != null) Image.file(_image!),
              if (_video != null) Text("Видеофайл прикреплён."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (_image != null || _video != null) ? _submitWork : null,
                child: Center(
                    child: Text("Сдать"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
