class WorkerRequest {
  int? id; // Добавляем это поле
  String? title;
  String? description;
  int? statusesId;
  int? workerId;
  int? citiesId;
  int? moderatorId;
  int? employeeId;
  DateTime? createdAt;
  DateTime? lastModifiedAt;
  Status? statuses;
  List<String>? imagePaths;

  WorkerRequest({
    this.id, // Добавляем это поле
    this.title,
    this.description,
    this.statusesId,
    this.workerId,
    this.citiesId,
    this.moderatorId,
    this.employeeId,
    this.createdAt,
    this.lastModifiedAt,
    this.statuses,
    this.imagePaths,
  });

  factory WorkerRequest.fromJson(Map<String, dynamic> json) {
    return WorkerRequest(
      id: json['id'], // Добавляем это поле
      title: json['title'],
      description: json['description'],
      statusesId: json['statusesId'],
      workerId: json['workerId'],
      citiesId: json['citiesId'],
      moderatorId: json['moderatorId'],
      employeeId: json['employeeId'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      lastModifiedAt: json['lastModifiedAt'] != null ? DateTime.parse(json['lastModifiedAt']) : null,
      statuses: json['statuses'] != null ? Status.fromJson(json['statuses']) : null,
      imagePaths: json['imagePaths'] != null ? List<String>.from(json['imagePaths']) : null,
    );
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
