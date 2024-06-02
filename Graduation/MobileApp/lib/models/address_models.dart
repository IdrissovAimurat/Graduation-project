// models/address_models.dart
class Country {
  final int id;
  final String countriesName;

  Country({
    required this.id,
    required this.countriesName,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      countriesName: json['countriesName'],
    );
  }
}

class Region {
  final int id;
  final String regionsName;

  Region({
    required this.id,
    required this.regionsName,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      regionsName: json['regionsName'],
    );
  }
}

class City {
  final int id;
  final String citiesName;

  City({
    required this.id,
    required this.citiesName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      citiesName: json['citiesName'],
    );
  }
}
