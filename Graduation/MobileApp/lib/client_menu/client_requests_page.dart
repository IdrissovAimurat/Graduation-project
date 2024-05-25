import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/client_models.dart';
import 'client_new_requests_page.dart';
import 'client_request_detail_page.dart';

class ClientRequestsPage extends StatefulWidget {
  static List<ClientRequest> requests = [
    ClientRequest(type: "Уборка", address: "ул. Ленина, 12", dateTime: DateTime.now().subtract(Duration(days: 50))),
    ClientRequest(type: "Ремонт", address: "ул. Байтурсынова, 8", dateTime: DateTime.now().subtract(Duration(days: 45))),
    ClientRequest(type: "Лампу поменять", address: "ул. Сейфуллина, 12", dateTime: DateTime.now().subtract(Duration(days: 47))),
  ];  // Инициализация пустым списком

  @override
  _ClientRequestsPageState createState() => _ClientRequestsPageState();
}

class _ClientRequestsPageState extends State<ClientRequestsPage> {
  bool isSorted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои заявки"),
        actions: [
          IconButton(
            icon: Icon(isSorted ? Icons.undo : Icons.sort),
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ClientRequestsPage.requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.work),
            title: Text(ClientRequestsPage.requests[index].type),
            subtitle: Text(
                "${ClientRequestsPage.requests[index].address} - ${DateFormat('yyyy-MM-dd – kk:mm').format(ClientRequestsPage.requests[index].dateTime)}"),
            onTap: () => _navigateToDetailPage(ClientRequestsPage.requests[index]),
          );
        },
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        ClientRequestsPage.requests.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      } else {
        ClientRequestsPage.requests.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      isSorted = !isSorted;
    });
  }

  void _navigateToDetailPage(ClientRequest request) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ClientRequestDetailPage(request: request),
    ));
  }
}
