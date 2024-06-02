import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../Api/endpoints.dart';
import '../Api/http_client.dart';
import '../Api/token_storage.dart';
import '../models/client_models.dart';
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

    var requestsJson = await client.get(Endpoints.getByUserGuid
        .replaceFirst("{userGuid}", userGuid)
        .replaceFirst("{UserRoleName}", userRole));

    if (requestsJson != null) {
      setState(() {
        ClientRequestsPage.requests = requestsJson
            .map<ClientRequest>((json) => ClientRequest.fromJson(json))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мои заявки"),
        backgroundColor: Colors.teal,
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
          return _buildRequestCard(ClientRequestsPage.requests[index]);
        },
      ),
    );
  }

  Widget _buildRequestCard(ClientRequest request) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () => _navigateToDetailPage(request),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.work, color: Colors.teal, size: 40),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      request.title!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      request.description!,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat('yyyy-MM-dd – kk:mm')
                          .format(request.createdAt!),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSort() {
    setState(() {
      if (isSorted) {
        ClientRequestsPage.requests
            .sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      } else {
        ClientRequestsPage.requests
            .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
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
