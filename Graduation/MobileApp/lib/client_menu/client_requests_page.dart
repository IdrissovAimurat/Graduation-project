import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../Api/endpoints.dart';
import '../Api/http_client.dart';
import '../Api/token_storage.dart';
import '../models/client_models.dart';
import 'client_new_requests_page.dart';
import 'client_request_detail_page.dart';

class ClientRequestsPage extends StatefulWidget {
  static List<ClientRequest> requests = [];

  @override
  _ClientRequestsPageState createState() => _ClientRequestsPageState();
}

class _ClientRequestsPageState extends State<ClientRequestsPage> {
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

    if (requestsJson != null) {
      setState(() {
        ClientRequestsPage.requests = requestsJson.map<ClientRequest>((json) => ClientRequest.fromJson(json)).toList();
      });
    }
  }

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
            title: Text(ClientRequestsPage.requests[index].title!),
            subtitle: Text(
                "${ClientRequestsPage.requests[index].description!} - ${DateFormat('yyyy-MM-dd – kk:mm').format(ClientRequestsPage.requests[index].createdAt!)}"),
            onTap: () => _navigateToDetailPage(ClientRequestsPage.requests[index]),
          );
        },
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        ClientRequestsPage.requests.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else {
        ClientRequestsPage.requests.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
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
