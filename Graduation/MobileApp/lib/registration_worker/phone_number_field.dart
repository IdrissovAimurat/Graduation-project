import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';



class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumberField({Key? key, required this.controller}) : super(key: key);

  @override
  _PhoneNumberFieldState createState() => _PhoneNumberFieldState();
}

  class _PhoneNumberFieldState extends State<PhoneNumberField> {

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