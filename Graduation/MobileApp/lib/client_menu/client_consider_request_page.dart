import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'client_consider_request_detail_page.dart';
import 'client_models.dart';
import 'client_requests_page.dart';

class ClientConsiderRequestPage extends StatefulWidget {
  static List<ClientRequest> requests = [];

  @override
  _ClientConsiderRequestPageState createState() => _ClientConsiderRequestPageState();
}

class _ClientConsiderRequestPageState extends State<ClientConsiderRequestPage> {
  bool isSorted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои заявки, которые на рассмотрении"),
        actions: [
          IconButton(
            icon: Icon(isSorted ? Icons.undo : Icons.sort),
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ClientConsiderRequestPage.requests.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => _showTransferDialog(context, ClientConsiderRequestPage.requests[index]),
            child: ListTile(
              leading: Icon(Icons.work),
              title: Text(ClientConsiderRequestPage.requests[index].type),
              subtitle: Text(
                "${ClientConsiderRequestPage.requests[index].address} - ${DateFormat('yyyy-MM-dd – kk:mm').format(ClientConsiderRequestPage.requests[index].dateTime)}",
              ),
              onTap: () => _navigateToDetailPage(ClientConsiderRequestPage.requests[index]),
            ),
          );
        },
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        ClientConsiderRequestPage.requests.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      } else {
        ClientConsiderRequestPage.requests.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      }
      isSorted = !isSorted;
    });
  }

  void _navigateToDetailPage(ClientRequest request) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ClientConsiderRequestDetailPage(request: request),
    )).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }

  void _showTransferDialog(BuildContext context, ClientRequest request) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Перенести данную заявку?"),
          content: Text("Вы хотите перенести эту заявку?"),
          actions: <Widget>[
            TextButton(
              child: Text("Нет"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Да"),
              onPressed: () {
                setState(() {
                  ClientRequestsPage.requests.add(request);
                  ClientConsiderRequestPage.requests.remove(request);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
