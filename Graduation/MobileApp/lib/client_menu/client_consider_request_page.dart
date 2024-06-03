import 'package:flutter/material.dart';
import 'package:graduation/Api/http_client.dart';
import 'package:graduation/Api/token_storage.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../Api/endpoints.dart';
import 'client_consider_request_detail_page.dart';
import '../models/client_models.dart';
import 'client_requests_page.dart';

class ClientConsiderRequestPage extends StatefulWidget {
  static List<ClientRequest> requests = [];

  @override
  _ClientConsiderRequestPageState createState() => _ClientConsiderRequestPageState();
}

class _ClientConsiderRequestPageState extends State<ClientConsiderRequestPage> {
  bool isSorted = false;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    var client = HttpService();
    var tokenStorage = TokenStorage();
    var token = await tokenStorage.getAccessToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    var userGuid = decodedToken['UserGuid'];
    var userRole = decodedToken['UserRole'];

    var requestsJson = await client.get(Endpoints.getByUserGuid.replaceFirst("{userGuid}", userGuid)
        .replaceFirst("{UserRoleName}", userRole));

    setState(() {
      // Добавляем тестовые заявки
      ClientConsiderRequestPage.requests = [
        ClientRequest(
          title: 'Тестовая заявка 1',
          description: 'Описание тестовой заявки 1',
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
        ClientRequest(
          title: 'Тестовая заявка 2',
          description: 'Описание тестовой заявки 2',
          createdAt: DateTime.now().subtract(Duration(days: 2)),
        ),
      ];

      // Добавляем реальные заявки
      if (requestsJson != null) {
        ClientConsiderRequestPage.requests.addAll(requestsJson.map((json) => ClientRequest.fromJson(json)).toList());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои заявки, которые на рассмотрении"),
        backgroundColor: Colors.teal.shade900,
        actions: [
          IconButton(
            icon: Icon(isSorted ? Icons.undo : Icons.sort),
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: ClientConsiderRequestPage.requests.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => _showTransferDialog(context, ClientConsiderRequestPage.requests[index]),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.work, color: Colors.teal),
                  title: Text(
                    ClientConsiderRequestPage.requests[index].title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  subtitle: Text(
                    "${ClientConsiderRequestPage.requests[index].description} - ${DateFormat('yyyy-MM-dd – kk:mm').format(ClientConsiderRequestPage.requests[index].createdAt!)}",
                  ),
                  onTap: () => _navigateToDetailPage(ClientConsiderRequestPage.requests[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        ClientConsiderRequestPage.requests.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else {
        ClientConsiderRequestPage.requests.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
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
