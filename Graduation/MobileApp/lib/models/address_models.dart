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
class Districts {
  final int id;
  final String districtsName;

  Districts({
    required this.id,
    required this.districtsName,
  });

  factory Districts.fromJson(Map<String, dynamic> json) {
    return Districts(
      id: json['id'],
      districtsName: json['districtsName'],
    );
  }
}
class MicroDistricts {
  final int id;
  final String microDistrictsName;

  MicroDistricts({
    required this.id,
    required this.microDistrictsName,
  });

  factory MicroDistricts.fromJson(Map<String, dynamic> json) {
    return MicroDistricts(
      id: json['id'],
      microDistrictsName: json['microDistrictsName'],
    );
  }
}
class Streets {
  final int id;
  final String streetsName;

  Streets({
    required this.id,
    required this.streetsName,
  });

  factory Streets.fromJson(Map<String, dynamic> json) {
    return Streets(
      id: json['id'],
      streetsName: json['streetsName'],
    );
  }
}