import 'dart:convert';

class ClientRequest {
  String? title;
  String? description;
  int? statusesId;
  int? clientId;
  int? citiesId;
  int? moderatorId;
  int? employeeId;
  DateTime? createdAt;
  DateTime? lastModifiedAt;
  Status? statuses;
  List<String>? imagePaths;

  ClientRequest({
    this.title,
    this.description,
    this.statusesId,
    this.clientId,
    this.citiesId,
    this.moderatorId,
    this.employeeId,
    this.createdAt,
    this.lastModifiedAt,
    this.statuses,
    this.imagePaths,
  });

  factory ClientRequest.fromJson(Map<String, dynamic> json) {
    try {
      final String? title = json['title'];
      final String? description = json['description'];
      final int? statusesId = json['statusesId'];
      final int? clientId = json['clientId'];
      final int? citiesId = json['citiesId'];
      final int? moderatorId = json['moderatorId'];
      final int? employeeId = json['employeeId'];
      final DateTime? createdAt = json['createdAt'] != null ? DateTime.parse(
          json['createdAt']) : null;
      final DateTime? lastModifiedAt = json['lastModifiedAt'] != null ? DateTime
          .parse(json['lastModifiedAt']) : null;
      final Status? statuses = json['statuses'] != null ? Status.fromJson(
          json['statuses']) : null;
      final List<String>? imagePaths = json['imagePaths'] != null ? List<
          String>.from(json['imagePaths']) : null;
      return ClientRequest(
        title: title,
        description: description,
        statusesId: statusesId,
        clientId: clientId,
        citiesId: citiesId,
        moderatorId: moderatorId,
        employeeId: employeeId,
        createdAt: createdAt,
        lastModifiedAt: lastModifiedAt,
        statuses: statuses,
        imagePaths: imagePaths,
      );
    }
    catch (e){
      print('ss');
    }
    return ClientRequest();
  }

}

class Status {
  int? id;
  String? statusesName;

  Status({
    this.id,
    this.statusesName,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      statusesName: json['statusesName'],
    );
  }
}