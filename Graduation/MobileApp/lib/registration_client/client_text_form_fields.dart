// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class ClientNameField extends StatelessWidget {
  final TextEditingController controller;

  const ClientNameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Имя",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите ваше ФИО';
          }
          return null;
        },
      ),
    );
  }
}

class ClientSurnameField extends StatelessWidget {
  final TextEditingController controller;

  const ClientSurnameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Фамилия",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите вашу фамилию ';
          }
          return null;
        },
      ),
    );
  }
}

class ClientPatronymicField extends StatelessWidget {
  final TextEditingController controller;

  const ClientPatronymicField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Отчество",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите ваше отчество';
          }
          return null;
        },
      ),
    );
  }
}

class ClientAddressField extends StatelessWidget {
  final TextEditingController controller;

  const ClientAddressField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Адрес",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите ваш адрес';
          }
          return null;
        },
      ),
    );
  }
}

// class EmailField extends StatelessWidget {
//   final TextEditingController controller;
//
//   const EmailField({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: "Почта",
//           border: OutlineInputBorder(
//             borderSide: BorderSide(),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty || !value.contains('@')) {
//             return 'Введите корректный адрес электронной почты';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }

class ClientLoginField extends StatelessWidget {
  final TextEditingController controller;

  const ClientLoginField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Логин",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
  }
}

class ClientPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const ClientPasswordField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Пароль",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
    );
  }
}
