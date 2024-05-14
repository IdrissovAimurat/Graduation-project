import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class ClientPhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const ClientPhoneNumberField({Key? key, required this.controller}) : super(key: key);

  @override
  _ClientPhoneNumberFieldState createState() => _ClientPhoneNumberFieldState();
}

  class _ClientPhoneNumberFieldState extends State<ClientPhoneNumberField> {

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: "Номер телефона",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )
      ),
        initialCountryCode: 'KZ', //QAZAQSTAN

    );
  }
}