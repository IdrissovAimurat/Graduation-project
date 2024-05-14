import 'package:flutter/material.dart';
import 'package:graduation/Worker_menu/request_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';

class RequestsPage extends StatefulWidget {
  static List<Request> requests = [
    Request(type: "Уборка", address: "ул. Ленина, 12", dateTime: DateTime.now().subtract(Duration(days: 50))),
    Request(type: "Ремонт", address: "ул. Байтурсынова, 8", dateTime: DateTime.now().subtract(Duration(days: 45))),
    Request(type: "Лампу поменять", address: "ул. Сейфуллина, 12", dateTime: DateTime.now().subtract(Duration(days: 47))),
    Request(type: "Убрать мусор", address: "ул. Сатпаева, 8", dateTime: DateTime.now().subtract(Duration(days: 52))),
    Request(type: "Почистить двор", address: "ул. Макатаева, 12", dateTime: DateTime.now().subtract(Duration(days: 60))),
    Request(type: "Починить домофон", address: "ул. Гоголя, 8", dateTime: DateTime.now().subtract(Duration(days: 60))),
  ];  // Используйте этот список для работы с данными
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
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
        itemCount: RequestsPage.requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.work),
            title: Text(RequestsPage.requests[index].type),
            subtitle: Text(
                "${RequestsPage.requests[index].address} - ${DateFormat(
                    'yyyy-MM-dd – kk:mm').format(
                    RequestsPage.requests[index].dateTime)}"),
            onTap: () => _navigateToDetailPage(RequestsPage.requests[index]),
          );
        },
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        RequestsPage.requests.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      } else {
        RequestsPage.requests.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      isSorted = !isSorted;
    });
  }

  void _navigateToDetailPage(Request request) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RequestDetailPage(request: request),
    )).then((value) {
      // Проверяем, вернулась ли страница с изменениями
      if (value == true) {
        setState(() {}); // Принудительное обновление состояния для отображения изменений
      }
    });
  }
}