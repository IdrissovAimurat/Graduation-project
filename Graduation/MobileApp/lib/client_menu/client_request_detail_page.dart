import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import '../models/client_models.dart';

class ClientRequestDetailPage extends StatefulWidget {
  final ClientRequest request;

  ClientRequestDetailPage({required this.request});

  @override
  _ClientRequestDetailPageState createState() => _ClientRequestDetailPageState();
}

class _ClientRequestDetailPageState extends State<ClientRequestDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.request.title!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Тип услуги: ${widget.request.title!}", style: TextStyle(fontSize: 18)),
              Text("дескриптоооооОООООООО: ${widget.request.description}", style: TextStyle(fontSize: 18)),
              Text("Дата и время: ${DateFormat('yyyy-MM-dd – kk:mm').format(widget.request.createdAt!)}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
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
