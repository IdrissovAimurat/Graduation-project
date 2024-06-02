// new_requests_page.dart
import 'package:flutter/material.dart';
import 'package:graduation/Worker_menu/request_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/http_client.dart';
import '../models/address_models.dart';
import '../models/worker_models.dart';
import 'requests_page.dart';  // Убедитесь, что импорт указывает на правильный файл

class NewRequestsPage extends StatefulWidget {
  @override
  _NewRequestsPageState createState() => _NewRequestsPageState();
}

class _NewRequestsPageState extends State<NewRequestsPage> {
  List<WorkerRequest> newRequests = [];
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showCitySelector();
    });
  }

  Future<void> _showCitySelector() async {
    final cityId = await showDialog<int>(
      context: context,
      builder: (context) => CitySelectorDialog(),
    );

    if (cityId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userRoleName = 'worker';
      if (userRoleName != null) {
        _loadRequests(cityId, userRoleName);
      } else {
        setState(() {
          error = 'UserRoleName не найден';
        });
      }
    }
  }

  Future<void> _loadRequests(int cityId, String userRoleName) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchedRequests = await httpService.fetchRequestsByCity(cityId, userRoleName);
      setState(() {
        newRequests = fetchedRequests;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении данных';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Входящие заявки"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!))
          : newRequests.isEmpty
          ? Center(child: Text('Нет заявок'))
          : ListView.builder(
        itemCount: newRequests.length,
        itemBuilder: (context, index) {
          return _buildRequestCard(newRequests[index], index);
        },
      ),
    );
  }

  Widget _buildRequestCard(WorkerRequest request, int index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(Icons.assignment, color: Colors.teal, size: 30),
        title: Text(
          request.title ?? 'No title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Text(
          "${request.description ?? 'No description'} - ${request.createdAt != null ? DateFormat('yyyy-MM-dd – kk:mm').format(request.createdAt!) : 'No date'}",
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.teal),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RequestDetailPage(request: request),
        )),
      ),
    );
  }
}

class CitySelectorDialog extends StatefulWidget {
  @override
  _CitySelectorDialogState createState() => _CitySelectorDialogState();
}

class _CitySelectorDialogState extends State<CitySelectorDialog> {
  List<Country> countries = [];
  List<Region> regions = [];
  List<City> cities = [];
  int? selectedCountry;
  int? selectedRegion;
  int? selectedCity;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchedCountries = await httpService.fetchCountries();
      setState(() {
        countries = fetchedCountries;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка стран';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchRegions(int countryId) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchedRegions = await httpService.fetchRegions(countryId);
      setState(() {
        regions = fetchedRegions;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка областей';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchCities(int regionId) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchedCities = await httpService.fetchCities(regionId);
      setState(() {
        cities = fetchedCities;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка городов';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Выберите город"),
      content: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!))
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          DropdownButton<int>(
            hint: Text("Выберите страну"),
            value: selectedCountry,
            items: countries.map((country) {
              return DropdownMenuItem<int>(
                value: country.id,
                child: Text(country.countriesName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountry = value;
                selectedRegion = null;
                selectedCity = null;
                regions = [];
                cities = [];
              });
              if (value != null) {
                _fetchRegions(value);
              }
            },
          ),
          DropdownButton<int>(
            hint: Text("Выберите область"),
            value: selectedRegion,
            items: regions.map((region) {
              return DropdownMenuItem<int>(
                value: region.id,
                child: Text(region.regionsName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedRegion = value;
                selectedCity = null;
                cities = [];
              });
              if (value != null) {
                _fetchCities(value);
              }
            },
          ),
          DropdownButton<int>(
            hint: Text("Выберите город"),
            value: selectedCity,
            items: cities.map((city) {
              return DropdownMenuItem<int>(
                value: city.id,
                child: Text(city.citiesName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Отмена"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("Получить заявки"),
          onPressed: selectedCity != null
              ? () => Navigator.of(context).pop(selectedCity)
              : null,
        ),
      ],
    );
  }
}
