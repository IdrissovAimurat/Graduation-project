import 'package:flutter/material.dart';
class Request {
  String type;
  String address;
  DateTime dateTime;

  Request({required this.type, required this.address, required this.dateTime});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Request &&
        other.type == type &&
        other.address == address &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => type.hashCode ^ address.hashCode ^ dateTime.hashCode;
}