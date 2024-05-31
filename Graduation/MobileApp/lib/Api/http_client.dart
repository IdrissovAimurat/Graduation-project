import 'dart:io';

import 'package:graduation/Api/endpoints.dart';
import 'package:graduation/Api/token_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class HttpService {
  final String baseUrl = Endpoints.baseUrl;
  final TokenStorage _tokenStorage = TokenStorage();

  Future<dynamic> authorization(dynamic data) async {
      try {
        var result = await post(Endpoints.login, {'email': data['email'], 'password': data['password']});
        await _tokenStorage.saveAccessToken(result['accessToken']);
        await _tokenStorage.saveRefreshToken(result['refreshToken']);
        return true;
      }
      catch (e){
        return false;
      }
  }

  Future<bool> createRequest(String title, String description, File? file) async {
    try {
      var uri = Uri.parse('$baseUrl${Endpoints.createApplication}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['Title'] = title;
      request.fields['Description'] = description;
      request.fields['Description'] = description;

      var token = await _tokenStorage.getAccessToken();
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

      request.fields['UserGuid'] = decodedToken['UserGuid'];

      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'Files',
          file.path,
          filename: basename(file.path),
        ));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        print("Успешно отправлено");
        return true;
      } else {
        print("Ошибка: ${response.statusCode}");
        return false;
      }
    }
    catch (e){
      return false;
    }
  }

  Future<dynamic> registration(String email, String password) async {
    var result = await post(Endpoints.register, {'email': email, 'password': password});
    await _tokenStorage.saveAccessToken(result['accessToken']);
    await _tokenStorage.saveRefreshToken(result['refreshToken']);
  }

  Future<dynamic> get(String endpoint) async {
    final response = await _sendRequest(
      'GET',
      Uri.parse('$baseUrl$endpoint'),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    dynamic result = json.encode(data);
    String url = '$baseUrl$endpoint';
    final response = await _sendRequest(
      'POST',
      Uri.parse(url),
      body: result,
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await _sendRequest(
      'PUT',
      Uri.parse('$baseUrl$endpoint'),
      body: json.encode(data),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await _sendRequest(
      'DELETE',
      Uri.parse('$baseUrl$endpoint'),
    );
    return _processResponse(response);
  }

  Future<http.Response> _sendRequest(String method, Uri url, {dynamic body}) async {
    var token = await _tokenStorage.getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response;
    switch (method) {
      case 'POST':
        response = await http.post(url, body: body, headers: headers);
        break;
      case 'PUT':
        response = await http.put(url, body: body, headers: headers);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: headers);
        break;
      default:
        response = await http.get(url, headers: headers);
    }

    if (response.statusCode == 401) {
      await _refreshToken();
      return _sendRequest(method, url, body: body);
    }

    return response;
  }

  Future<void> _refreshToken() async {
    var refreshToken = await _tokenStorage.getRefreshToken();
    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      body: json.encode({'refreshToken': refreshToken}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      refreshToken = data['refreshToken'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
