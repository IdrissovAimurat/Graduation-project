import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/client_models.dart'; // Не забудьте добавить пакет intl в pubspec.yaml

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
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetailCard(
                icon: Icons.assignment,
                title: "Тип услуги",
                content: widget.request.title!,
              ),
              SizedBox(height: 10),
              _buildDetailCard(
                icon: Icons.description,
                title: "Описание",
                content: widget.request.description ?? 'Нет описания',
              ),
              SizedBox(height: 10),
              _buildDetailCard(
                icon: Icons.calendar_today,
                title: "Дата и время",
                content: DateFormat('yyyy-MM-dd – kk:mm').format(widget.request.createdAt!),
              ),
              SizedBox(height: 20),
              if (widget.request.imagePaths != null && widget.request.imagePaths!.isNotEmpty)
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Прикрепленные изображения",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(widget.request.imagePaths![0]),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String content}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: Colors.teal, size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
