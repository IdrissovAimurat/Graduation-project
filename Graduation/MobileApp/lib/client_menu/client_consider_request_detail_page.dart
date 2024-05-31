import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../models/client_models.dart';
import 'client_consider_request_page.dart';

class ClientConsiderRequestDetailPage extends StatefulWidget {
  final ClientRequest request;

  ClientConsiderRequestDetailPage({required this.request});

  @override
  _ClientConsiderRequestDetailPage createState() => _ClientConsiderRequestDetailPage();
}

class _ClientConsiderRequestDetailPage extends State<ClientConsiderRequestDetailPage> {
  void _deleteRequest() {
    setState(() {
      ClientConsiderRequestPage.requests.remove(widget.request);
      Navigator.pop(context, true);  // Возвращает true, если изменения были сделаны
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request.title!),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteRequest,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Тип услуги: ${widget.request.title!}", style: TextStyle(fontSize: 18)),
              Text("Адрес: ${widget.request.description!}", style: TextStyle(fontSize: 18)),
              Text("Дата и время: ${DateFormat('yyyy-MM-dd – kk:mm').format(widget.request.createdAt!)}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              if (widget.request.imagePaths![0] != null)
                Image.network(widget.request.imagePaths![0]),
              if (widget.request.description != null)
                Text("Комментарий: ${widget.request.description}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
