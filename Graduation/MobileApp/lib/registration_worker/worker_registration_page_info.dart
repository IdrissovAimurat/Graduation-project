import 'package:flutter/material.dart';
import 'package:graduation/models/address_models.dart';
import 'package:intl/intl.dart';
import '../Api/http_client.dart';
import '../Authorization/login_client_page.dart';
import '../models/client_registration_models.dart';

// Класс для хранения состояния страницы регистрации
class WorkerRegistrationPageInfoState extends ChangeNotifier {
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController numberOfHouseController = TextEditingController();
  TextEditingController numberOfApartmentController = TextEditingController();

  @override
  void dispose() {
    surnameController.dispose();
    nameController.dispose();
    birthDateController.dispose();
    phoneNumberController.dispose();
    identityNumberController.dispose();
    numberOfHouseController.dispose();
    numberOfApartmentController.dispose();
    super.dispose();
  }
}

class WorkerRegistrationPageInfo extends StatefulWidget {
  final int userId;
  WorkerRegistrationPageInfo({required this.userId});
  @override
  _WorkerRegistrationPageInfoState createState() => _WorkerRegistrationPageInfoState();
}

class _WorkerRegistrationPageInfoState extends State<WorkerRegistrationPageInfo> {
  WorkerRegistrationPageInfoState _workerRegistrationPageInfoState = WorkerRegistrationPageInfoState();
  int? _selectedMicroDistrictsId;
  int? _selectedStreetsId;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _workerRegistrationPageInfoState.birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _submitRequest() async {
    final newRequest = ClientRegistrationInfoRequest(
      userId: widget.userId,
      surname: _workerRegistrationPageInfoState.surnameController.text,
      name: _workerRegistrationPageInfoState.nameController.text,
      birthDate: _workerRegistrationPageInfoState.birthDateController.text,
      phoneNumber: _workerRegistrationPageInfoState.phoneNumberController.text,
      identityNumberKZT: _workerRegistrationPageInfoState.identityNumberController.text,
    );

    final newAddressRequest = ClientRegistrationAdressRequest(
      userId: widget.userId,
      microDistrictsId: _selectedMicroDistrictsId!,
      streetsId: _selectedStreetsId!,
      houseNumber: _workerRegistrationPageInfoState.numberOfHouseController.text,
      apartmentNumber: _workerRegistrationPageInfoState.numberOfApartmentController.text,
    );

    try {
      var client = HttpService();
      final resultOfUserInfo = await client.insertUserInfo(newRequest);
      final resultOfAddress = await client.insertAddressInfo(newAddressRequest);
      print('Added user info: $resultOfUserInfo');
      print('Added user address info: $resultOfAddress');
      // Показываем уведомление об успешной регистрации
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Данные успешно заполнены, пожалуйста авторизуйтесь!')),
      );

      // Переход на страницу логина
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginClientPage()),
      );

    } catch (e) {
      print('Error adding user info: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding user info: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal.shade900,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.teal.shade900),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal.shade900),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fill in the details'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade900,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 16.0),
                Image.asset(
                  'assets/images/ui-design.png',
                  height: 120,
                ),
                SizedBox(height: 40.0),
                _buildTextField(
                  context,
                  icon: Icons.person,
                  label: 'Фамилия',
                  controller: _workerRegistrationPageInfoState.surnameController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.person_outline,
                  label: 'Имя',
                  controller: _workerRegistrationPageInfoState.nameController,
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _workerRegistrationPageInfoState.birthDateController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Дата рождения',
                  ),
                  onTap: () => _selectDate(context),
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.phone,
                  label: 'Номер телефона',
                  controller: _workerRegistrationPageInfoState.phoneNumberController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'ИИН',
                  controller: _workerRegistrationPageInfoState.identityNumberController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.holiday_village_rounded,
                  label: 'Номер дома',
                  controller: _workerRegistrationPageInfoState.numberOfHouseController,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  context,
                  icon: Icons.door_back_door,
                  label: 'Номер квартиры',
                  controller: _workerRegistrationPageInfoState.numberOfApartmentController,
                ),
                SizedBox(height: 16.0),
                _buildRegisterButton(
                  context,
                  title: 'Выбрать адрес',
                  onPressed: () async {
                    final result = await showDialog<Map<String, int>>(
                      context: context,
                      builder: (BuildContext context) {
                        return CitySelectorDialog();
                      },
                    );
                    if (result != null) {
                      print("MicroDistrict ID: ${result['microDistrictId']}, Street ID: ${result['streetId']}");
                      setState(() {
                        _selectedMicroDistrictsId = result['microDistrictId'];
                        _selectedStreetsId = result['streetId'];
                      });
                    }
                  },
                ),
                SizedBox(height: 16.0),
                _buildRegisterButton(
                  context,
                  title: 'Регистрация',
                  onPressed: _submitRequest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required IconData icon, required String label, required TextEditingController controller, VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal.shade900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildRegisterButton(BuildContext context, {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.teal.shade900,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
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
  List<Districts> districts = [];
  List<MicroDistricts> microDistricts = [];
  List<Streets> streets = [];

  int? selectedCountry;
  int? selectedRegion;
  int? selectedCity;
  int? selectedDistricts;
  int? selectedMicroDistricts;
  int? selectedStreets;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchCountriesReq();
  }
  Future<void> _fetchCountriesReq() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchedCountriesReq = await httpService.fetchCountries();
      setState(() {
        countries = fetchedCountriesReq;
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
  Future<void> _fetchDistricts(int cityId) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchDistricts = await httpService.fetchDistricts(cityId);
      setState(() {
        districts = fetchDistricts;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка районов';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _fetchMicroDisricts(int DistrictId) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchMicroDisricts = await httpService.fetchMicroDistricts(DistrictId);
      setState(() {
        microDistricts = fetchMicroDisricts;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка районов';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> _fetchStreets(int DistrictId) async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      HttpService httpService = HttpService();
      final fetchStreets = await httpService.fetchStreets(DistrictId);
      setState(() {
        streets = fetchStreets;
      });
    } catch (e) {
      setState(() {
        error = 'Ошибка при получении списка улиц';
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
          : SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите страну"),
                value: selectedCountry,
                isExpanded: true,  // Ensure dropdown takes full width
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
                    districts = [];
                    microDistricts = [];
                    streets = [];
                  });
                  if (value != null) {
                    _fetchRegions(value);
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите область"),
                value: selectedRegion,
                isExpanded: true,  // Ensure dropdown takes full width
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
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите город"),
                value: selectedCity,
                isExpanded: true,  // Ensure dropdown takes full width
                items: cities.map((city) {
                  return DropdownMenuItem<int>(
                    value: city.id,
                    child: Text(city.citiesName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                    selectedDistricts = null;
                    districts = [];
                  });
                  if (value != null) {
                    _fetchDistricts(value);
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите район"),
                value: selectedDistricts,
                isExpanded: true,  // Ensure dropdown takes full width
                items: districts.map((district) {
                  return DropdownMenuItem<int>(
                    value: district.id,
                    child: Text(district.districtsName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDistricts = value;
                    selectedMicroDistricts = null;
                    microDistricts = [];
                  });
                  if (value != null) {
                    _fetchMicroDisricts(value);
                    _fetchStreets(value);
                  }
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите микрорайон"),
                value: selectedMicroDistricts,
                isExpanded: true,  // Ensure dropdown takes full width
                items: microDistricts.map((microDistrict) {
                  return DropdownMenuItem<int>(
                    value: microDistrict.id,
                    child: Text(microDistrict.microDistrictsName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMicroDistricts = value;
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: DropdownButton<int>(
                hint: Text("Выберите улицу"),
                value: selectedStreets,
                isExpanded: true,  // Ensure dropdown takes full width
                items: streets.map((street) {
                  return DropdownMenuItem<int>(
                    value: street.id,
                    child: Text(street.streetsName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStreets = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Отмена"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text("Готово"),
          onPressed: (selectedCity != null && selectedMicroDistricts != null && selectedStreets != null)
              ? () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop<Map<String, int>>({
                'cityId': selectedCity!,
                'microDistrictId': selectedMicroDistricts!,
                'streetId': selectedStreets!
              });
            });
          }
              : null,
        ),
      ],
    );
  }
}
