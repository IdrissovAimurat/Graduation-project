import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'client_models.dart';
import 'client_requests_page.dart';  // Убедитесь, что импорт указывает на правильный файл

class ClientNewRequestsPage extends StatefulWidget {
  @override
  _ClientNewRequestsPageState createState() => _ClientNewRequestsPageState();
}

class _ClientNewRequestsPageState extends State<ClientNewRequestsPage> {
  List<ClientRequest> clientNewRequests = [
    ClientRequest(type: "Монтаж розеток", address: "ул. Чехова, 15", dateTime: DateTime.now()),
    ClientRequest(type: "Ремонт крыши", address: "ул. Гоголя, 25", dateTime: DateTime.now()),
    ClientRequest(type: "Посадка деревьев", address: "ул. Лесная, 7", dateTime: DateTime.now()),
    // Остальные заявки
  ];

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Взять в работу?"),
          content: Text("Вы хотите взять эту заявку в работу?"),
          actions: <Widget>[
            TextButton(
              child: Text("Нет"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Да"),
              onPressed: () {
                setState(() {
                  ClientRequestsPage.requests.add(clientNewRequests[index]);  // Добавление в глобальный список
                  clientNewRequests.removeAt(index);  // Удаление из списка новых заявок
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Входящие заявки"),
      ),
      body: ListView.builder(
        itemCount: clientNewRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(clientNewRequests[index].type),
            subtitle: Text("${clientNewRequests[index].address} - ${DateFormat('yyyy-MM-dd – kk:mm').format(clientNewRequests[index].dateTime)}"),
            onTap: () => _showConfirmationDialog(index),
          );
        },
      ),
    );
  }
}