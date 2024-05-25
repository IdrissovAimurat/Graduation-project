import 'package:flutter/material.dart';

class JobDropdown extends StatelessWidget {
  final String? value;
  final Function(String?) onChanged;

  const JobDropdown({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: "Тип работы",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          )
      ),
      items: <String>['Электрик', 'Сантехник']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
