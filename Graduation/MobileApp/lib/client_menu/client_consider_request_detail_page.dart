import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'client_models.dart';
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
        title: Text(widget.request.type),
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
