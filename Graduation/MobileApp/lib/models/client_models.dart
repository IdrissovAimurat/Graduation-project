import 'dart:io';

class ClientRequest {
  String type;
  String address;
  DateTime dateTime;
  String? comment;
  File? image;

  ClientRequest({
    required this.type,
    required this.address,
    required this.dateTime,
    this.comment,
    this.image,
  });
}
