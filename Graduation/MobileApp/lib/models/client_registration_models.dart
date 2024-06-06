class ClientRegistrationRequest {
  String? email;
  String? password;
  String? userName;
  String? userRoleName;

  ClientRegistrationRequest({
    this.email,
    this.password,
    this.userName,
    this.userRoleName,
  });

  factory ClientRegistrationRequest.fromJson(Map<String, dynamic> json) {
    return ClientRegistrationRequest(
      email: json['email'] as String?,
      password: json['password'] as String?,
      userName: json['userName'] as String?,
      userRoleName: json['userRoleName'] as String?,
    );
  }
}

class ClientRegistrationInfoRequest {
  int? userId;
  String? surname;
  String? name;
  String? birthDate;
  String? phoneNumber;
  String? identityNumberKZT;

  ClientRegistrationInfoRequest({
    this.userId,
    this.surname,
    this.name,
    this.birthDate,
    this.phoneNumber,
    this.identityNumberKZT,
  });
  factory ClientRegistrationInfoRequest.fromJson(Map<String, dynamic> json) {
    return ClientRegistrationInfoRequest(
      userId: json['userId'] as int?,
      surname: json['surname'] as String?,
      name: json['name'] as String?,
      birthDate: json['birthDate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      identityNumberKZT: json['identityNumberKZT'] as String?,
    );
  }
}

class ClientRegistrationAdressRequest {
  int? userId;
  int? microDistrictsId;
  int? streetsId;
  String? houseNumber;
  String? apartmentNumber;

  ClientRegistrationAdressRequest({
    this.userId,
    this.microDistrictsId,
    this.streetsId,
    this.houseNumber,
    this.apartmentNumber,
  });

  factory ClientRegistrationAdressRequest.fromJson(Map<String, dynamic> json) {
    return ClientRegistrationAdressRequest(
      userId: json['userId'] as int?,
      microDistrictsId: json['microDistrictsId'] as int?,
      streetsId: json['streetsId'] as int?,
      houseNumber: json['houseNumber'] as String?,
      apartmentNumber: json['apartmentNumber'] as String?,
    );
  }
}