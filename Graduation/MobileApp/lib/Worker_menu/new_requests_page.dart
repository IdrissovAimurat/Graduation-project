import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';
import 'requests_page.dart';  // Убедитесь, что импорт указывает на правильный файл

class NewRequestsPage extends StatefulWidget {
  @override
  _NewRequestsPageState createState() => _NewRequestsPageState();
}

class _NewRequestsPageState extends State<NewRequestsPage> {
  List<Request> newRequests = [
    Request(type: "Установка окон", address: "ул. Пушкина, 12", dateTime: DateTime.now()),
    Request(type: "Покраска забора", address: "ул. Колотушкина, 33", dateTime: DateTime.now()),
    Request(type: "Уборка снега", address: "ул. Лермонтова, 50", dateTime: DateTime.now()),
    Request(type: "Монтаж розеток", address: "ул. Чехова, 15", dateTime: DateTime.now()),
    Request(type: "Ремонт крыши", address: "ул. Гоголя, 25", dateTime: DateTime.now()),
    Request(type: "Посадка деревьев", address: "ул. Лесная, 7", dateTime: DateTime.now()),
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
                  RequestsPage.requests.add(newRequests[index]);  // Добавление в глобальный список
                  newRequests.removeAt(index);  // Удаление из списка новых заявок
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
        itemCount: newRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newRequests[index].type),
            subtitle: Text("${newRequests[index].address} - ${DateFormat('yyyy-MM-dd – kk:mm').format(newRequests[index].dateTime)}"),
            onTap: () => _showConfirmationDialog(index),
          );
        },
      ),
    );
  }
}