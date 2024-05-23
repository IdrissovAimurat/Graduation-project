import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'client_models.dart';

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
              if (widget.request.image != null)
                Image.file(widget.request.image!),
              if (widget.request.comment != null)
                Text("Комментарий: ${widget.request.comment}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
