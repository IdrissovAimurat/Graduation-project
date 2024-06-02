import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/request.dart'; // Убедитесь, что импорт указывает на правильный файл

class RequestsPage extends StatefulWidget {
  static List<Request> requests = [];

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Заявки"),
        backgroundColor: Colors.teal,
      ),
      body: RequestsPage.requests.isEmpty
          ? Center(child: Text('Нет заявок'))
          : ListView.builder(
        itemCount: RequestsPage.requests.length,
        itemBuilder: (context, index) {
          return _buildRequestCard(RequestsPage.requests[index]);
        },
      ),
    );
  }

  Widget _buildRequestCard(Request request) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(Icons.assignment, color: Colors.teal, size: 30),
        title: Text(
          request.type,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text(
          "${request.address} - ${DateFormat('yyyy-MM-dd – kk:mm').format(request.dateTime)}",
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
      ),
    );
  }
}
