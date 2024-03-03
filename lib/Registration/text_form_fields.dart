import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;

  const NameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: "ФИО",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите ваше ФИО';
        }
        return null;
      },
    );
  }
}

class AddressField extends StatelessWidget {
  final TextEditingController controller;

  const AddressField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: "Адрес",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Введите ваш адрес';
        }
        return null;
      },
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: "Почта",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return 'Введите корректный адрес электронной почты';
        }
        return null;
      },
    );
  }
}
