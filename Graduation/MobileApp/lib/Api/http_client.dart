import 'dart:io';

import 'package:graduation/Api/endpoints.dart';
import 'package:graduation/Api/token_storage.dart';
import 'package:graduation/models/worker_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/address_models.dart';
import '../models/request.dart';

class HttpService {
  final String baseUrl = Endpoints.baseUrl;
  final TokenStorage _tokenStorage = TokenStorage();

  Future<dynamic> authorization(dynamic data) async {
    try {
      var result = await post(Endpoints.login,
          {'email': data['email'], 'password': data['password']});
      await _tokenStorage.saveAccessToken(result['accessToken']);
      await _tokenStorage.saveRefreshToken(result['refreshToken']);
      return true;
    }
    catch (e) {
      return false;
    }
  }

  Future<bool> createRequest(String title, String description,
      File? file) async {
    try {
      var uri = Uri.parse('$baseUrl${Endpoints.createApplication}');
      var request = http.MultipartRequest('POST', uri);
      request.fields['Title'] = title;
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

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      var response = await request.send();
      if (response.statusCode == 200) {
        print("Успешно отправлено");
        return true;
      } else {
        print("Ошибка: ${response.statusCode}");
        print("Причина: ${await response.stream.bytesToString()}");
        return false;
      }
    } catch (e) {
      print("Исключение: $e");
      return false;
    }
  }

  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse('$baseUrl/api/countries'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Country.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка при получении списка стран');
    }
  }

  Future<List<Region>> fetchRegions(int countryId) async {
    final response = await http.get(
        Uri.parse('$baseUrl/api/region/$countryId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Region.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка при получении списка областей');
    }
  }
  Future<void> updateRequestStatus(int applicationId, int statusesId) async {
    final uri = Uri.parse('$baseUrl/api/application/updatestate');
    var token = await _tokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Добавляем токен в заголовок
      },
      body: json.encode({
        'applicationId': applicationId,
        'statusesId': statusesId,
        'HandlerPersonGuid': decodedToken['UserGuid'],
        'handlerPersonRoleName': decodedToken['UserRoleName'], // Обновлено для корректного значения
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при обновлении статуса заявки');
    }
  }

  Future<List<City>> fetchCities(int regionId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/cities/$regionId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => City.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка при получении списка городов');
    }
  }

  Future<List<WorkerRequest>> fetchRequestsByCity(int cityId,
      String userRoleName) async {
    final uri = Uri.parse('$baseUrl/api/application/getAllByCity')
        .replace(queryParameters: {
      'CityId': cityId.toString(),
      'UserRoleName': userRoleName,
    });

    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => WorkerRequest.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка при получении данных');
    }
  }

  Future<dynamic> registration(String email, String password) async {
    var result = await post(
        Endpoints.register, {'email': email, 'password': password});
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

  Future<http.Response> _sendRequest(String method, Uri url,
      {dynamic body}) async {
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
